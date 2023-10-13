//
//  FavoriteVM.swift
//  Budtender
//
//  Created by Dharmani on 12/10/23.
//

import Foundation
protocol FavoriteVMObserver{
    func favoriteListApi(postCount: Int)
    func productFavoriteListApi(postCount: Int)
}

class FavoriteVM: NSObject{
    
    var observer: FavoriteVMObserver?
    var favoriteList: [FavoriteListData]?
    var productFavoriteList: [ProductFavoriteData]?
    
    init(observer: FavoriteVMObserver?) {
        self.observer = observer
    }
    
    func favoriteListApi(isStatus: String){
        let params: [String: Any] = [
            "is_status": isStatus
        ]
        print("params are : \(params)")
        ActivityIndicator.sharedInstance.showActivityIndicator()
        ApiHandler.updateProfile(apiName: API.Name.favoriteList, params: params, profilePhoto: nil, coverPhoto: nil) { succeeded, response, data in
            ActivityIndicator.sharedInstance.hideActivityIndicator()
            DispatchQueue.main.async {
                print("api responce : \(response) \(succeeded)")
                if succeeded == true {
                    if let userData = DataDecoder.decodeData(data, type: FavoriteListModel.self) {
                        if let data1 = userData.data{
                            self.favoriteList = data1
                        }
                        
//                        if let data2 = userData.product_details{
//                            self.productDetail = data2
//                        }
                    }
                    //                    Singleton.shared.showErrorMessage(error:  response["message"] as? String ?? "", isError: .success)
                    self.observer?.favoriteListApi(postCount: self.favoriteList?.count ?? 0)
                } else {
                    self.observer?.favoriteListApi(postCount: self.favoriteList?.count ?? 0)
                    Singleton.shared.showErrorMessage(error:  response["message"] as? String ?? "", isError: .error)
                }
            }
        }
    }
    
    func productFavoriteListApi(isStatus: String){
        let params: [String: Any] = [
            "is_status": isStatus
        ]
        print("params are : \(params)")
        ActivityIndicator.sharedInstance.showActivityIndicator()
        ApiHandler.updateProfile(apiName: API.Name.favoriteList, params: params, profilePhoto: nil, coverPhoto: nil) { succeeded, response, data in
            ActivityIndicator.sharedInstance.hideActivityIndicator()
            DispatchQueue.main.async {
                print("api responce : \(response) \(succeeded)")
                if succeeded == true {
                    if let userData = DataDecoder.decodeData(data, type: ProductFavoriteListModel.self) {
                        if let data1 = userData.data{
                            self.productFavoriteList = data1
                        }
                        
//                        if let data2 = userData.product_details{
//                            self.productDetail = data2
//                        }
                    }
                    //                    Singleton.shared.showErrorMessage(error:  response["message"] as? String ?? "", isError: .success)
                    self.observer?.productFavoriteListApi(postCount: self.productFavoriteList?.count ?? 0)
                } else {
                    self.observer?.productFavoriteListApi(postCount: self.productFavoriteList?.count ?? 0)
                    Singleton.shared.showErrorMessage(error:  response["message"] as? String ?? "", isError: .error)
                }
            }
        }
    }
}
