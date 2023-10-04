//
//  FilterVM.swift
//  Budtender
//
//  Created by Dharmani on 03/10/23.
//

import Foundation
protocol FilterVMObserver{
    func filterApi(postCount:Int)
}

class FilterVM:NSObject{
    
    var observer: FilterVMObserver?
    var filterData: [ProductSubCategoryData]?
    init(observer: FilterVMObserver?) {
        self.observer = observer
    }
    
    func filterApi(subcatId: String, minPrice: String, maxPrice: String){
        let params: [String: Any] = [
            "subcat_id": subcatId,
            "minprice": minPrice,
            "maxprice": maxPrice
        ]
        print("params are : \(params)")
        ActivityIndicator.sharedInstance.showActivityIndicator()
        ApiHandler.updateProfile(apiName: API.Name.filter, params: params, profilePhoto: nil, coverPhoto: nil) { succeeded, response, data in
            ActivityIndicator.sharedInstance.hideActivityIndicator()
            DispatchQueue.main.async {
                print("api responce : \(response) \(succeeded)")
                if succeeded == true {
                    if let userData = DataDecoder.decodeData(data, type: ProductSubCategoryModel.self) {
                        if let data1 = userData.data{
                            self.filterData = data1
                        }
                    }
                    print("Count == \(self.filterData?.count)")
                    self.observer?.filterApi(postCount: self.filterData?.count ?? 0)
                } else {
//                    self.observer?.filterApi(postCount: self.filterData?.count ?? 0)
                    Singleton.shared.showErrorMessage(error:  response["message"] as? String ?? "", isError: .error)
                }
            }
        }
    }
}
