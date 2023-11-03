//
//  ProductSubCategoryVM.swift
//  Budtender
//
//  Created by Dharmani on 27/09/23.
//

import Foundation
protocol ProductSubCategoryVMObserver{
    func ProductSubCategoryApi(postCount:Int)
}

class ProductSubCategoryVM: NSObject{
    
    var observer: ProductSubCategoryVMObserver?
    var productSubCategory: [ProductSubCategoryData]?
    init(observer: ProductSubCategoryVMObserver?){
        self.observer = observer
    }
    func productSubCategoryListApi(productId: String, name: String, subcatId: String){
        let params: [String: Any] = [
            "product_id": productId,
            "subcat_id": subcatId,
            "name": name
        ]
        print("params are : \(params)")
        ActivityIndicator.sharedInstance.showActivityIndicator()
        ApiHandler.updateProfile(apiName: API.Name.productSubCategoryList, params: params, profilePhoto: nil, coverPhoto: nil) { succeeded, response, data in
            ActivityIndicator.sharedInstance.hideActivityIndicator()
            DispatchQueue.main.async {
                print("api responce : \(response) \(succeeded)")
                if succeeded == true {
                    if let userData = DataDecoder.decodeData(data, type: ProductSubCategoryModel.self) {
                        if let data1 = userData.data{
                            self.productSubCategory = data1
                        }
                    }
                    print("Count == \(self.productSubCategory?.count)")
                    self.observer?.ProductSubCategoryApi(postCount: self.productSubCategory?.count ?? 0)
                } else {

//                    self.observer?.ProductSubCategoryApi(postCount: self.productSubCategory?.count ?? 0)
                    Singleton.shared.showErrorMessage(error:  response["message"] as? String ?? "", isError: .error)
                }
            }
        }
    }
    
    
    func productSubCategoryListUserApi(name: String, subcatId: String, dispensaryId: String){
        let params: [String: Any] = [
            "subcat_id": subcatId,
            "dispensary_id" : dispensaryId,
            "name": name
        ]
        print("params are : \(params)")
        ActivityIndicator.sharedInstance.showActivityIndicator()
        ApiHandler.updateProfile(apiName: API.Name.productDetailUser, params: params, profilePhoto: nil, coverPhoto: nil) { succeeded, response, data in
            ActivityIndicator.sharedInstance.hideActivityIndicator()
            DispatchQueue.main.async {
                print("api responce : \(response) \(succeeded)")
                if succeeded == true {
                    if let userData = DataDecoder.decodeData(data, type: ProductSubCategoryModel.self) {
                        if let data1 = userData.data{
                            self.productSubCategory = data1
                        }
                    }
                    print("Count == \(self.productSubCategory?.count)")
                    self.observer?.ProductSubCategoryApi(postCount: self.productSubCategory?.count ?? 0)
                } else {

//                    self.observer?.ProductSubCategoryApi(postCount: self.productSubCategory?.count ?? 0)
                    Singleton.shared.showErrorMessage(error:  response["message"] as? String ?? "", isError: .error)
                }
            }
        }
    }
    
    
    
    func productGuestSubCategoryListUserApi(name: String, subcatId: String, dispensaryId: String){
        let params: [String: Any] = [
            "subcat_id": subcatId,
            "dispensary_id" : dispensaryId,
            "name": name
        ]
        print("params are : \(params)")
        ActivityIndicator.sharedInstance.showActivityIndicator()
        ApiHandler.updateProfileWithoutToken(apiName: API.Name.productDetailGuestUser, params: params, profilePhoto: nil, coverPhoto: nil) { succeeded, response, data in
            ActivityIndicator.sharedInstance.hideActivityIndicator()
            DispatchQueue.main.async {
                print("api responce : \(response) \(succeeded)")
                if succeeded == true {
                    if let userData = DataDecoder.decodeData(data, type: ProductSubCategoryModel.self) {
                        if let data1 = userData.data{
                            self.productSubCategory = data1
                        }
                    }
                    print("Count == \(self.productSubCategory?.count)")
                    self.observer?.ProductSubCategoryApi(postCount: self.productSubCategory?.count ?? 0)
                } else {

//                    self.observer?.ProductSubCategoryApi(postCount: self.productSubCategory?.count ?? 0)
                    Singleton.shared.showErrorMessage(error:  response["message"] as? String ?? "", isError: .error)
                }
            }
        }
    }
    
    
}
