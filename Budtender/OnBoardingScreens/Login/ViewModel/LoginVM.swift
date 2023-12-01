//
//  LoginVM.swift
//  Budtender
//
//  Created by Dharmani on 15/09/23.
//

import Foundation
protocol LoginVMObserver{
    func observeGoogleLoginApi()
}

class LoginVM: NSObject{
    
    var observer: LoginVMObserver?
    
    init(observer: LoginVMObserver) {
        self.observer = observer
    }
    
    func googleLoginApi(email: String,id:String,firstName:String,lastName:String,name:String,devideType:String,isType: String,profileImage: String) {
        let device_token = UserDefaultsCustom.getDeviceToken()
         let params:[String:Any] = [
            "email"             : email,
            "google_id"         : id,
            "first_name"        : firstName,
            "last_name"         : lastName,
            "name"              : name,
            "device_type"       : devideType,
            "device_token"      : device_token,
            "is_type"           : isType,
            "profile_image"     : profileImage
         ]
         print("params are : \(params)")
         ActivityIndicator.sharedInstance.showActivityIndicator()
         
        ApiHandler.updateProfile(apiName: API.Name.googleLogin, params: params) { succeeded, response, data in
            ActivityIndicator.sharedInstance.hideActivityIndicator()
            print("outer responce : \(response) \(succeeded)")
             DispatchQueue.main.asyncAfter(deadline: .now()+0.2) {
                 print("api responce : \(response) \(succeeded)")
                 if succeeded == true {
                     Singleton.shared.showErrorMessage(error:  response["message"] as? String ?? "", isError: .success)
                     if let userData = DataDecoder.decodeData(data, type: UserModel.self) {
                         if let data1 = userData.data{
                             UserDefaultsCustom.saveUserData(userData: data1)
                             print("\(userData.data?.first_name)   = =   userData.data")
                         }
                   
                 }
                         self.observer?.observeGoogleLoginApi()
                 } else {
                     Singleton.shared.showErrorMessage(error:  response["message"] as? String ?? "", isError: .error)
                 }
             }
         }
     }
    
    func appleLoginApi(email: String,id:String,firstName:String,lastName:String,name:String,devideType:String,isType: String) {
        let device_token = UserDefaultsCustom.getDeviceToken()
         let params:[String:Any] = [
            "email"             : email,
            "apple_id"         : id,
            "first_name"        : firstName,
            "last_name"         : lastName,
            "name"              : name,
            "device_type"       : devideType,
            "device_token"      : device_token,
            "is_type"           : isType
            

         ]
         print("params are : \(params)")
         ActivityIndicator.sharedInstance.showActivityIndicator()
         
        ApiHandler.updateProfile(apiName: API.Name.appleLogin, params: params) { succeeded, response, data in
            ActivityIndicator.sharedInstance.hideActivityIndicator()
            print("outer responce : \(response) \(succeeded)")
             DispatchQueue.main.asyncAfter(deadline: .now()+0.2) {
                 print("api responce : \(response) \(succeeded)")
                 if succeeded == true {
                     Singleton.shared.showErrorMessage(error:  response["message"] as? String ?? "", isError: .success)
                     if let userData = DataDecoder.decodeData(data, type: UserModel.self) {
                         if let data1 = userData.data{
                             UserDefaultsCustom.saveUserData(userData: data1)
                             print("\(userData.data?.first_name)   = =   userData.data")
                         }
                   
                 }
                         self.observer?.observeGoogleLoginApi()
                 } else {
                     Singleton.shared.showErrorMessage(error:  response["message"] as? String ?? "", isError: .error)
                 }
             }
         }
     }
}
