//
//  AddDispensaryVM.swift
//  Budtender
//
//  Created by Dharmani on 15/09/23.
//

import Foundation
protocol AddDispensaryVMObserver{
    func observerCreateDispensaryApi()
}

class AddDispensaryVM: NSObject{
    
    var observer: AddDispensaryVMObserver?
    var imagePicker = GetImageFromPicker()
    var editImage: PickerData?
    var details = String()
    
    init(observer: AddDispensaryVMObserver){
        self.observer = observer
    }
    
    func addDispensaryApi(name: String, phoneNumber: String, email: String, country: String, address: String, city: String,state: String,postalCode: String, website: String, license:String, expiration: String, image: String,longitude: String,latitude: String, operationDetail: String, isStatus: String){
        ActivityIndicator.sharedInstance.showActivityIndicator()
        var params: [String: Any] = [
            "name" : name,
            "phone_number" : phoneNumber,
            "email" : email,
            "country": country,
            "country_code": "",
            "address":address,
            "city"   : city,
            "state": state,
            "postal_code": postalCode,
            "website":website,
            "license":license,
            "expiration": expiration,
            "image":image,
            "longitude": longitude,
            "latitude": latitude,
            "operation_detail":self.details,
            "is_type": isStatus
            
        ]

        print("parameters are:----\(params)")
        ActivityIndicator.sharedInstance.showActivityIndicator()
        ApiHandler.updateDispensary(apiName: API.Name.CreateDispensary, params: params, operationDetails: details,profilePhoto: editImage,coverPhoto: nil) {succeeded,response,data in
            print("operationDetail ===== \(operationDetail)")
            print("detailsssss === \(self.details)")
            print("\(self.editImage)")
            ActivityIndicator.sharedInstance.hideActivityIndicator()
            DispatchQueue.main.async {
                print("api responce in profile screen : \(response)")
                if succeeded == true {
                    self.showMessage(message: "\(response["message"] ?? "")", isError: .success)
//                    if let userData = DataDecoder.decodeData(data, type: UserModel.self) {
//                        UserDefaultsCustom.saveUserData(userData: userData.data!)
//                        if let editImage = self.editImage?.image,
//                            let url = userData.data?.host_image {
//                            editImage.setCacheAt(url: url)
//                        }
//                    }
                    self.observer?.observerCreateDispensaryApi()
                } else {
                    self.showMessage(message: response["message"] as? String ?? "" , isError: .error)
                }
            }
        }
    }
    
    func editDispensaryApi(name: String, phoneNumber: String, email: String, country: String, address: String, city: String,state: String,postalCode: String, website: String, license:String, expiration: String, image: String,longitude: String,latitude: String, operationDetail: String, isStatus: String, id: String) {
        ActivityIndicator.sharedInstance.showActivityIndicator()
        let params: [String: Any] = [
            "name" : name,
            "phone_number" : phoneNumber,
            "email" : email,
            "country": country,
            "address":address,
            "city"   : city,
            "state": state,
            "postal_code": postalCode,
            "website":website,
            "license":license,
            "expiration": expiration,
            "image":image,
            "longitude": longitude,
            "latitude": latitude,
            "operation_detail":operationDetail,
            "is_type": isStatus,
            "id": id
        ]

        print("parameters are:----\(params)")
        ActivityIndicator.sharedInstance.showActivityIndicator()
        ApiHandler.updateDispensary(apiName: API.Name.editDispensary, params: params, operationDetails: details,profilePhoto: editImage,coverPhoto: nil) {succeeded,response,data in
            print("operationDetail ===== \(operationDetail)")
            print("detailsssss === \(self.details)")
            print("\(self.editImage)")
            ActivityIndicator.sharedInstance.hideActivityIndicator()
            DispatchQueue.main.async {
                print("api responce in profile screen : \(response)")
                if succeeded == true {
                    self.showMessage(message: "\(response["message"] ?? "")", isError: .success)
//                    if let userData = DataDecoder.decodeData(data, type: UserModel.self) {
//                        UserDefaultsCustom.saveUserData(userData: userData.data!)
//                        if let editImage = self.editImage?.image,
//                            let url = userData.data?.host_image {
//                            editImage.setCacheAt(url: url)
//                        }
//                    }
                    self.observer?.observerCreateDispensaryApi()
                } else {
                    self.showMessage(message: response["message"] as? String ?? "" , isError: .error)
                }
            }
        }
    }
}
