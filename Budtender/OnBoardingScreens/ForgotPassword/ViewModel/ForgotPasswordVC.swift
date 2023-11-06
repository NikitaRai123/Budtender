//
//  ForgotPasswordVC.swift
//  Budtender
//
//  Created by apple on 08/08/23.
//

import UIKit
import SVProgressHUD

class ForgotPasswordVC: UIViewController {
    //-------------------------------------------------------------------------------------------------------
    //MARK: Outlets

    @IBOutlet weak var txtEmail: UITextField!
    
    //-------------------------------------------------------------------------------------------------------
    //MARK: ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    //-------------------------------------------------------------------------------------------------------
    //MARK: Functions
    
    func validation(){
        
        let isValidEmail = Validator.validateEmail(candidate: txtEmail.text?.toTrim() ?? "")
        guard isValidEmail.0 == true else {
            Singleton.showMessage(message: isValidEmail.1, isError: .error)
            return
        }
        
        
        //        if txtEmail.text == ""{
        //            Budtender.showAlert(title: Constants.AppName, message: Constants.blankEmail, view: self)
        //        }else if txtEmail.text?.isValidEmail == false {
        //            Budtender.showAlert(title: Constants.AppName, message: Constants.validEmail, view: self)
        //        }else{
        var signModel = SignupModel()
        signModel.email = self.txtEmail.text
        SVProgressHUD.show()
        UserApiModel().userForgotPassword(model: signModel) { response, error in
            SVProgressHUD.dismiss()
            if let jsonResponse = response {
                if let parsedData = try? JSONSerialization.data(withJSONObject: jsonResponse,options: .prettyPrinted){
                    let userModel = try? JSONDecoder().decode(ApiResponseModel<UserModel>.self, from: parsedData)
                    if userModel?.status == 200 {
//                        Budtender.showAlertMessage(title: ApiConstant.appName, message: userModel?.message ?? "", okButton: "OK", controller: self) {
//                            self.navigationController?.popViewController(animated: true)
//                        }
                        Singleton.shared.showErrorMessage(error:  response?["message"] as? String ?? "", isError: .success)
                        self.navigationController?.popViewController(animated: true)
                        
                    }   else{
                        Singleton.shared.showErrorMessage(error:  response?["message"] as? String ?? "", isError: .error)
                        //                                Budtender.showAlert(title: ApiConstant.appName, message: userModel?.message ?? "", view: self)
                    }
                }
            }
        }
        //            self.navigationController?.popViewController(animated: true)
        //        }
    }
    //-------------------------------------------------------------------------------------------------------
    //MARK: Actions
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func submitAction(_ sender: UIButton) {
        validation()
    }
    //-------------------------------------------------------------------------------------------------------
}
