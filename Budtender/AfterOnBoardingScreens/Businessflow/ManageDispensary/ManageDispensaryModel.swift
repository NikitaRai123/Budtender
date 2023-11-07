//
//  ManageDispensaryModel.swift
//  Budtender
//
//  Created by Dharmani on 21/09/23.
//

import Foundation

class ManageDispensaryModel: Codable{
    var status: Int?
    var message: String?
    var data: [DispensaryData]?
    var product_details: [ProductDetails]?
}
class DispensaryData: Codable{
    var id: Int?
    var user_id: Int?
    var name: String?
    var phone_number: String?
    var email: String?
    var country: String?
    var address: String?
    var city: String?
    var state: String?
    var postal_code: String?
    var website: String?
    var license: String?
    var expiration: String?
    var image: String?
    var disable: Int?
    var created: String?
    var created_at: String?
    var latitude: String?
    var longitude: String?
    var country_code: String?
    var dispensorytime: [Dispensorytime]?
}

class Dispensorytime: Codable{
    var id: Int?
    var user_id: Int?
    var dispensory_id: Int?
    var day_name: String?
    var is_type: Int?
    var state_time: String?
    var end_time: String?
    var created: Int?
    var updated_at:String?
    var created_at: String?
    var is_switchon: String?
    var disable: Int?
}
class ProductDetails: Codable{
    var product_id: Int?
    var user_id: Int?
    var category_id: Int?
    var subcat_id: Int?
    var dispensory_id: String?
    var product_name:String?
    var brand_name: String?
    var qty: String?
    var weight: String?
    var price: String?
    var description: String?
    var disable: Int?
    var image: String?
    var created: String?
    var created_at: String?
    var updated_at: String?
}

class OrderData: Codable {

    var discountAmount : Int?
    var orderId : Int?
    var pickup_details : PickupDetail?
    var product_details: ProductDetailData?
    var qty : Int?
    var rating : Int?
    var totalAmount : Int?
    
    
}

class PickupDetail: Codable {

    var birthday : String?
    var created : String?
    var createdAt : String?
    var dealCode : String?
    var disable : Int?
    var image : String?
    var name : String?
    var phoneNumber : String?
    var pickupId : Int?
    var pickupTime : String?
    var updatedAt : String?
    var userId : Int?
   
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if birthday != nil{
            dictionary["birthday"] = birthday
        }
        if created != nil{
            dictionary["created"] = created
        }
        if createdAt != nil{
            dictionary["created_at"] = createdAt
        }
        if dealCode != nil{
            dictionary["deal_code"] = dealCode
        }
        if disable != nil{
            dictionary["disable"] = disable
        }
        if image != nil{
            dictionary["image"] = image
        }
        if name != nil{
            dictionary["name"] = name
        }
        if phoneNumber != nil{
            dictionary["phone_number"] = phoneNumber
        }
        if pickupId != nil{
            dictionary["pickup_id"] = pickupId
        }
        if pickupTime != nil{
            dictionary["pickup_time"] = pickupTime
        }
        if updatedAt != nil{
            dictionary["updated_at"] = updatedAt
        }
        if userId != nil{
            dictionary["user_id"] = userId
        }
        return dictionary
    }
}

class ProductDetail: Codable{

    var brandName : String?
    var categoryId : Int?
    var created : String?
    var createdAt : String?
    var descriptionField : String?
    var disable : Int?
    var dispensoryId : String?
    var image : String?
    var price : String?
    var productId : Int?
    var productName : String?
    var qty : String?
    var subcatId : Int?
    var updatedAt : String?
    var userId : Int?
    var weight : String?

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if brandName != nil{
            dictionary["brand_name"] = brandName
        }
        if categoryId != nil{
            dictionary["category_id"] = categoryId
        }
        if created != nil{
            dictionary["created"] = created
        }
        if createdAt != nil{
            dictionary["created_at"] = createdAt
        }
        if descriptionField != nil{
            dictionary["description"] = descriptionField
        }
        if disable != nil{
            dictionary["disable"] = disable
        }
        if dispensoryId != nil{
            dictionary["dispensory_id"] = dispensoryId
        }
        if image != nil{
            dictionary["image"] = image
        }
        if price != nil{
            dictionary["price"] = price
        }
        if productId != nil{
            dictionary["product_id"] = productId
        }
        if productName != nil{
            dictionary["product_name"] = productName
        }
        if qty != nil{
            dictionary["qty"] = qty
        }
        if subcatId != nil{
            dictionary["subcat_id"] = subcatId
        }
        if updatedAt != nil{
            dictionary["updated_at"] = updatedAt
        }
        if userId != nil{
            dictionary["user_id"] = userId
        }
        if weight != nil{
            dictionary["weight"] = weight
        }
        return dictionary
    }
}

// MARK: - MyOrderData
class MyOrderData: Codable {
    
    let status: Int?
    let message: String?
    let lastPage: Bool?
    let data: [OrderData]?

    init(status: Int?, message: String?, lastPage: Bool?, data: [OrderData]?) {
        self.status = status
        self.message = message
        self.lastPage = lastPage
        self.data = data
    }
}
