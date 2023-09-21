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
    var observer: ManageDispensaryVMObserver?
    init(observer: ManageDispensaryVMObserver?) {
        self.observer = observer
    }
    func dispensaryListApi(){
        let params: [String: Any] = [
            :
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
}
