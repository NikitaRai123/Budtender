//
//  SignUpVC.swift
//  Budtender
//
//  Created by apple on 09/08/23.
//

import UIKit
class SignUpVC: UIViewController {
    //MARK: Outlets
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var privacyPolicySelectBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtPassword.isSecureTextEntry = true
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
        }else if txtFirstName.text == "" {
            Budtender.showAlert(title: Constants.AppName, message: Constants.blankFirstName, view: self)
        }else if txtFirstName?.isValidUserName() == false {
            Budtender.showAlert(title: Constants.AppName, message: Constants.validName, view: self)
        }else if txtLastName.text == "" {
            Budtender.showAlert(title: Constants.AppName, message: Constants.blankLastName, view: self)
        }else if txtLastName?.isValidUserName() == false {
            Budtender.showAlert(title: Constants.AppName, message: Constants.validName, view: self)
        }else{
             if "customer" == UserDefaults.standard.string(forKey: "LoginType") {
                 self.navigationController?.popViewController(animated: true)
                
            }else if "business" == UserDefaults.standard.string(forKey: "LoginType"){
               
            }else{
                UserDefaults.standard.set("customer", forKey: "LoginType")
                    let vc = LoginVC()
                    self.navigationController?.pushViewController(vc, animated: true)
                
            }
        }
    }
    //------------------------------------------------------
    //MARK: Actions
    
    @IBAction func hidePasswordAction(_ sender: UIButton) {
        sender.isSelected.toggle()
        txtPassword.isSecureTextEntry = !sender.isSelected
    }
    
    @IBAction func privacyPolicySelectAction(_ sender: UIButton) {
        sender.isSelected.toggle()
    }
    
    @IBAction func privacyPolicyAction(_ sender: UIButton) {
        let vc = TermAndConditionVC()
        vc.comeFrom = "Privacy Policy"
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func signUpAction(_ sender: UIButton) {
        validation()
    }
    
    @IBAction func facebookAction(_ sender: UIButton) {
    }
    
    @IBAction func googleAction(_ sender: UIButton) {
    }
    
    @IBAction func appleAction(_ sender: UIButton) {
    }
    
    @IBAction func signInAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    //------------------------------------------------------
}
