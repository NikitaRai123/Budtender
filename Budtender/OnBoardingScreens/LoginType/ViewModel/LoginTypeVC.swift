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
        UserDefaults.standard.set("customer", forKey: "LoginType")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func loginAsBussinessAction(_ sender: UIButton) {
        let vc = LoginVC()
        UserDefaults.standard.set("business", forKey: "LoginType")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func continueAsGuestAction(_ sender: UIButton) {
        let vc = HomeVC()
        UserDefaults.standard.set("guest", forKey: "LoginType")
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
