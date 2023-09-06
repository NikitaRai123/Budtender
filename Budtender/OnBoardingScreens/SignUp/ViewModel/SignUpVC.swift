//
//  SignUpVC.swift
//  Budtender
//
//  Created by apple on 09/08/23.
//

import UIKit
import SVProgressHUD
class SignUpVC: UIViewController,UITextFieldDelegate {
    //MARK: Outlets
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var privacyPolicySelectBtn: UIButton!
    var iconClick = true
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        txtPassword.isSecureTextEntry = true
    }
    
    func setup(){
        txtFirstName.delegate = self
        txtLastName.delegate = self
        txtEmail.delegate = self
        txtPassword.delegate = self
        self.privacyPolicySelectBtn.isSelected = false
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
            
        }else if self.privacyPolicySelectBtn.isSelected == false{
            Budtender.showAlert(title: Constants.AppName, message: "Please agree with Privacy Policy.", view: self)
        }
        else{
            var signModel = SignupModel()
            signModel.firstName = self.txtFirstName.text
            signModel.lastName = self.txtLastName.text
            signModel.email = self.txtEmail.text
            signModel.password = self.txtPassword.text
            signModel.is_type = "1"
            SVProgressHUD.show()
            UserApiModel().userSignUp(model: signModel) { response, error in
                SVProgressHUD.dismiss()
                if let jsonResponse = response{
                    if let parsedData = try? JSONSerialization.data(withJSONObject: jsonResponse,options: .prettyPrinted){
                        let userModel = try? JSONDecoder().decode(ApiResponseModel<UserModel>.self, from: parsedData)
                        if userModel?.status == 200 {
                            Budtender.showAlertMessage(title: ApiConstant.appName, message: userModel?.message ?? "", okButton: "OK", controller: self) {
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
                    }
                }
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
        // validation()
        if "customer" == UserDefaults.standard.string(forKey: "LoginType") {
            self.navigationController?.popViewController(animated: true)
            
        }else if "business" == UserDefaults.standard.string(forKey: "LoginType"){
            
        }else{
            UserDefaults.standard.set("customer", forKey: "LoginType")
            let vc = LoginVC()
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
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
