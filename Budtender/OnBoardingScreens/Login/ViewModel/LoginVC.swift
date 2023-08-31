//
//  LoginVC.swift
//  Budtender
//
//  Created by apple on 08/08/23.
//

import UIKit
import SVProgressHUD
class LoginVC: UIViewController {
    //MARK: Outlets
    
    @IBOutlet weak var rememberMeBtn: UIButton!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    var rememberMeSelected = false
    //------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rememberMeBtn.isSelected = rememberMeSelected
        
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
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        txtEmail.text =  UserDefaults.standard.value(forKey: "USER_EMAIL") as? String
        txtPassword.text =  UserDefaults.standard.value(forKey: "USER_PASSWORD") as? String
        txtPassword.isSecureTextEntry = true
        self.rememberMeBtn.isSelected = txtEmail.text?.count ?? 0 > 0
    }
    func getEmail() -> String{
        if let email =  UserDefaults.standard.value(forKey:"email")
        {
            rememberMeSelected = true
            return email as! String
        }
        else
        {
            rememberMeSelected = false
            return ""
        }
    }
    
    func getPassword() -> String{
        if let password =  UserDefaults.standard.value(forKey:"password")
        {
            rememberMeSelected = true
            return password as! String
        }
        else
        {
            rememberMeSelected = false
            return ""
        }
    }
    
    @IBAction func btnRemember(_ sender: UIButton) {
        sender.isSelected.toggle()
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
            var signModel = SignupModel()
            signModel.email = self.txtEmail.text
            signModel.password = self.txtPassword.text
            signModel.deviceType = "1"
            signModel.deviceToken = AppDefaults.deviceToken
            SVProgressHUD.show()
            UserApiModel().userLogin(model: signModel) { response, error in
                SVProgressHUD.dismiss()
                if let jsonResponse = response{
                    if let parsedData = try? JSONSerialization.data(withJSONObject: jsonResponse,options: .prettyPrinted){
                        let userDict = try? JSONDecoder().decode(ApiResponseModel<UserModel>.self, from: parsedData)
                        if userDict?.status == 200{
                            if self.rememberMeBtn.isSelected == true {
                                let text = self.txtEmail.text ?? ""
                                let pass = self.txtPassword.text ?? ""
                                UserDefaults.standard.set(text, forKey:"USER_EMAIL")
                                UserDefaults.standard.set(pass, forKey:"USER_PASSWORD")
                                print("\(text) \(pass)")
                            } else {
                                UserDefaults.standard.removeObject(forKey: "USER_EMAIL")
                                UserDefaults.standard.removeObject(forKey: "USER_PASSWORD")
                            }
                            AppDefaults.userID = userDict?.data?.userID ?? ""
                            print(AppDefaults.userID,"Idddd")
                            AppDefaults.userFirstName = userDict?.data?.firstName ?? ""
                            AppDefaults.userLastName = userDict?.data?.lastName ?? ""
                            AppDefaults.token = userDict?.data?.authtoken ?? ""
                            let vc = HomeVC()
                            if "business" == UserDefaults.standard.string(forKey: "LoginType") {
                                UserDefaults.standard.set("3", forKey: "UserType")
                            }else{
                                UserDefaults.standard.set("2", forKey: "UserType")
                            }
                            self.navigationController?.pushViewController(vc, animated: true)
                        }
                    }
                }
            }
            //            let vc = HomeVC()
            //            if "business" == UserDefaults.standard.string(forKey: "LoginType") {
            //                UserDefaults.standard.set("3", forKey: "UserType")
            //            }else{
            //                UserDefaults.standard.set("2", forKey: "UserType")
            //            }
            //            self.navigationController?.pushViewController(vc, animated: true)
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
//        if UserDefaults.standard.string(forKey: "LoginType") == "business" {
//            let vc = ForgotPasswordVC()
//            self.navigationController?.pushViewController(vc, animated: true)
//        }else if UserDefaults.standard.string(forKey: "LoginType") == "customer" {
            let vc = ForgotPasswordVC()
            self.navigationController?.pushViewController(vc, animated: true)
//        }else{
//
//        }
    }
    @IBAction func loginAction(_ sender: UIButton) {
        // validation()
        
        if UserDefaults.standard.string(forKey: "LoginType") == "business" {
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
        if UserDefaults.standard.string(forKey: "LoginType") == "business" {
            let vc = BusinessSignUpVC()
            self.navigationController?.pushViewController(vc, animated: true)
        }else if UserDefaults.standard.string(forKey: "LoginType") == "customer" {
            let vc = SignUpVC()
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            
        }
    }
    //------------------------------------------------------
}
