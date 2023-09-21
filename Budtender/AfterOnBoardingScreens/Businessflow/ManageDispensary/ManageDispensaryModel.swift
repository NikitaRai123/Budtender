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
    var is_status: Int?
    var state_time: String?
    var end_time: String?
    var created: Int?
    var updated_at:String?
    var created_at: String?
    var is_switchon: String?
    var disable: Int?
}