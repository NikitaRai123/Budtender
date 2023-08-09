//
//  ForgotPasswordVC.swift
//  Budtender
//
//  Created by apple on 08/08/23.
//

import UIKit
class ForgotPasswordVC: UIViewController {
    //MARK: Outlets

    @IBOutlet weak var txtEmail: UITextField!
    
    //------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()

      
    }
    //MARK: Functions
    
    func validation(){
        if txtEmail.text == ""{
            Budtender.showAlert(title: Constants.AppName, message: Constants.blankEmail, view: self)
        }else if txtEmail.text?.isValidEmail == false {
            Budtender.showAlert(title: Constants.AppName, message: Constants.validEmail, view: self)
        }else{
            self.navigationController?.popViewController(animated: true)
        }
    }
    //------------------------------------------------------
    //MARK: Actions
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func submitAction(_ sender: UIButton) {
        validation()
    }
    //------------------------------------------------------
}
