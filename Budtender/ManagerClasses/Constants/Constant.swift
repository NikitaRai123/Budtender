//
//  Constant.swift
//  Vanguards
//  Created by apple on 12/06/23.

import Foundation
import UIKit

let SCREEN_SIZE = UIScreen.main.bounds
struct Constants{
    static let window : UIWindow = UIApplication.shared.keyWindow!
    //    MARK: AppName
    static let AppName = "Budtender"
    
  
    
    //    MARK: Alert Messages
    static let blankEmail = "Please enter email"
    static let validEmail = "Please enter valid email"
    static let blankPassword = "Please enter password"
    static let blankCurrentPassword = "Please enter current password"
    static let blankNewPassword = "Please enter new password"
    static let validPassword = "Please enter valid password"
    static let blankConfirmPassword = "Please enter confirm password"
    static let validConfirmPassword = "Please enter valid confirm password"
    static let minimumRangeSet = "Please enter at least minimum 6 digit"
    static let blankName = "Please enter name"
    static let blankFirstName = "Please enter first name"
    static let blankLastName = "Please enter last name"
    static let validName = "Please enter at least three Character"
    static let blankPlace = "Please enter place"
    static let blankGender = "Please enter gender"
    static let blankManufacturers = "Please enter manufacturers"
    static let blankProductType = "Please enter product type"
    static let blankCalibers = "Please enter Calibers / Gauges"
    static let blankActions = "Please enter Actions"
    static let blankBirthday = "Please select birthday"
    static let blankPhoneNumber = "Please enter phone number"
    static let blankPickUpTime = "Please select pickup time"
    static let selectGovtId = "Please select govt id"
    static let phoneNumber = "Please enter mobile number range between 10 - 15"
    
    //    MARK: Business AddProduct
    static let blankProductCategory = "Please select product category"
    static let blankSubcategory = "Please enter subcategory"
    static let blankDispensary = "Please select dispensary"
    static let blankProductName = "Please enter product name"
    static let blankBrandName = "Please select brand name"
    static let blankQuantity = "Please enter quantity"
    static let blankWeight = "Please enter weight"
    static let blankPrice = "Please enter price"
    static let blankDescription = "Please enter description"
    
}
struct NIB_NAME {
    static let errorView = "ErrorView"
    static let homeTableHeader = "HomeTableHeader"
    static let profileHeaderView = "ProfileHeaderView"
    static let profileSectionHeader = "ProfileSectionHeader"
    static let documentCollectionSectionView = "DocumentCollectionSectionView"
    static let createPollTableHeader = "CreatePollTableHeader"
    static let profileDetailTableHeader = "ProfileDetailTableHeader"
    static let editShareProfileHeader = "EditShareProfileHeader"
    
}
struct HEIGHT {
    
    static let window = UIApplication.shared.windows.first(where: {$0.isKeyWindow})
    
    static var statusBarHeight: CGFloat {
        var statusBarHeight: CGFloat = 0
        if #available(iOS 13.0, *) {
            let window = HEIGHT.window
            statusBarHeight = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        } else {
            statusBarHeight = UIApplication.shared.statusBarFrame.height
        }
        return statusBarHeight
    }
    static let errorMessageHeight: CGFloat = 43.0
    
    static let navigationHeight: CGFloat = 190 + Self.getTopInsetofSafeArea + Self.statusBarHeight
    
    static var getTopInsetofSafeArea: CGFloat {
        guard let topInset = Self.window?.safeAreaInsetsForAllOS.top else { return 0 }
        return topInset
    }
    
    static var getBottomInsetofSafeArea: CGFloat {
        let topInset = Self.window?.safeAreaInsetsForAllOS.bottom ?? 0
        return topInset
    }
    
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

func showAlertMessage(title: String, message: String, okButton: String, controller: UIViewController, okHandler: (() -> Void)?){
    DispatchQueue.main.async {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let dismissAction = UIAlertAction(title: okButton, style: UIAlertAction.Style.default) { (action) -> Void in
            if okHandler != nil {
                okHandler!()
            }
        }
        alertController.addAction(dismissAction)
       // UIApplication.shared.windows[0].rootViewController?.present(alertController, animated: true, completion: nil)
        controller.present(alertController, animated: true, completion: nil)
    }
 
}

func setHomeScreen() {
    let vc = BusinessSignUpVC()
    let navController = UINavigationController(rootViewController: vc)
    navController.navigationBar.isHidden = true
    Constants.window.rootViewController = navController
}

var currentLoginType: String {
    return UserDefaults.standard.string(forKey: "LoginType") ?? String()
}
