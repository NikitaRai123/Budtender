//
//  LoginVC.swift
//  Budtender
//
//  Created by apple on 08/08/23.
//

import UIKit

class LoginVC: UIViewController {
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.isNavigationBarHidden = true
        txtPassword.isSecureTextEntry = true
      
    }
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
//            let vc = ForgotPasswordVC()
//            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func hidePasswordAction(_ sender: UIButton) {
        sender.isSelected.toggle()
        txtPassword.isSecureTextEntry = !sender.isSelected
    }
    
    @IBAction func rememberMeSelectAction(_ sender: UIButton) {
        sender.isSelected.toggle()
    }
    
    @IBAction func forgotPasswordAction(_ sender: UIButton) {
        let vc = ForgotPasswordVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func loginAction(_ sender: UIButton) {
        validation()
    }
    
    @IBAction func facebookAction(_ sender: UIButton) {
    }
    
    @IBAction func googleAction(_ sender: UIButton) {
    }
    
    @IBAction func appleAction(_ sender: UIButton) {
    }
    
    @IBAction func continueAsGuestAction(_ sender: UIButton) {
    }
    
    @IBAction func signUpAction(_ sender: UIButton) {
    }
    
    
}
