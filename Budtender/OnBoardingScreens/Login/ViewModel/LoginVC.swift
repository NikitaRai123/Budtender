//
//  LoginVC.swift
//  Budtender
//
//  Created by apple on 08/08/23.
//

import UIKit
class LoginVC: UIViewController {
    //MARK: Outlets
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    //------------------------------------------------------

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
//        if "business" == UserDefaults.standard.string(forKey: "LoginType") {
//            self.guestUserButton.isHidden = true
//            self.orLabel.isHidden = true
//            self.guestUserButtonHeightCons.constant = 0
//        }else{
//            self.guestUserButton.isHidden = false
//            self.orLabel.isHidden = false
//            self.guestUserButtonHeightCons.constant = 50
//        }
        
    }
    
    //MARK: Functions
    
    func validation() {
        if txtEmail.text == ""{
            Budtender.showAlert(title: Constants.AppName, message: Constants.blankEmail, view: self)
        }else if txtEmail.text?.isValidEmail == false {
            Budtender.showAlert(title: Constants.AppName, message: Constants.validEmail, view: self)
        }else if txtPassword.text == ""{
            Budtender.showAlert(title: Constants.AppName, message: Constants.blankPassword, view: self)
        }else if txtPassword?.isValidPassword() == false {
            Budtender.showAlert(title: Constants.AppName, message: Constants.minimumRangeSet, view: self)
        }else{
            let vc = HomeVC()
            if "business" == UserDefaults.standard.string(forKey: "LoginType") {
                UserDefaults.standard.set("3", forKey: "UserType")
            }else{
                UserDefaults.standard.set("2", forKey: "UserType")
            }
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    //------------------------------------------------------
    //MARK: Actions
    
    @IBAction func hidePasswordAction(_ sender: UIButton) {
        sender.isSelected.toggle()
        txtPassword.isSecureTextEntry = !sender.isSelected
    }
    
    @IBAction func rememberMeSelectAction(_ sender: UIButton) {
        sender.isSelected.toggle()
    }
    
    @IBAction func forgotPasswordAction(_ sender: UIButton) {
        if "business" == UserDefaults.standard.string(forKey: "LoginType") {
            let vc = ForgotPasswordVC()
            self.navigationController?.pushViewController(vc, animated: true)
        }else if "customer" == UserDefaults.standard.string(forKey: "LoginType") {
            let vc = ForgotPasswordVC()
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            
        }
    }
    @IBAction func loginAction(_ sender: UIButton) {
       // validation()
       
        if "business" == UserDefaults.standard.string(forKey: "LoginType") {
            //UserDefaults.standard.set("3", forKey: "UserType")
            let vc = ProductVC()
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
           // UserDefaults.standard.set("2", forKey: "UserType")
            let vc = HomeVC()
            self.navigationController?.pushViewController(vc, animated: true)
        }
       
    }
    
    @IBAction func facebookAction(_ sender: UIButton) {
    }
    
    @IBAction func googleAction(_ sender: UIButton) {
    }
    
    @IBAction func appleAction(_ sender: UIButton) {
    }
    
    @IBAction func continueAsGuestAction(_ sender: UIButton) {
        let vc = HomeVC()
        UserDefaults.standard.set("1", forKey: "UserType")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func signUpAction(_ sender: UIButton) {
        if "business" == UserDefaults.standard.string(forKey: "LoginType") {
            let vc = SignUpVC()
            self.navigationController?.pushViewController(vc, animated: true)
        }else if "customer" == UserDefaults.standard.string(forKey: "LoginType") {
            let vc = SignUpVC()
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            
        }
    }
    //------------------------------------------------------
}
