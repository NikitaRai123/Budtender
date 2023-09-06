//
//  LoginTypeVC.swift
//  Budtender
//
//  Created by apple on 08/08/23.
//

import UIKit
class LoginTypeVC: UIViewController {
    
    @IBOutlet weak var loginAscustomerButton: UIButton!
    @IBOutlet weak var loginAsBussinessButton: UIButton!
    @IBOutlet weak var continueAsGuestButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
    }
    
    // Disable Button For HalfSecond
    func disableButtonForHalfSecond() {
        loginAscustomerButton.isEnabled = false
        loginAsBussinessButton.isEnabled = false
        continueAsGuestButton.isEnabled = false
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.loginAscustomerButton.isEnabled = true
            self.loginAsBussinessButton.isEnabled = true
            self.continueAsGuestButton.isEnabled = true
        }
    }

    @IBAction func loginAscustomerAction(_ sender: UIButton) {
        disableButtonForHalfSecond()
        self.loginAscustomerButton.backgroundColor = #colorLiteral(red: 0.2196078431, green: 0.2980392157, blue: 0.1725490196, alpha: 1)
        self.loginAscustomerButton.setTitleColor(.white, for: .normal)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.9){ [self] in
            
            let vc = LoginVC()
            UserDefaults.standard.set("customer", forKey: "LoginType")
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    @IBAction func loginAsBussinessAction(_ sender: UIButton) {
        disableButtonForHalfSecond()
        self.loginAsBussinessButton.backgroundColor = #colorLiteral(red: 0.2196078431, green: 0.2980392157, blue: 0.1725490196, alpha: 1)
        self.loginAsBussinessButton.setTitleColor(.white, for: .normal)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.9){ [self] in
           
            let vc = LoginVC()
            UserDefaults.standard.set("business", forKey: "LoginType")
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func continueAsGuestAction(_ sender: UIButton) {
        disableButtonForHalfSecond()
        self.continueAsGuestButton.backgroundColor = #colorLiteral(red: 0.2196078431, green: 0.2980392157, blue: 0.1725490196, alpha: 1)
        self.continueAsGuestButton.setTitleColor(.white, for: .normal)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.9){ [self] in
            
            let vc = HomeVC()
            UserDefaults.standard.set("guest", forKey: "LoginType")
            self.navigationController?.isNavigationBarHidden = true
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
