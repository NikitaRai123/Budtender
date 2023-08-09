//
//  Constant.swift
//  Vanguards
//  Created by apple on 12/06/23.

import Foundation
import UIKit

struct Constants{
    //    MARK: AppName
    static let AppName = "Budtender"
    
    //    MARK: Alert Messages
    static let blankEmail = "Please enter email"
    static let validEmail = "Please enter valid email"
    static let blankPassword = "Please enter password"
    static let validPassword = "Please enter valid password"
    static let blankConfirmPassword = "Please enter confirm password"
    static let validConfirmPassword = "Please enter valid confirm password"
    static let minimumRangeSet = "Please enter at least minimum 6 digit"
    static let blankUserName = "Please enter user name"
    static let validName = "Please enter at least three Character"
    static let blankPlace = "Please enter place"
    static let blankDateofbirth = "Please enter date of birth"
    static let blankGender = "Please enter gender"
    static let blankEthnicity = "Please select Ethnicity"
    static let blankNumberofdays = "Please enter Number of days"
    static let blankTripcategory = "Please enter Trip Category"
    static let blankComplexity = "Please enter Complexity"
   
   
}

func showAlert(title:String,message:String,view:UIViewController){
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
    view.present(alert, animated: true, completion: nil)
}

func validateEmail(_ email:String)->Bool{
    let emailRegex="[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,7}"
    let emailTest=NSPredicate(format:"SELF MATCHES %@", emailRegex)
    return emailTest.evaluate(with:email)
}

