//
//  DetailVM.swift
//  Budtender
//
//  Created by Dharmani on 12/10/23.
//

import Foundation
protocol DetailVMObserver{
    func likeApi()
}

class DetailVM: NSObject{
    
    var observer: DetailVMObserver?
    var favorite: FavoriteModel?
    
    init(observer: DetailVMObserver?){
        self.observer = observer
    }
    
    func favoriteApi(dispensaryId: String, productId: String,isFav: String, isStatus: String){
        let params: [String: Any] = [
            "dispensarys_id": dispensaryId,
            "product_id": productId,
            "is_fav": isFav,
            "is_status": isStatus
        ]
        print("params are : \(params)")
        ActivityIndicator.sharedInstance.showActivityIndicator()
        ApiHandler.updateProfile(apiName: API.Name.addFavorite, params: params, profilePhoto: nil, coverPhoto: nil) { succeeded, response, data in
            ActivityIndicator.sharedInstance.hideActivityIndicator()
            DispatchQueue.main.async {
                print("api responce : \(response) \(succeeded)")
                if succeeded == true {
                    if let userData = DataDecoder.decodeData(data, type: FavoriteModel.self) {
                        self.favorite = userData
                    }
                    Singleton.shared.showErrorMessage(error:  response["message"] as? String ?? "", isError: .success)
                    self.observer?.likeApi()
                } else {
                    //                    self.observer?.ManageDispensaryApi(postCount: self.dispensary?.count ?? 0)
                    Singleton.shared.showErrorMessage(error:  response["message"] as? String ?? "", isError: .error)
                }
            }
        }
    }
}
