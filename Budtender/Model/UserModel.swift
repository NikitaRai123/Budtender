//
//  UserModel.swift
//  Budtender
//
//  Created by dr mac on 31/08/23.
//

import Foundation

class UserModel: Codable{

    var status: Int?
    var message: String?
    var data: UserData?
}

class UserData: Codable{
    
    var user_id: Int?
    var first_name: String?
    var last_name: String?
    var name: String?
    var email: String?
    var image: String?
    var disable: Int?
    var block: Int?
    var verification_code: String?
    var is_verified: Int?
    var is_subscribed: Int?
    var created: String?
    var created_at: String?
    var updated_at: String?
    var is_type: Int?
    var auth_token: String?
    var api_token: String?
    var device_type: String?
    var device_token: String?
    var google_id: String?
    var facebook_id: String?
    var apple_id: String?
}



//struct UserModel:Decodable{
//    var userID:String?
//    var firstName:String?
//    var lastName:String?
//    var email:String?
//    var password:String?
//    var image:String?
//    var block: Int?
//    var deviceType:String?
//    var deviceToken:String?
//    var authtoken:String?
//    var disable:String?
//    var emailVerification:String?
//    var verificationCode:String?
//    var creationAt:String?
//    var bio:String?
//    var latitude:String?
//    var longitude:String?
//    var totalFollowing:String?
//    var totalFollowers:String?
//    var post:String?
//    //    var replyDetail : UserModel?
//    var chatImages:[String]?
//    var postID, isDelete, locatation: String?
//    var description, totalPhotos, postPrivacy, isDisable: String?
////    var postImg: [postImgq]?
//    var name, likeCount, isLike: String?
//    var reasonID :String?
//    var reportReason :String?
//    var isDraft :String?
//    var id,otheruserID, roomID: String?
//    var lastMessage: String?
//    var lastMessageTime,isFollow, commentCount, messageCount: String?
//    var notificationID: String?
//    var message: String?
//    var title, notificatationType, otherID: String?
//    var notificationReadStatus, images: String?
//    var otherUsername: String?
//    var otheruserImage: String?
//    var  isBlock: String?
//    var isSelected :Bool?
//    var postimgss:String?
//    var document:String?
//    var imageCount:String?
//    var isRemove :String?
//
//
//    var isVerified: Int?
//    var isType: String?
//    var created: Int?
//    var updatedAt, createdAt: String?
//    mutating func updateSelected(isSelected:Bool){
//        self.isSelected = isSelected
//    }
//    func getTimeString() -> String {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "hh:mm a"
//        return dateFormatter.string(from: Date(timeIntervalSince1970: Double(creationAt ?? "0") ?? 0.0))
//    }
//
//
//    private enum CodingKeys : String, CodingKey {
//        case userID = "user_id",firstName = "first_name",lastName = "last_name",email,password,image,deviceType = "device_type",deviceToken = "device_token",authtoken = "authtoken",disable,emailVerification = "email_verification",verificationCode = "verification_code",creationAt = "creation_at",bio,latitude = "Latitude",longitude = "Longitude",totalFollowing,totalFollowers,post,chatImages,
//             postID = "post_id",isDelete = "is_delete",locatation,description,totalPhotos = "total_photos",postPrivacy = "post_privacy",isDisable = "is_disable",name,likeCount, isLike,reasonID = "reason_id",reportReason = "report_reason", isDraft = "is_draft",id,otheruserID = "otheruser_id",roomID = "room_id",lastMessage, lastMessageTime, messageCount,isFollow = "is_follow",commentCount,isSelected,postimgss,document,
//             notificationID = "notification_id"
//        case message, title
//        case notificatationType = "notificatation_type"
//        case otherID = "other_id"
//        case notificationReadStatus = "notification_read_status"
//        case images
//        case otherUsername = "other_username"
//        case otheruserImage = "otheruser_image"
//        case isBlock = "is_block"
//        case imageCount = "image_count"
//        case isRemove =  "is_remove"
//        case isVerified = "is_verified"
//        case isType = "is_type"
//        case created
//        case updatedAt = "updated_at"
//        case createdAt = "created_at"
//
//        //        ,replyDetail = "reply_detai
//    }
//
//    func convertDict()-> NSMutableDictionary{
//        let dict = NSMutableDictionary()
//        dict.setValue(self.isVerified, forKey: "is_verified")
//        dict.setValue(self.isType, forKey: "is_type")
//        dict.setValue(self.created, forKey: "created")
//        dict.setValue(self.updatedAt, forKey: "updated_at")
//        dict.setValue(self.createdAt, forKey: "created_at")
//
//        dict.setValue(self.isRemove, forKey: "is_remove")
//
//        dict.setValue(self.document, forKey: "document")
//        dict.setValue(self.imageCount, forKey: "image_count")
//        dict.setValue(self.postimgss, forKey: "postimgss")
//        dict.setValue(self.isBlock, forKey: "is_block")
//        dict.setValue(self.isSelected, forKey: "isSelected")
//        dict.setValue(self.notificationID, forKey: "notification_id")
//        dict.setValue(self.message, forKey: "message")
//        dict.setValue(self.title, forKey: "title")
//        dict.setValue(self.notificatationType, forKey: "notificatation_type")
//        dict.setValue(self.otherID, forKey: "other_id")
//        dict.setValue(self.notificationReadStatus, forKey: "notification_read_status")
//        dict.setValue(self.images, forKey: "images")
//        dict.setValue(self.otherUsername, forKey: "other_username")
//        dict.setValue(self.otheruserImage, forKey: "otheruser_image")
//        dict.setValue(self.otheruserID, forKey: "otheruser_id")
//        dict.setValue(self.roomID, forKey: "room_id")
//        dict.setValue(self.commentCount, forKey: "commentCount")
//
//        dict.setValue(self.userID, forKey: "user_id")
//        dict.setValue(self.firstName, forKey: "first_name")
//        dict.setValue(self.lastName, forKey: "last_name")
//        dict.setValue(self.email, forKey: "email")
//        dict.setValue(self.password, forKey: "password")
//        dict.setValue(self.image, forKey: "image")
//        dict.setValue(self.deviceType, forKey: "device_type")
//        dict.setValue(self.deviceToken, forKey: "device_token")
//        dict.setValue(self.authtoken, forKey: "authtoken")
//        dict.setValue(self.disable, forKey: "disable")
//        dict.setValue(self.emailVerification, forKey: "email_verification")
//        dict.setValue(self.creationAt, forKey: "creation_at")
//        dict.setValue(self.bio, forKey: "bio")
//        dict.setValue(self.latitude, forKey: "Latitude")
//        dict.setValue(self.longitude, forKey: "Longitude")
//        dict.setValue(self.totalFollowing, forKey: "totalFollowing")
//        dict.setValue(self.totalFollowers, forKey: "totalFollowers")
//        dict.setValue(self.post, forKey: "post")
//        dict.setValue(self.chatImages, forKey: "chatImages")
//        dict.setValue(self.postID, forKey: "post_id")
//        dict.setValue(self.isDelete, forKey: "is_delete")
//        dict.setValue(self.locatation, forKey: "locatation")
//        dict.setValue(self.description, forKey: "description")
//        dict.setValue(self.totalPhotos, forKey: "total_photos")
//        dict.setValue(self.postPrivacy, forKey: "post_privacy")
//        dict.setValue(self.isDisable, forKey: "is_disable")
//        dict.setValue(self.name, forKey: "name")
//        dict.setValue(self.likeCount, forKey: "likeCount")
//        dict.setValue(self.isLike, forKey: "isLike")
//        dict.setValue(self.reasonID, forKey: "reason_id")
//        dict.setValue(self.reportReason, forKey: "report_reason")
//        dict.setValue(self.isDraft, forKey: "is_draft")
//        dict.setValue(self.lastMessage, forKey: "lastMessage")
//        dict.setValue(self.lastMessageTime, forKey: "lastMessageTime")
//        dict.setValue(self.messageCount, forKey: "messageCount")
//        dict.setValue(self.isFollow, forKey: "is_follow")
//
//
//        return dict
//
//    }
//
//}
