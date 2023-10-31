//
//  Constant.swift
//  LoveFinder
//
//  Created by dr mac on 07/11/22.
//

import Foundation
// old url
let baseUrl = "http://161.97.132.85/budtender/api/"

class ApiConstant: NSObject {
    
    static let appName = "BudTender"
    static let Login = baseUrl + "login"
    static let SignUp = baseUrl + "signup"
    static let ForgotPassword = baseUrl + "forgetPassword"
    static let getProfile = baseUrl + "getProfile"
    static let editProfile = baseUrl + "Editprofile.php"
    static let deleteProfileAccount = baseUrl + "DeleteAccount.php"
    static let logoutProfile = baseUrl + "LogOut.php"
    static let createPost = baseUrl + "CreatePost.php"
    static let blockList = baseUrl + "GetAllBlockUserList.php"
    static let AddblockUnblock = baseUrl + "AddBlockUnblock.php"
    static let HomeLisitng = baseUrl + "Home.php"
    static let sendShareDetails = baseUrl + "SendShareDetails.php"
    static let AddCommentfavourite = baseUrl + "AddCommentfavourite.php"
    static let SaveBookmark = baseUrl + "SaveDraft.php"
    static let SaveBookmarkListing = baseUrl + "GetAllDraftDetailsByUserId.php"
    static let getOtherProfile = baseUrl + "getotheruserprofle.php"
    static let reportListing = baseUrl + "Getreportreason.php"
    static let addReport = baseUrl + "Addreport.php"
    static let homeDetails = baseUrl + "HomeDetails.php"
    static let getNotification = baseUrl + "GetNotificatationDetails.php"
    static let editPost = baseUrl + "EditPost.php"
    static let deletePostID = baseUrl + "DeletePostByPostId.php"
    static let imageFav = baseUrl + "imagefav.php"
    static let getFollower = baseUrl + "FollowUnflowlistByUserid.php"
    static let addFollowUnFollow = baseUrl + "AddFollowUnflow.php"
    static let createRoom = baseUrl + "CreateRoom.php"
    static let getAllChatUser = baseUrl + "getAllChatUser.php"
    static let deleteChatUser = baseUrl + "DeleteChat.php"

    static let deleteFollow = baseUrl + "DeleteFollow.php"
    static let getAllSearchUser = baseUrl + "GetAllSearchUser.php"
    static let getAllChatMsg = baseUrl + "getAllChatMsg.php"
    static let sendMsg = baseUrl + "SendMsg.php"
    static let updateMsg = baseUrl + "updatemsgseen.php"
    static let getReportReason = baseUrl + "Getreportreason.php"
    static let AddComment = baseUrl + "AddComment.php"
    static let AddCommentReply = baseUrl + "AddCommentReply.php"
    static let getAllCommentList = baseUrl + "GetAllComentlist.php"
    static let ChangePassword = baseUrl + "Changepassword.php"
    static let getAllFollowerList = baseUrl + "Getallfollowerlistdetails.php"
    static let favourite = baseUrl + "favourite.php"
    static let notInterested = baseUrl + "not_interested.php"
    static let chatListing = baseUrl + "get_all_chat_userv2.php"
    static let chatMessageDetail = baseUrl + "get_all_message.php"
    static let sendMessage = baseUrl + "send_message.php"
    static let deletechat = baseUrl + "delete_chat.php"
    static let reportUser = baseUrl + "report_user.php"
    static let blockUser = baseUrl + "block_user.php"
    static let updateChatStatus = baseUrl + "update_chat_status.php"
    static let aboutUs = baseUrl + "AboutUs.html"
    static let termConditons = baseUrl + "TermsAndConditation.html"
    static let privacyPolicy = baseUrl + "PrivacyandPolicy.html"
    static let addCart = baseUrl + "addCart"
    static let cartListing = baseUrl + "cartListing"
    
    static let firstName = "Please enter first name"
    static let lastName = "Please enter last name"
    static let emailAddress = "Please enter email address"
    static let validEmailAddress = "Enter valid email"
    static let password = "Please enter password"
    static let validpassword = "Please enter minimum 6 digit password"
    static let termCondition = "Please agree with Privacy Policy."

}

