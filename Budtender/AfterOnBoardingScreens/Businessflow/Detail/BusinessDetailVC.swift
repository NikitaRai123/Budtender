//
//  BusinessDetailVC.swift
//  Budtender
//
//  Created by apple on 28/08/23.
//

import UIKit
class BusinessDetailVC: UIViewController {
    //-------------------------------------------------------------------------------------------------------
    //MARK: Outlets
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var imageDetailLabel: UILabel!
    @IBOutlet weak var productAmountLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var discriptionLabel: UILabel!
    //-------------------------------------------------------------------------------------------------------
    //MARK: ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    //-------------------------------------------------------------------------------------------------------
    //MARK: Actions
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func editAction(_ sender: UIButton) {
        let vc = BusinessEditPopUpVC()
        vc.modalPresentationStyle = .overFullScreen
        vc.delegate = self
        self.navigationController?.present(vc, true)
    }
}
//-------------------------------------------------------------------------------------------------------
//MARK: ButtonActionFromProtocolDelegate

extension BusinessDetailVC: BusinessEditPopUpVCDelegate{
    func didTapeditButton(_ button: UIButton) {
        dismiss(animated: true)
        let vc = BusinessAddProductVC()
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
