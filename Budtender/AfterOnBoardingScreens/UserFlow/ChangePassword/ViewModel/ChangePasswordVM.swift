//
//  ChangePasswordVM.swift
//  Budtender
//
//  Created by Dharmani on 14/09/23.
//

import Foundation
protocol ChangePasswordVMObserver:NSObjectProtocol{
    func observerChangePassApi()
}

class ChangePasswordVM: NSObject{
    
    var observer:ChangePasswordVMObserver?
    
    init(observer:ChangePasswordVMObserver){
        self.observer = observer
    }
    
    func changePassApi(oldPassword:String, newPassword:String,confirmPassword:String) {
        ActivityIndicator.sharedInstance.showActivityIndicator()
        let params :[String:Any] = [
            "old_password"   : oldPassword,
            "password"   : newPassword,
            "password_confirmation": confirmPassword
        ]
        print("parameters:-  \(params)")
        ActivityIndicator.sharedInstance.showActivityIndicator()
        ApiHandler.updateProfile(apiName: API.Name.changePass, params: params, profilePhoto: nil, coverPhoto: nil) { succeeded, response, data in
            ActivityIndicator.sharedInstance.hideActivityIndicator()
            DispatchQueue.main.async {
                print("api responce in Home screen : \(response)")
                if succeeded == true {
                    self.showMessage(message: response["message"] as? String ?? "" , isError: .success)
                    self.observer?.observerChangePassApi()
                } else {
                    self.showMessage(message: response["message"] as? String ?? "" , isError: .error)
                }
            }
        }
    }
}
