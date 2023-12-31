//
//  AddProductVM.swift
//  Budtender
//
//  Created by Dharmani on 25/09/23.
//

import Foundation
protocol AddProductVMObserver{
    func productCategoryApi()
    func createProductAPI()
    func dispensaryListApi()
    func searchHomeApi(postCount:Int)
}

class AddProductVM: NSObject{
    var imagePicker = GetImageFromPicker()
    var editImage: PickerData?
    var category: [ProductData]?
    var subCategory: [SubCategoryData]?
    var dispensaryList: [DispensaryData]?
    var dispensaryData: [dispensaryDetailData]?
    var observer: AddProductVMObserver?
    init(observer:AddProductVMObserver?) {
        self.observer = observer
    }
    
    func productListApi(){
        let params: [String: Any] = [
            :
        ]
        print("params are : \(params)")
        ActivityIndicator.sharedInstance.showActivityIndicator()
        ApiHandler.updateProfile(apiName: API.Name.productCategoryList, params: params, profilePhoto: nil, coverPhoto: nil) { succeeded, response, data in
            ActivityIndicator.sharedInstance.hideActivityIndicator()
            DispatchQueue.main.async {
                print("api responce : \(response) \(succeeded)")
                if succeeded == true {
                    if let userData = DataDecoder.decodeData(data, type: AddProductModel.self) {
                        if let data1 = userData.data{
                            self.category = data1
                        }
                        print(self.category?.count)
                    }
                    //                    Singleton.shared.showErrorMessage(error:  response["message"] as? String ?? "", isError: .success)
                    self.observer?.productCategoryApi()
                } else {
//                    self.observer?.ManageDispensaryApi(postCount: self.dispensary?.count ?? 0)
                    Singleton.shared.showErrorMessage(error:  response["message"] as? String ?? "", isError: .error)
                }
            }
        }
    }
    
    func productGuestListApi(){
        let params: [String: Any] = [
            :
        ]
        print("params are : \(params)")
        ActivityIndicator.sharedInstance.showActivityIndicator()
        ApiHandler.updateProfileWithoutToken(apiName: API.Name.productGuestCategoryList, params: params, profilePhoto: nil, coverPhoto: nil) { succeeded, response, data in
            ActivityIndicator.sharedInstance.hideActivityIndicator()
            DispatchQueue.main.async {
                print("api responce : \(response) \(succeeded)")
                if succeeded == true {
                    if let userData = DataDecoder.decodeData(data, type: AddProductModel.self) {
                        if let data1 = userData.data{
                            self.category = data1
                        }
                        print(self.category?.count)
                    }
                    //                    Singleton.shared.showErrorMessage(error:  response["message"] as? String ?? "", isError: .success)
                    self.observer?.productCategoryApi()
                } else {
//                    self.observer?.ManageDispensaryApi(postCount: self.dispensary?.count ?? 0)
                    Singleton.shared.showErrorMessage(error:  response["message"] as? String ?? "", isError: .error)
                }
            }
        }
    }
    
    
    func subCategoryListApi(id: String){
        let params: [String: Any] = [
            "category_id": id
        ]
        print("params are : \(params)")
        ActivityIndicator.sharedInstance.showActivityIndicator()
        ApiHandler.updateProfile(apiName: API.Name.subCategoryList, params: params, profilePhoto: nil, coverPhoto: nil) { succeeded, response, data in
            ActivityIndicator.sharedInstance.hideActivityIndicator()
            DispatchQueue.main.async {
                print("api responce : \(response) \(succeeded)")
                if succeeded == true {
                    if let userData = DataDecoder.decodeData(data, type: SubCategoryModel.self) {
                        if let data1 = userData.data{
                            self.subCategory = data1
                        }
                    }
                    //                    Singleton.shared.showErrorMessage(error:  response["message"] as? String ?? "", isError: .success)
                    self.observer?.productCategoryApi()
                } else {
//                    self.observer?.ManageDispensaryApi(postCount: self.dispensary?.count ?? 0)
                    Singleton.shared.showErrorMessage(error:  response["message"] as? String ?? "", isError: .error)
                }
            }
        }
    }
    
    func subCategoryGuestListApi(id: String, name: String){
        let params: [String: Any] = [
            "category_id": id,
            "name":name
        ]
        print("params are : \(params)")
        ActivityIndicator.sharedInstance.showActivityIndicator()
        ApiHandler.updateProfile(apiName: API.Name.subCategoryGuestList, params: params, profilePhoto: nil, coverPhoto: nil) { succeeded, response, data in
            ActivityIndicator.sharedInstance.hideActivityIndicator()
            DispatchQueue.main.async {
                print("api responce : \(response) \(succeeded)")
                if succeeded == true {
                    if let userData = DataDecoder.decodeData(data, type: SubCategoryModel.self) {
                        if let data1 = userData.data{
                            self.subCategory = data1
                        }
                    }
                    //                    Singleton.shared.showErrorMessage(error:  response["message"] as? String ?? "", isError: .success)
                    self.observer?.productCategoryApi()
                } else {
//                    self.observer?.ManageDispensaryApi(postCount: self.dispensary?.count ?? 0)
                    Singleton.shared.showErrorMessage(error:  response["message"] as? String ?? "", isError: .error)
                }
            }
        }
    }
    
