//
//  ChangePasswordVC.swift
//  Budtender
//
//  Created by apple on 24/08/23.
//

import UIKit
class ChangePasswordVC: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var currentPassBgView: UIView!
    @IBOutlet weak var newPassBgView: UIView!
    @IBOutlet weak var confirmPassBgView: UIView!
    @IBOutlet weak var txtCurrentPassword: UITextField!
    @IBOutlet weak var txtNewPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        txtCurrentPassword.delegate = self
        txtNewPassword.delegate = self
        txtConfirmPassword.delegate = self
        
    }
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
        validation()
    }
    
}
