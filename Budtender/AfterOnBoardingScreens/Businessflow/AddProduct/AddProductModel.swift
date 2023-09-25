//
//  AddProductModel.swift
//  Budtender
//
//  Created by Dharmani on 25/09/23.
//

import Foundation

class AddProductModel:Codable{
    var status: Int?
    var message: String?
    var data: [ProductData]?
}

class ProductData: Codable{
    var category_id: Int?
    var category_name: String?
    var disable: Int?
    var created: String?
    var created_at: String?
    var updated_at: String?

}

class SubCategoryModel: Codable{
    var status: Int?
    var message: String?
    var data: [SubCategoryData]?
}
class SubCategoryData: Codable{
    var subcat_id: Int?
    var category_id: Int?
    var name: String?
    var disable: Int?
    var created: String?
    var created_at: String?
    var updated_at: String?
    var image: String?
}
 

