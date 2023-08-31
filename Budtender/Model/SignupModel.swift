//
//  SignupModel.swift
//  Budtender
//
//  Created by dr mac on 31/08/23.
//

import Foundation
struct SignupModel :Decodable{
    var userId:String?
    var firstName:String?
    var lastName:String?
    var email:String?
    var password:String?
    var deviceToken:String?
    var deviceType:String?
    var latitude:String?
    var longitude:String?
    var oldPassword:String?
    var newPassword:String?
    var confirmPassword:String?
    var bio:String?
    var image:Data?
    var totalPhotos:String?
    var locatation :String?
    var description:String?
    var postImages:[Data]?
    var chatImages:[Data]?
    var thumImg:Data?
    var isBlock:String?
    var perPage :String?
    var pageno :String?
    var postId :String?
    var reasonId:String?
    var reportedId :String?
    var reportedBy :String?
    var isLike:String?
    var imageID:String?
    var otherUserId :String?
    var status :String?
    var blockUserId :String?
    var search:String?
    var roomID :String?
    var message:String?
    var document:Data?
    var comment:String?
    var commentId:String?
    var likeId:String?
    var replyCommentId:String?
    var replyMessage:String?
    var is_type:String?

    
    
    
    private enum CodingKeys : String, CodingKey {
        case firstName = "first_name", lastName = "last_name",email,password,latitude,longitude,deviceToken = "device_token",deviceType = "device_type",oldPassword = "old_password",newPassword = "new_password",confirmPassword,bio,image,totalPhotos = "total_photos",locatation,description,postImages = "post_images",isBlock = "is_block",perPage = "per_page",pageno,postId = "post_id",reasonId = "reason_id", reportedId = "reported_id" ,reportedBy = "reported_by", isLike = "is_like",imageID = "image_id",otherUserId = "otheruser_id",status,blockUserId = "block_user_id",userId = "user_id",search,roomID = "room_id",message, chatImages = "chat_images", document,comment,commentId = "comment_id",likeId = "like_id",replyCommentId = "reply_comment_id", replyMessage = "reply_message",thumImg,is_type
    }
    
    func convertDict()-> NSMutableDictionary {
        let dict = NSMutableDictionary()
        
        dict.setValue(self.is_type, forKey: "is_type")
        dict.setValue(self.replyMessage, forKey: "reply_message")
        dict.setValue(self.commentId, forKey: "comment_id")
        dict.setValue(self.likeId, forKey: "like_id")
        dict.setValue(self.message, forKey: "message")
        dict.setValue(self.chatImages, forKey: "chat_images")
        dict.setValue(self.document, forKey: "document")
        dict.setValue(self.search, forKey: "search")
        dict.setValue(self.userId, forKey: "user_id")
        dict.setValue(self.firstName, forKey: "first_name")
        dict.setValue(self.blockUserId, forKey: "block_user_id")
        dict.setValue(self.lastName, forKey: "last_name")
        dict.setValue(self.email, forKey: "email")
        dict.setValue(self.password, forKey: "password")
        dict.setValue(self.latitude, forKey: "latitude")
        dict.setValue(self.longitude, forKey: "longitude")
        dict.setValue(self.deviceType, forKey: "device_type")
        dict.setValue(self.deviceToken, forKey: "device_token")
        dict.setValue(self.oldPassword, forKey: "old_password")
        dict.setValue(self.newPassword, forKey: "new_password")
        dict.setValue(self.confirmPassword, forKey: "confirmPassword")
        dict.setValue(self.roomID, forKey: "room_id")
        dict.setValue(self.comment, forKey: "comment")
        dict.setValue(self.replyCommentId, forKey: "reply_comment_id")
        dict.setValue(self.thumImg, forKey: "thumImg")

        dict.setValue(self.bio, forKey: "bio")
        dict.setValue(self.image, forKey: "image")
        dict.setValue(self.totalPhotos, forKey: "total_photos")
        dict.setValue(self.locatation, forKey: "locatation")
        
        dict.setValue(self.description, forKey: "description")
        dict.setValue(self.postImages, forKey: "post_images")
        dict.setValue(self.isBlock, forKey: "is_block")
        dict.setValue(self.perPage, forKey: "per_page")
        dict.setValue(self.pageno, forKey: "pageno")
        dict.setValue(self.postId, forKey: "post_id")
        dict.setValue(self.reasonId, forKey: "reason_id")
        dict.setValue(self.reportedId, forKey: "reported_id")
        dict.setValue(self.reportedBy, forKey: "reported_by")
        dict.setValue(self.isLike, forKey: "is_like")
        dict.setValue(self.imageID, forKey: "image_id")
        dict.setValue(self.otherUserId, forKey: "otheruser_id")
        dict.setValue(self.status, forKey: "status")

        return dict
    }
}
