//
//  LoginTypeVC.swift
//  Budtender
//
//  Created by apple on 08/08/23.
//

import UIKit
class LoginTypeVC: UIViewController {
    //-------------------------------------------------------------------------------------------------------
    //MARK: Outlets
    
    @IBOutlet weak var loginAscustomerButton: UIButton!
    @IBOutlet weak var loginAsBussinessButton: UIButton!
    @IBOutlet weak var continueAsGuestButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
    }
    //-------------------------------------------------------------------------------------------------------
    //MARK: Functions
    
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
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
    }
    //-------------------------------------------------------------------------------------------------------
    //MARK: Actions
    
    @IBAction func loginAscustomerAction(_ sender: UIButton) {
        disableButtonForHalfSecond()
        self.loginAscustomerButton.backgroundColor = #colorLiteral(red: 0.1019607843, green: 0.2235294118, blue: 0.1647058824, alpha: 1)
        self.loginAscustomerButton.setTitleColor(UIColor(named: "LoginSelectTextColor"), for: .normal)
        self.loginAscustomerButton.borderColor = .clear
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3){ [self] in
            
            let vc = LoginVC()
            UserDefaults.standard.set("customer", forKey: "LoginType")
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    @IBAction func loginAsBussinessAction(_ sender: UIButton) {
        disableButtonForHalfSecond()
        self.loginAsBussinessButton.backgroundColor = #colorLiteral(red: 0.1019607843, green: 0.2235294118, blue: 0.1647058824, alpha: 1)
        self.loginAsBussinessButton.setTitleColor(UIColor(named: "LoginSelectTextColor"), for: .normal)
        self.loginAsBussinessButton.borderColor = .clear
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3){ [self] in
           
            let vc = LoginVC()
            UserDefaults.standard.set("business", forKey: "LoginType")
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func continueAsGuestAction(_ sender: UIButton) {
        disableButtonForHalfSecond()
        self.continueAsGuestButton.backgroundColor = #colorLiteral(red: 0.1019607843, green: 0.2235294118, blue: 0.1647058824, alpha: 1)
        self.continueAsGuestButton.setTitleColor(UIColor(named: "LoginSelectTextColor"), for: .normal)
        self.continueAsGuestButton.borderColor = .clear
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3){ [self] in
            
            let vc = HomeVC()
            UserDefaults.standard.set("guest", forKey: "LoginType")
            self.navigationController?.isNavigationBarHidden = true
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
