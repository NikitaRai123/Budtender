//
//  BusinessSignUpVM.swift
//  Budtender
//
//  Created by Dharmani on 12/09/23.
//

import Foundation
import UIKit
import Kingfisher

protocol BusinessSignUpVMObserver{
    func observerSignUpApi()
}
struct Media {
    let key: String
    let filename: String
    let data: Data
    let mimeType: String
 
    init?(withImage image: UIImage?, forKey key: String) {
        
        self.key = key
        self.mimeType = "image/jpeg"
        self.filename = "imagefile.jpg"
        guard let data = image?.jpegData(compressionQuality: 0.7) else { return nil}
        self.data = data
    }
}
class BusinessSignUpVM: NSObject{
    
    var observer: BusinessSignUpVMObserver?
    var imagePicker = GetImageFromPicker()
    var editImage : PickerData?
    
    init(observer: BusinessSignUpVMObserver){
        self.observer = observer
    }
    func businessSignUpApi(firstName: String, lastName: String, email: String, password: String, isType: String, profileImage: String,name: String){
        let params : [String:Any] = [
            "last_name"   : lastName,
            "first_name"  : firstName,
            "email"       : email,
            "password"    : password,
            "is_type"     : isType,
            "image"       : profileImage,
            "name"        : name
        ]
       print("parameters:-  \(params)")
        ActivityIndicator.sharedInstance.showActivityIndicator()
        ApiHandler.updateProfile(apiName: API.Name.signUpBusiness, params: params, profilePhoto: editImage, coverPhoto: nil) { succeeded, response, data in
            print("image ====\(self.editImage)")
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
                   
                    self.observer?.observerSignUpApi()
                } else {
                    self.showMessage(message: response["message"] as? String ?? "" , isError: .error)
                }
            }
        }
        
    }
}