    func homeSearchListApi(id: String,name: String){
        let params: [String: Any] = [
            "category_id": id,
            "name":name
        ]
        print("params are : \(params)")
        ActivityIndicator.sharedInstance.showActivityIndicator()
        ApiHandler.updateProfile(apiName: API.Name.subCategoryList, params: params, profilePhoto: nil, coverPhoto: nil) { succeeded, response, data in
            ActivityIndicator.sharedInstance.hideActivityIndicator()
            DispatchQueue.main.async {
                print("api responce : \(response) \(succeeded)")
                if succeeded == true {
                    if let userData = DataDecoder.decodeData(data, type: SubCategoryModel.self) {
                        if let data1 = userData.data{
                            self.subCategory = data1
                        }
                    }
                    //                    Singleton.shared.showErrorMessage(error:  response["message"] as? String ?? "", isError: .success)
                    self.observer?.searchHomeApi(postCount: self.subCategory?.count ?? 0)
                } else {
                    self.observer?.searchHomeApi(postCount: self.subCategory?.count ?? 0)
//                    self.observer?.ManageDispensaryApi(postCount: self.dispensary?.count ?? 0)
                    Singleton.shared.showErrorMessage(error:  response["message"] as? String ?? "", isError: .error)
                }
            }
        }
    }
    
    
    
    func dispensaryListApi(isStatus: String){
        let params: [String: Any] = [
            "is_type": isStatus
        ]
        print("params are : \(params)")
        ActivityIndicator.sharedInstance.showActivityIndicator()
        ApiHandler.updateProfile(apiName: API.Name.dispensaryDetailList, params: params, profilePhoto: nil, coverPhoto: nil) { succeeded, response, data in
            ActivityIndicator.sharedInstance.hideActivityIndicator()
            DispatchQueue.main.async {
                print("api responce : \(response) \(succeeded)")
                if succeeded == true {
                    if let userData = DataDecoder.decodeData(data, type: dispensaryDetailModel.self) {
                        if let data1 = userData.data{
                            self.dispensaryData = data1
                        }
                    }
                    self.observer?.dispensaryListApi()
                } else {
//                    self.observer?.ManageDispensaryApi(postCount: self.dispensary?.count ?? 0)
                    Singleton.shared.showErrorMessage(error:  response["message"] as? String ?? "", isError: .error)
                }
            }
        }
    }
    
    func addProductApi(isStatus: String, categoryID: String, subCatID: String, dispensaryID: String, productNAme: String, brandName:String, qty: String,weight: String, price: String, description: String, image: String){
        let params: [String: Any] = [
            "is_type": isStatus,
            "category_id": categoryID,
            "subcat_id": subCatID,
            "dispensory_id": dispensaryID,
            "product_name": productNAme,
            "brand_name": brandName,
            "qty": qty,
            "weight": weight,
            "price": price,
            "description": description,
            "image": image
        ]
        print("params are : \(params)")
        ActivityIndicator.sharedInstance.showActivityIndicator()
        ApiHandler.updateProfile(apiName: API.Name.createProduct, params: params, profilePhoto: editImage, coverPhoto: nil) { succeeded, response, data in
            ActivityIndicator.sharedInstance.hideActivityIndicator()
            DispatchQueue.main.async {
                print("api responce : \(response) \(succeeded)")
                if succeeded == true {
                    //                    if let userData = DataDecoder.decodeData(data, type: ManageDispensaryModel.self) {
                    //                        if let data1 = userData.data{
                    //                            self.dispensaryList = data1
                    //                        }
                    //                    }
                    Singleton.shared.showErrorMessage(error:  response["message"] as? String ?? "", isError: .success)
                    self.observer?.createProductAPI()
                } else {
                 
                    Singleton.shared.showErrorMessage(error:  response["message"] as? String ?? "", isError: .error)
                }
            }
        }
    }
    func editProductApi(isStatus: String,productId: String, categoryID: String, subCatID: String, dispensaryID: String, productNAme: String, brandName:String, qty: String,weight: String, price: String, description: String, image: String){
        let params: [String: Any] = [
            "is_type": isStatus,
            "product_id": productId,
            "category_id": categoryID,
            "subcat_id": subCatID,
            "dispensory_id": dispensaryID,
            "product_name": productNAme,
            "brand_name": brandName,
            "qty": qty,
            "weight": weight,
            "price": price,
            "description": description,
            "image": image
        ]
        print("params are : \(params)")
        ActivityIndicator.sharedInstance.showActivityIndicator()
        ApiHandler.updateProfile(apiName: API.Name.editProduct, params: params, profilePhoto: editImage, coverPhoto: nil) { succeeded, response, data in
            ActivityIndicator.sharedInstance.hideActivityIndicator()
            DispatchQueue.main.async {
                print("api responce : \(response) \(succeeded)")
                if succeeded == true {
                    //                    if let userData = DataDecoder.decodeData(data, type: ManageDispensaryModel.self) {
                    //                        if let data1 = userData.data{
                    //                            self.dispensaryList = data1
                    //                        }
                    //                    }
                    Singleton.shared.showErrorMessage(error:  response["message"] as? String ?? "", isError: .success)
                    self.observer?.createProductAPI()
                } else {
                 
                    Singleton.shared.showErrorMessage(error:  response["message"] as? String ?? "", isError: .error)
                }
            }
        }
    }
    
}
