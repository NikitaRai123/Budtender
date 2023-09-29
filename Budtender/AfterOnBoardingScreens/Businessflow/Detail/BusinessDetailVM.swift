//
//  BusinessDetailVM.swift
//  Budtender
//
//  Created by Dharmani on 28/09/23.
//

import Foundation
protocol BusinessDetailVMObserver{
    func observerDeleteProduct()
}

class BusinessDetailVM: NSObject{
    
    var observer: BusinessDetailVMObserver?
    init(observer: BusinessDetailVMObserver?) {
        self.observer = observer
    }
    
    func productDeleteApi(Id: String){
        let params:[String:Any] = [
            "product_id": Id
            
        ]
        print("params are : \(params)")
        ActivityIndicator.sharedInstance.showActivityIndicator()
        
        ApiHandler.updateProfile(apiName: API.Name.deleteProduct, params: params){
            succeeded, response, data in
            ActivityIndicator.sharedInstance.hideActivityIndicator()
            DispatchQueue.main.async {
                print("api responce : \(response)")
                if succeeded == true {
                    //                    if let userData = DataDecoder.decodeData(data, type: UserModel.self) {
                    //                        UserDefaultsCustom.saveUserData(userData: userData.data!)
                    //                    }
                    Singleton.shared.showMessage(message: response["message"] as? String ?? "" , isError: .success)
//                    self.showMessage(message: "Delete Succeefully", isError: .error)
                    self.observer?.observerDeleteProduct()
                } else {
                    self.showMessage(message: response["message"] as? String ?? "", isError: .error)
                }
            }
        }
    }
}
