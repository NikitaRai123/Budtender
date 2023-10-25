//
//  EditProfileVM.swift
//  Budtender
//
//  Created by Dharmani on 13/09/23.
//

import Foundation

protocol EditProfileVMObserver{
    func observerEditProfileApi()
    func observerGetProfileApi()
}


class EditProfileVM: NSObject{
    
    var observer: EditProfileVMObserver?
    var imagePicker = GetImageFromPicker()
    var editImage: PickerData?
    
    init(observer: EditProfileVMObserver){
        self.observer = observer
    }
    func getProfileApi(){
        let params : [String:Any] = [:]
        print("parameters:-  \(params)")
        ActivityIndicator.sharedInstance.showActivityIndicator()
        ApiHandler.call(apiName: API.Name.getProfile, params: params, httpMethod: .POST, receivedResponse: { succeeded, response, data in
            ActivityIndicator.sharedInstance.hideActivityIndicator()
            DispatchQueue.main.async {
                print("api responce in Home screen : \(response)")
                if succeeded == true {
                    //                  self.showMessage(message: "\(response["message"] ?? "")", isError: .success)
                    //                    if let userData = DataDecoder.decodeData(data, type: EditProfileData.self) {
                    //                        UserDefaultsCustom.saveUserData(userData: userData.data!)
                    //                        if let editImage = self.editImage?.image,
                    //                            let url = userData.data?.profileImage {
                    //                            editImage.setCacheAt(url: url)
                    //                        }
                    //
                    //                    }
                    
//                    self.observer?.observerGetProfileApi()
                } else {
                    self.showMessage(message: response["message"] as? String ?? "" , isError: .error)
                }
            }
        })
        
        
    }
    
    
    func editProfileApi(name: String,firstName: String, lastName: String, profileImage: String, isType: String){
        let params : [String:Any] = [
            "name"       : name,
            "last_name"   : lastName,
            "first_name"  : firstName,
            "image"      : profileImage,
            "is_type"    : isType
        ]
       print("parameters:-  \(params)")
        ActivityIndicator.sharedInstance.showActivityIndicator()
        ApiHandler.updateProfile(apiName: API.Name.editProfile, params: params, profilePhoto: editImage, coverPhoto: nil) { succeeded, response, data in
            ActivityIndicator.sharedInstance.hideActivityIndicator()
            DispatchQueue.main.async {
                print("api responce in Home screen : \(response)")
                if succeeded == true {
                  self.showMessage(message: "\(response["message"] ?? "")", isError: .success)
                    if let userData = DataDecoder.decodeData(data, type: UserModel.self) {
                        UserDefaultsCustom.saveUserData(userData: userData.data!)
                        if let editImage = self.editImage?.image,
                            let url = userData.data?.image {
                            editImage.setCacheAt(url: url)
                        }

                    }
                   
                    self.observer?.observerEditProfileApi()
                } else {
                    self.showMessage(message: response["message"] as? String ?? "" , isError: .error)
                }
            }
        }
        
    }
}
