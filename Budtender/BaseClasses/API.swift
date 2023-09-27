//
//  API.swift
//  CullintonsCustomer
//
//  Created by Nitin Kumar on 03/04/18.
//  Copyright © 2018 Nitin Kumar. All rights reserved.
//

import UIKit

class API {
    static let imageHost:String  = "http://161.97.132.85/budtender/api/"//"https://dharmani.com/elisium/"//
//    static let host              = "http://18.218.198.255:8000"
    static let deviceType        = "1"
    static let version           = "1.0"
    static let baseUrl:String    = "https://elisiumart.com/"
    static let deviceToken       = "76534021"
    static let auth_token        = "4b51458edd8f86330ade9ce08f61439d"
   
    
    static let aboutlink = "https://elisiumart.com/about.php"//https://elisiumart.com/term&conditions.php
    static let helpLink = "https://elisiumart.com/help.php"
    static let termAndConditionLink = "https://elisiumart.com/term&conditions.php"//"https://dharmani.com/elisium/term&conditions.php"
    static let privacyLink = "https://elisiumart.com/privacyPolicy.php"
    
    
    enum DataKey: String {
        case dataKey = "pic"
    }
    
    struct Name {
        // MARK: LOGIN AND SOCIAL LOGIN CONSTANT API
        static let login                  = "login.php"
        static let signUpBusiness         = "signup"
        static let forgotPass             = "forgot-password.php"
        static let changePass             = "changePassword"
        static let googleLogin            = "googlelogin"
        static let editProfile            = "editProfile"//"webservice/editProfile.php"
        static let getProfile             = "getProfile"
        static let logout                 = "logout"
        static let deleteUserAccount      = "deleteUserAccount.php"
        static let Message                = "message"
        static let ReportList             = "getAllReportReasons.php"
        static let addEditVideo           = "addEditVideo.php"

        
       //MARK: HOME SCREEN
        static let CreateDispensary       = "createDispensory"
        static let dispensaryList         = "getDispensorylisting"
        static let dispensaryDetailList   = "getDispensorydetails"
        static let editDispensary         = "editDispensory"
        static let productCategoryList    = "getCategorylisting"
        static let subCategoryList        = "getSubcategorylisting"
        static let createProduct          = "createProduct"
        static let productSubCategoryList = "getProductlisting"
        static let projectType            = "getProjectType"
        static let HomeViewDetails        =  "getAllProjectDetails"
        static let deleteDispensary       = "deleteDispensory"
        static let projectProfileListing  = "getProfileTypes"
        static let getAllSearchUser       = "allUserSearchListing.php"
        static let addReport              = "addReport.php"
        static let projectProfileTypeListing  = "getProfileByType"
        static let addRecentSearch        = "add_recent_search"
        static let recentSearch             = "recentSearch"
        static let DeleteRecentSearch       = "remove_recent_search"
        static let viewProfileDetails        = "getProfile"
        static let EditProjectProfile       = "updateProfile"
        //MARK: Files
        static let filesListing       = "getAllfileTypes"
        static let addFile            = "add_files"
        static let fileDataList       = "getFileByType"
        //MARK: CREATE POST SCREEN
        static let createPost                 = "createEditPost.php"//"webservice/createEditPost.php"
        static let createBlogs                = "createBlog.php"
        
        //MARK: FINANCIAL SCREEN
        static let addFinancial                = "add_edit_financial"
        static let financialList               = "getFinancialDetails"
        
        //MARK: CHATLIST SCREEN
        static let GetChatUsers               = "getChatListV2.php"
        static let CheckChatRequest           = "checkChatRequest.php"
        static let sendMessage                = "sendMessage.php"
        static let getAllChatMessage          = "getAllChatMessageV2.php"
        static let sharePostBlogByMessage     = "sharePostBlogByMessage.php"
        static let userListingSharePostBlog   = "userListingSharePostBlog.php"
        
        //MARK: NOTIFICATION SCREEN
        static let Notification               = "getNotificationsListing.php"
        static let AcceptRejectFriend         = "acceptRejectFriendRequest.php"
        
        
        //MARK: SUBSCRIPTION SCREEN
                static let subscription               = "subscription"
                static let cancelSubscription         = "cancelSubscription"
                static let checkSubscription          = "checkSubscription"
    }
    
    struct keys {
        static let access_token = "access_token"
        static let country_code = "country_code"
        static let phone_no     = "phone_no"
        static let otp          = "otp"
        static let device_type  = "device_type"
        static let device_token = "device_token"
    }
    
    enum HttpMethod: String {
        case POST   = "POST"
        case GET    = "GET"
        case PUT    = "PUT"
        case DELETE = "DELETE"
    }
    
//    struct statusCodes {
//        static let INVALID_ACCESS_TOKEN = 401
//        static let BAD_REQUEST = 400
//        static let UNAUTHORIZED_ACCESS = 401
//        static let SHOW_MESSAGE = 201
//        static let SHOW_DATA = 200
//        static let SLOW_INTERNET_CONNECTION = 999
//    }
    
    struct statusCodes {
        static let FAILURE                  = 0
        static let INVALID_ACCESS_TOKEN     = 2
        static let BAD_REQUEST              = 400
        static let UNAUTHORIZED_ACCESS      = 401
        static let SHOW_MESSAGE             = 201
        static let SHOW_DATA                = 200
        static let SLOW_INTERNET_CONNECTION = 999
        static let ACCOUNT_DISABLE          = 403
      
    }
    
}

struct AlertMessage {
    static let ACCOUNT_DISABLE             = "Your account has been disabled, Please contact to support."
    static let INVALID_ACCESS_TOKEN        = "Product is being used on another device"
    static let SERVER_NOT_RESPONDING       = "Something went wrong while connecting to server!"
    static let NO_INTERNET_CONNECTION      = "Unable to connect with the server. Check your internet connection and try again."
    static let pleaseEnter                 = "Please enter "
    static let invalidEmailId              = "Please enter valid email id."
    static let enterEmailId                = "Please enter email id."
    static let invalidPassword             = "Please enter correct password."
    static let invalidPhoneNumber          = "Please enter valid phone."
    static let invalidPasswordLength       = "Password must contain atleast 6 characters"
    static let logoutAlert                 = "Are you sure you want to logout?"
    static let imageWarning                = "The image we have showed above is for reference purpose. Actual car could be slightly different."
    static let emptyMessage                = " can not be empty."
    static let bookingCreated              = "Booking created successfully"
    static let passwordMismatch            = "New password and confirm password does not match."
    static let passwordChangedSuccessfully = "Password changed successfully."
    static let pleaseEnterValid            = "Please enter valid "
    static let transactionSuccessful       = "Your transaction was successful"
    static let PROFILE_SAVED               = "Profile has been saved successfully"
}

struct ERROR_MESSAGE {
    static let NO_CAMERA_SUPPORT           = "This device does not support camera"
    static let NO_GALLERY_SUPPORT          = "Photo library not found in this device."
    static let REJECTED_CAMERA_SUPPORT     = "Need permission to open camera"
    static let REJECTED_GALLERY_ACCESS     = "Need permission to open Gallery"
    static let SOMETHING_WRONG             = "Something went wrong. Please try again."
    static let NO_INTERNET_CONNECTION      = "Unable to connect with the server. Check your internet connection and try again."
    static let SERVER_NOT_RESPONDING       = "Something went wrong while connecting to server!"
    static let INVALID_ACCESS_TOKEN        = "Invalid Access Token"
    static let ALL_FIELDS_MANDATORY        = "All Fields Mandatory"
    static let CALLING_NOT_AVAILABLE       = "Calling facility not available on this device."
}
