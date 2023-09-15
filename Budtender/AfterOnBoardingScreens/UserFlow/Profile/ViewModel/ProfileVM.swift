//
//  ProfileVM.swift
//  Budtender
//
//  Created by Dharmani on 15/09/23.
//

import Foundation
protocol ProfileVMObserver: NSObjectProtocol {
    func observerLogoutApi()
  
}


class ProfileVM: NSObject {
    
    var observer: ProfileVMObserver?
    
    init(observer: ProfileVMObserver?) {
        self.observer = observer
    }
    
    
    func hitLogOutApi() {
        let params :[String:Any] = [:
        ]
        print("params are: \(params)")
        ActivityIndicator.sharedInstance.showActivityIndicator()
        ApiHandler.updateProfile(apiName: API.Name.logout, params: params, profilePhoto: nil, coverPhoto: nil) { succeeded, response, data in
            ActivityIndicator.sharedInstance.hideActivityIndicator()
            DispatchQueue.main.async {
                print("api responce in Home screen : \(response)")
                if succeeded == true {
                    self.showMessage(message: response["message"] as? String ?? "", isError: .success)
                    self.observer?.observerLogoutApi()
                } else {
                    self.showMessage(message: response["message"] as? String ?? "" , isError: .error)
                }
            }
        }
    }
}
