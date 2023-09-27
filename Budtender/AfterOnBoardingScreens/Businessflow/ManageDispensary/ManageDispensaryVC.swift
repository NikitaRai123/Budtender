//
//  ManageDispensaryVC.swift
//  Budtender
//
//  Created by apple on 29/08/23.
//

import UIKit
class ManageDispensaryVC: UIViewController {
    //-------------------------------------------------------------------------------------------------------
    //MARK: Outlets
    
    @IBOutlet weak var manageDispensaryTableView: UITableView!
    
    var viewModel: ManageDispensaryVM?
    
    // MARK: For Edit Dispensary
        var id: Int?
        var image: String?
        var name: String?
        var phone: String?
        var email: String?
        var address: String?
        var country: String?
        var city: String?
        var state: String?
        var postal: String?
        var website: String?
        var license: String?
        var expiration: String?
        var hoursOfOperation: [Dispensorytime]?
    
    //-------------------------------------------------------------------------------------------------------
    //MARK: ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.manageDispensaryTableView.delegate = self
        self.manageDispensaryTableView.dataSource = self
        self.manageDispensaryTableView.register(UINib(nibName: "FavoriteTVCell", bundle: nil), forCellReuseIdentifier: "FavoriteTVCell")
        setViewModel()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.dispensaryListApi(isStatus: "1")
    }
    
    func setViewModel(){
        self.viewModel = ManageDispensaryVM(observer: self)
    }
    
    
    //-------------------------------------------------------------------------------------------------------
    //MARK: TextFieldDelegate
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func addProductAction(_ sender: UIButton) {
        let vc = AddDispensaryVC()
        vc.isSelect = "AddDispensary"
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
//-------------------------------------------------------------------------------------------------------
//MARK: ExtensionTableView
extension ManageDispensaryVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(viewModel?.dispensary?.count ?? 0)
        return viewModel?.dispensary?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteTVCell", for: indexPath) as! FavoriteTVCell
        cell.productImage.setImage(image: viewModel?.dispensary?[indexPath.row].image,placeholder: UIImage(named: "dispensaryPlaceholder"))
        cell.productName.text = viewModel?.dispensary?[indexPath.row].name
        cell.discriptionLabel.text = "\(viewModel?.dispensary?[indexPath.row].address ?? "")\(",")\(viewModel?.dispensary?[indexPath.row].country ?? "")"
        cell.passData(data: (viewModel?.dispensary?[indexPath.row])!)
//        cell.passProductData(data1: (viewModel?.productDetail?[indexPath.row])!)
        cell.favoriteButton.setImage(UIImage(named: "Ic_ThreeDots"), for: .normal)
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = ManageDispensaryDetailVC()
        vc.name = viewModel?.dispensary?[indexPath.row].name
        vc.country = viewModel?.dispensary?[indexPath.row].country
        if let dispensaryTimes = viewModel?.dispensary?[indexPath.row].dispensorytime {
            for time in dispensaryTimes {
                if time.is_switchon == "true" {
                    vc.startTiming = time.state_time
                    vc.endTiming = time.end_time
                    vc.day = time.day_name
                    break
                }
            }
        }
 
        vc.address = viewModel?.dispensary?[indexPath.row].address
        vc.email = viewModel?.dispensary?[indexPath.row].email
        vc.website = viewModel?.dispensary?[indexPath.row].website
        vc.license = viewModel?.dispensary?[indexPath.row].license
        vc.expiration = viewModel?.dispensary?[indexPath.row].expiration
        vc.city = viewModel?.dispensary?[indexPath.row].city
        vc.postal = viewModel?.dispensary?[indexPath.row].postal_code
        vc.state = viewModel?.dispensary?[indexPath.row].state
        vc.phone = viewModel?.dispensary?[indexPath.row].phone_number
        vc.image = viewModel?.dispensary?[indexPath.row].image
        vc.productCount = viewModel?.productDetail?.count
        vc.productModel = viewModel?.productDetail
       
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
//-------------------------------------------------------------------------------------------------------
//MARK: ExtensionActionFromProtocolDelegate

extension ManageDispensaryVC: FavoriteTVCellDelegate{
    func didTapFavoriteButton(button: UIButton, cell: FavoriteTVCell?) {
        let vc = BusinessEditPopUpVC()
        vc.delegate = self
        vc.dispensaryID = cell?.dispensaryData?.id
        self.id = vc.dispensaryID
        vc.image = cell?.dispensaryData?.image
        self.image = vc.image
        vc.name = cell?.dispensaryData?.name
        self.name = vc.name
        vc.phone = cell?.dispensaryData?.phone_number
        self.phone = vc.phone
        vc.email = cell?.dispensaryData?.email
        self.email = vc.email
        vc.address = cell?.dispensaryData?.address
        self.address = vc.address
        vc.country = cell?.dispensaryData?.country
        self.country = vc.country
        vc.city = cell?.dispensaryData?.city
        self.city = vc.city
        vc.state = cell?.dispensaryData?.state
        self.state = vc.state
        vc.postal = cell?.dispensaryData?.postal_code
        self.postal = vc.postal
        vc.website = cell?.dispensaryData?.website
        self.website = vc.website
        vc.license = cell?.dispensaryData?.license
        self.license = vc.license
        vc.expiration = cell?.dispensaryData?.expiration
        self.expiration = vc.expiration
        let hours = cell?.dispensaryData?.dispensorytime
        
        vc.hoursOfOperation = cell?.dispensaryData?.dispensorytime
        self.hoursOfOperation = vc.hoursOfOperation
        vc.modalPresentationStyle = .overFullScreen
        self.navigationController?.present(vc, true)
    }
    
//    func didTapFavoriteButton(button: UIButton) {
//        let vc = BusinessEditPopUpVC()
//        vc.modalPresentationStyle = .overFullScreen
//        vc.delegate = self
//        self.navigationController?.present(vc, true)
//    }
}

extension ManageDispensaryVC: BusinessEditPopUpVCDelegate{
    func didTapdeleteButton(_ button: UIButton, dispensaryID: Int) {
        dismiss(animated: true)
        let vc = DeletePopUpVC()
        vc.delegate = self
        vc.dispensaryID = dispensaryID
        vc.modalPresentationStyle = .overFullScreen
        self.navigationController?.present(vc, true)
    }
    
    func didTapeditButton(_ button: UIButton) {
        dismiss(animated: true)
        let vc = AddDispensaryVC()
        vc.id = self.id
        vc.image = self.image
        vc.name = self.name
        vc.phone = self.phone
        vc.email = self.email
        vc.address = self.address
        vc.country = self.country
        vc.city = self.city
        vc.state = self.state
        vc.postal = self.postal
        vc.website = self.website
        vc.license = self.license
        vc.expiration = self.expiration
        vc.hoursOfOperation = self.hoursOfOperation
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
//    func didTapdeleteButton(_ button: UIButton) {
//        dismiss(animated: true)
//        let vc = DeletePopUpVC()
//        vc.modalPresentationStyle = .overFullScreen
//        self.navigationController?.present(vc, true)
//    }
    
    func didTapcancelbutton(_ button: UIButton) {
        dismiss(animated: true)
    }
}
extension ManageDispensaryVC: DeletePopUpVCDelegate{
    func delete(dispensaryID: Int) {
        print(dispensaryID)
        let Id = "\(dispensaryID)"
        viewModel?.deleteDispensaryApi(Id: Id, isStatus: "1")
    }
    
    
}

extension ManageDispensaryVC: ManageDispensaryVMObserver{
    func observerDeleteDispensary() {
        self.dismiss(animated: true)
        self.viewModel?.dispensary?.removeAll()
        self.viewModel?.dispensaryListApi(isStatus: "1")
        self.manageDispensaryTableView.reloadData()
    }
    
    func ManageDispensaryApi(postCount: Int) {
        if postCount == 0{
            manageDispensaryTableView.setBackgroundView(message: "No Dispensary added yet!")
        }else{
            manageDispensaryTableView.backgroundView = nil
            self.manageDispensaryTableView.reloadData()
        }
    }
    
    
}
