//
//  ManageDispensaryVM.swift
//  Budtender
//
//  Created by Dharmani on 21/09/23.
//

import Foundation
protocol ManageDispensaryVMObserver: NSObjectProtocol{
    func ManageDispensaryApi(postCount:Int)
    func observerDeleteDispensary()
}

class ManageDispensaryVM: NSObject{
    
    var dispensary: [DispensaryData]?
    var productDetail : [ProductDetail]?
    var observer: ManageDispensaryVMObserver?
    init(observer: ManageDispensaryVMObserver?) {
        self.observer = observer
    }
    func dispensaryListApi(isStatus: String){
        let params: [String: Any] = [
            "is_type": isStatus
        ]
        print("params are : \(params)")
        ActivityIndicator.sharedInstance.showActivityIndicator()
        ApiHandler.updateProfile(apiName: API.Name.dispensaryList, params: params, profilePhoto: nil, coverPhoto: nil) { succeeded, response, data in
            ActivityIndicator.sharedInstance.hideActivityIndicator()
            DispatchQueue.main.async {
                print("api responce : \(response) \(succeeded)")
                if succeeded == true {
                    if let userData = DataDecoder.decodeData(data, type: ManageDispensaryModel.self) {
                        if let data1 = userData.data{
                            self.dispensary = data1
                        }
                        
                        if let data2 = userData.product_details{
                            self.productDetail = data2
                        }
                    }
                    //                    Singleton.shared.showErrorMessage(error:  response["message"] as? String ?? "", isError: .success)
                    self.observer?.ManageDispensaryApi(postCount: self.dispensary?.count ?? 0)
                } else {
                    self.observer?.ManageDispensaryApi(postCount: self.dispensary?.count ?? 0)
                    Singleton.shared.showErrorMessage(error:  response["message"] as? String ?? "", isError: .error)
                }
            }
        }
    }
    
    
    func deleteDispensaryApi(Id: String, isStatus: String){
        let params:[String:Any] = [
            "id": Id,
            "is_type": isStatus
        ]
        print("params are : \(params)")
        ActivityIndicator.sharedInstance.showActivityIndicator()
        
        ApiHandler.updateProfile(apiName: API.Name.deleteDispensary, params: params){
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
                    self.observer?.observerDeleteDispensary()
                } else {
                    self.showMessage(message: response["message"] as? String ?? "", isError: .error)
                }
            }
        }
    }
}
