//
//  ProductSubCategoryModel.swift
//  Budtender
//
//  Created by Dharmani on 27/09/23.
//

import Foundation

class ProductSubCategoryModel: Codable{
    var status: Int?
    var message: String?
    var data: [ProductSubCategoryData]?
    var subcat_name: String?
}
class ProductSubCategoryData: Codable{
    var product_id: Int?
    var user_id: Int?
    var category_id: Int?
    var subcat_id: Int?
    var dispensory_id: String?
    var product_name: String?
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
    var is_fav: String?
    var subcategories_name: String?
}
