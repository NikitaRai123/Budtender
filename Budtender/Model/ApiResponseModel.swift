//
//  ApiResponseModel.swift
//  LoveFinder
//
//  Created by dr mac on 01/11/22.
//

import Foundation

struct ApiResponseModel<T: Decodable> : Decodable{
    var data:T?
    var message:String?
    var status:Int?
    var isSave :String?
    var last_page: Bool?
    var is_follow:String?
//    var userDetails: UserDetails?
//    var Getpostimage: [Getpostimage]?
//    var notificationDetail: [NotificationDetail]?
//    var commentDetails : [CommentModel]?
}
