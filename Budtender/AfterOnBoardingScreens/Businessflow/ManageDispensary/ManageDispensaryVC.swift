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
    //-------------------------------------------------------------------------------------------------------
    //MARK: ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.manageDispensaryTableView.delegate = self
        self.manageDispensaryTableView.dataSource = self
        self.manageDispensaryTableView.register(UINib(nibName: "FavoriteTVCell", bundle: nil), forCellReuseIdentifier: "FavoriteTVCell")
        
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
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteTVCell", for: indexPath) as! FavoriteTVCell
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
    func didTapFavoriteButton(button: UIButton) {
        let vc = BusinessEditPopUpVC()
        vc.modalPresentationStyle = .overFullScreen
        vc.delegate = self
        self.navigationController?.present(vc, true)
    }
}

extension ManageDispensaryVC: BusinessEditPopUpVCDelegate{
    func didTapeditButton(_ button: UIButton) {
        dismiss(animated: true)
        let vc = AddDispensaryVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func didTapdeleteButton(_ button: UIButton) {
        dismiss(animated: true)
        let vc = DeletePopUpVC()
        vc.modalPresentationStyle = .overFullScreen
        self.navigationController?.present(vc, true)
    }
    
    func didTapcancelbutton(_ button: UIButton) {
        dismiss(animated: true)
    }
}
