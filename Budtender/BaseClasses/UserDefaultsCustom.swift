//
//  UserDefaultsCustom.swift
//  CullintonsCustomer
//
//  Created by Nitin Kumar on 04/04/18.
//  Copyright © 2018 Nitin Kumar. All rights reserved.
//

import UIKit
//import FirebaseMessaging
//import FirebaseCore

struct UserDefaultsCustom {
    static let deviceToken = "deviceToken"
    static let accessToken = "authToken"
    static let userData = "data"
    static let eventFieldsModel = "EventFieldsModel"
    
    
    static func getDeviceToken() -> String {
        if let value = UserDefaults.standard.value(forKey: Self.deviceToken) as? String {
            return value
        } else {
            return "authToken"
        }
    }
    
    static var firstTimeOpen: Bool {
        return UserDefaults.standard.value(forKey: "firstTimeOpen") == nil
    }
    
    static func setValue(value: Any?, for key:String) {
        UserDefaults.standard.setValue(value, forKey: key)
    }
    
//        static func getToken() -> String {
//            //        let token = Messaging.messaging().fcmToken
//            //        print("FCM token: \(token ?? "")")
//            //        return token ?? deviceToken
//            if let value = UserDefaults.standard.value(forKey: UserDefaultsCustom.Token) {
//                return value as! String
//            } else {
//                return ""
//            }
//        }
    
    static func getAccessToken() -> String {
        if let value = UserDefaults.standard.value(forKey: UserDefaultsCustom.getUserData()?.auth_token ?? "") {
            print("\(value)")
            return value as! String
        } else {
            return ""
        }
    }
    
    static func getValue(forKey: String) -> String? {
        if let value = UserDefaults.standard.value(forKey: forKey) {
            return value as? String
        }
        return nil
    }
    
    static func setValue(value: Any?, forKey:String) {
        UserDefaults.standard.setValue(value, forKey: forKey)
    }
    
    static func saveUserData(userData:UserData) {
        print("save user data")
        UserDefaults.standard.set(try? PropertyListEncoder().encode(userData), forKey:UserDefaultsCustom.userData)
    }
    
    static func getUserData() -> UserData? {
        if let data = UserDefaults.standard.value(forKey:UserDefaultsCustom.userData) as? Data {
            let userData = try? PropertyListDecoder().decode(UserData.self, from: data)

            return userData
        }
        return nil
    }
    
    static func getUserId() -> Int {
        if let data = UserDefaults.standard.value(forKey:UserDefaultsCustom.userData) as? Data {
            let userData = try? PropertyListDecoder().decode(UserData.self, from: data)
            return userData?.user_id ?? 0
        }
        return 0
    }
    
    
    
}


extension UserDefaults {
    class func setValue(value:Any?, for key:String) {
        UserDefaults.standard.setValue(value, forKey: key)
    }
    
    class func valueFor(key: String) -> Any? {
        return UserDefaults.standard.value(forKey: key)
    }
    
}
