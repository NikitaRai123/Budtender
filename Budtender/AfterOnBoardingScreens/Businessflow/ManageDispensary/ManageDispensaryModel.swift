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
    var product_details: [ProductDetail]?
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
class ProductDetail: Codable{
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
