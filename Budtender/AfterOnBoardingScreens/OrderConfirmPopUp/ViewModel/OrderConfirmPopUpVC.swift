//
//  OrderConfirmPopUpVC.swift
//  Budtender
//
//  Created by apple on 21/08/23.
//

import UIKit

class OrderConfirmPopUpVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        dismiss(animated: true)
    }


    @IBAction func crossAction(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
}
