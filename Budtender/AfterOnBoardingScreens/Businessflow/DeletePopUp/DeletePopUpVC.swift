//
//  DeletePopUpVC.swift
//  Budtender
//
//  Created by apple on 29/08/23.
//

import UIKit
protocol DeletePopUpVCDelegate{
    func delete(dispensaryID: Int)
    func deleteProduct(productID: Int)
}

class DeletePopUpVC: UIViewController {
    //-------------------------------------------------------------------------------------------------------
    //MARK: Outlets
    
    @IBOutlet weak var messageLabel: UILabel!
    
    var dispensaryID: Int?
    var productId: Int?
    var delegate: DeletePopUpVCDelegate?
    //-------------------------------------------------------------------------------------------------------
    //MARK: ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(dispensaryID)
        print(productId)
    }
    //-------------------------------------------------------------------------------------------------------
    //MARK: Actions
    
    @IBAction func crossAction(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func yesAction(_ sender: UIButton) {
//        dismiss(animated: true)
        self.delegate?.delete(dispensaryID: dispensaryID ?? 0 )
        self.delegate?.deleteProduct(productID: productId ?? 0)
    }
    
    @IBAction func noAction(_ sender: UIButton) {
        dismiss(animated: true)
    }
}
