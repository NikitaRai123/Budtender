//
//  HomeDispensaryVM.swift
//  Budtender
//
//  Created by Dharmani on 05/10/23.
//

import Foundation
protocol HomeDispensaryVMObserver{
    func HomeDispensaryApi(postCount:Int)
}

class HomeDispensaryVM: NSObject{
    
    var dispensary: [HomeDispensaryData]?
    var productDetail : [ProductDetailData]?
    var observer: HomeDispensaryVMObserver?
    init(observer: HomeDispensaryVMObserver?) {
        self.observer = observer
    }
    
    func homeDispensaryListApi(lat: String, long: String, search: String){
        let params: [String: Any] = [
            "latitude": lat,
            "longitude": long,
            "search": search
        ]
        print("params are : \(params)")
        ActivityIndicator.sharedInstance.showActivityIndicator()
        ApiHandler.updateProfile(apiName: API.Name.homeNearByDispensary, params: params, profilePhoto: nil, coverPhoto: nil) { succeeded, response, data in
            ActivityIndicator.sharedInstance.hideActivityIndicator()
            DispatchQueue.main.async {
                print("api responce : \(response) \(succeeded)")
                if succeeded == true {
                    if let userData = DataDecoder.decodeData(data, type: HomeDispensaryModel.self) {
                        if let data1 = userData.data{
                            self.dispensary = data1
                        }
                        
//                        if let data2 = userData.product_details{
//                            self.productDetail = data2
//                        }
                    }
                    //                    Singleton.shared.showErrorMessage(error:  response["message"] as? String ?? "", isError: .success)
                    self.observer?.HomeDispensaryApi(postCount: self.dispensary?.count ?? 0)
                } else {
//                    self.observer?.HomeDispensaryApi(postCount: self.dispensary?.count ?? 0)
                    Singleton.shared.showErrorMessage(error:  response["message"] as? String ?? "", isError: .error)
                }
            }
        }
    }
}
