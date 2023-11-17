//
//  OrderConfirmPopUpVC.swift
//  Budtender
//
//  Created by apple on 21/08/23.
//


protocol OrderConfirmPopUpDelegate {
    func dismissVC()
}

import UIKit
class OrderConfirmPopUpVC: UIViewController {
    
    var delegate: OrderConfirmPopUpDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        dismiss(animated: true)
    }


    @IBAction func crossAction(_ sender: UIButton) {
        self.delegate?.dismissVC()
        dismiss(animated: true)
    }
    
}
