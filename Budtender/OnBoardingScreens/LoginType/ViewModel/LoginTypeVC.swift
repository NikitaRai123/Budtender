//
//  LoginTypeVC.swift
//  Budtender
//
//  Created by apple on 08/08/23.
//

import UIKit

class LoginTypeVC: UIViewController {
    


    override func viewDidLoad() {
        super.viewDidLoad()

       
    }


    @IBAction func loginAscustomerAction(_ sender: UIButton) {
        let vc = LoginVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func loginAsBussinessAction(_ sender: UIButton) {
    }
}
