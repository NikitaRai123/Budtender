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
        viewModel?.dispensaryListApi()
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
        cell.favoriteButton.setImage(UIImage(named: "Ic_ThreeDots"), for: .normal)
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = ManageDispensaryDetailVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
//-------------------------------------------------------------------------------------------------------
//MARK: ExtensionActionFromProtocolDelegate

extension ManageDispensaryVC: FavoriteTVCellDelegate{
    func didTapFavoriteButton(button: UIButton, cell: FavoriteTVCell?) {
        let vc = BusinessEditPopUpVC()
        vc.dispensaryID = cell?.dispensaryData?.id
        vc.modalPresentationStyle = .overFullScreen
        vc.delegate = self
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
        vc.dispensaryID = dispensaryID
        vc.modalPresentationStyle = .overFullScreen
        self.navigationController?.present(vc, true)
    }
    
    func didTapeditButton(_ button: UIButton) {
        dismiss(animated: true)
        let vc = AddDispensaryVC()
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
extension ManageDispensaryVC: ManageDispensaryVMObserver{
    func observerDeleteDispensary() {
//        <#code#>
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
