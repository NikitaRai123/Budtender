//
//  ChangePasswordVC.swift
//  Budtender
//
//  Created by apple on 24/08/23.
//

import UIKit
class ChangePasswordVC: UIViewController, UITextFieldDelegate {
    //-------------------------------------------------------------------------------------------------------
    //MARK: Outlets
    
    @IBOutlet weak var currentPassBgView: UIView!
    @IBOutlet weak var newPassBgView: UIView!
    @IBOutlet weak var confirmPassBgView: UIView!
    @IBOutlet weak var txtCurrentPassword: UITextField!
    @IBOutlet weak var txtNewPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    
    
    var viewModel: ChangePasswordVM?
    //-------------------------------------------------------------------------------------------------------
    //MARK: ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtCurrentPassword.delegate = self
        txtNewPassword.delegate = self
        txtConfirmPassword.delegate = self
        
        setViewModel()
    }
    
    
    func setViewModel(){
        self.viewModel = ChangePasswordVM(observer: self)
    }
    //-------------------------------------------------------------------------------------------------------
    //MARK: TextFieldDelegate
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == txtCurrentPassword {
            self.currentPassBgView.borderColor = #colorLiteral(red: 0, green: 0.1647058824, blue: 0.4117647059, alpha: 1)
            self.newPassBgView.borderColor = .black
            self.confirmPassBgView.borderColor = .black
        } else if textField == txtNewPassword {
            self.newPassBgView.borderColor = #colorLiteral(red: 0, green: 0.1647058824, blue: 0.4117647059, alpha: 1)
            self.currentPassBgView.borderColor = .black
            self.confirmPassBgView.borderColor = .black
        }else{
            self.confirmPassBgView.borderColor = #colorLiteral(red: 0, green: 0.1647058824, blue: 0.4117647059, alpha: 1)
            self.currentPassBgView.borderColor = .black
            self.newPassBgView.borderColor = .black
        }
        return true
    }
    //-------------------------------------------------------------------------------------------------------
    //MARK: Function
    
    func validation() {
        if txtCurrentPassword.text == ""{
            Budtender.showAlert(title: Constants.AppName, message: Constants.blankCurrentPassword, view: self)
        }else if txtCurrentPassword?.isValidPassword() == false {
            Budtender.showAlert(title: Constants.AppName, message: Constants.minimumRangeSet, view: self)
        } else if txtNewPassword.text == ""{
            Budtender.showAlert(title: Constants.AppName, message: Constants.blankNewPassword, view: self)
        }else if txtNewPassword?.isValidPassword() == false {
            Budtender.showAlert(title: Constants.AppName, message: Constants.minimumRangeSet, view: self)
        } else if txtConfirmPassword.text == ""{
            Budtender.showAlert(title: Constants.AppName, message: Constants.blankConfirmPassword, view: self)
        }else if txtConfirmPassword?.isValidPassword() == false {
            Budtender.showAlert(title: Constants.AppName, message: Constants.minimumRangeSet, view: self)
        }else{
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    
    func setValidations() -> Bool {
        let isValidOldPassword = Validator.validateOldPassword(password: txtCurrentPassword.text ?? "")
        let isValidNewPassword = Validator.validateNewPassword(password: txtNewPassword.text ?? "")
        let isValidConfirmPassword = Validator.validateReEnterPassword(password: txtConfirmPassword.text ?? "")
        guard isValidOldPassword.0 == true else {
            Singleton.showMessage(message: isValidOldPassword.1, isError: .error)
            return false
        }
        
        guard isValidNewPassword.0 == true else {
            Singleton.showMessage(message: isValidNewPassword.1, isError: .error)
            return false
        }
        
        guard isValidConfirmPassword.0 == true else {
            Singleton.showMessage(message: isValidConfirmPassword.1, isError: .error)
            return false
        }
        
        if txtConfirmPassword.text != txtNewPassword.text {
            Singleton.showMessage(message: "New password and confirm new password not matched", isError: .error)
            
        } else {
//            self.popVC()
            viewModel?.changePassApi(oldPassword: txtCurrentPassword.text ?? "", newPassword: txtNewPassword.text ?? "", confirmPassword: txtConfirmPassword.text ?? "")
            
        }
        return true
    }
    //-------------------------------------------------------------------------------------------------------
    //MARK: Actions
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func currentPasswordAction(_ sender: UIButton) {
        sender.isSelected.toggle()
        txtCurrentPassword.isSecureTextEntry = !sender.isSelected
    }
    
    @IBAction func newPasswordAction(_ sender: UIButton) {
        sender.isSelected.toggle()
        txtNewPassword.isSecureTextEntry = !sender.isSelected
    }
    
    @IBAction func confirmPasswordAction(_ sender: UIButton) {
        sender.isSelected.toggle()
        txtConfirmPassword.isSecureTextEntry = !sender.isSelected
    }
    
    @IBAction func updatePasswordAction(_ sender: UIButton) {
////        validation()
        guard self.setValidations() else { return }
        
    }
}
extension ChangePasswordVC: ChangePasswordVMObserver{
    func observerChangePassApi() {
        self.navigationController?.popViewController(animated: true)
    }
    
    
}
