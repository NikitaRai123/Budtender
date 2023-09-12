//
//  AppDefaults.swift
//  LoveFinder
//
//  Created by dr mac on 07/11/22.
//

import Foundation
struct AppDefaults {
    static var userID:Int?{
        set{
            UserDefaults.standard.set(newValue, forKey: "user_id")
        }
        get{
            return UserDefaults.standard.integer(forKey: "user_id")
        }
    }
    
    
//    static var userID:String?{
//        set{
//            UserDefaults.standard.set(newValue, forKey: "user_id")
//        }
//        get{
//            return UserDefaults.standard.string(forKey: "user_id")
//        }
//    }
    static var userProfileImage:String?{
        set{
            UserDefaults.standard.set(newValue, forKey: "profileImage")
        }
        get{
            return UserDefaults.standard.string(forKey: "profileImage") ?? "Unknown"
        }
    }
    static var lat:String?{
        set{
            UserDefaults.standard.set(newValue, forKey: "lat")
        }
        get{
            return UserDefaults.standard.string(forKey: "lat")
        }
    }
    static var long:String?{
        set{
            UserDefaults.standard.set(newValue, forKey: "long")
        }
        get{
            return UserDefaults.standard.string(forKey: "long")
        }
    }
    static var userCount:Int?{
        set{
            UserDefaults.standard.set(newValue, forKey: "user_count")
        }
        get{
            return UserDefaults.standard.integer(forKey: "user_count")
        }
    }
//    
//    static var msgCount:String?{
//        set{
//            UserDefaults.standard.set(newValue, forKey: "")
//        }
//        get{
//            return UserDefaults.standard.string(forKey: "")
//        }
//    }
//    static var updateMessageText:String?{
//        set{
//            UserDefaults.standard.set(newValue, forKey: "updateText")
//        }
//        get{
//            return UserDefaults.standard.string(forKey: "updateText")
//        }
//    }
//    static var profileComplete:String?{
//        set{
//            UserDefaults.standard.set(newValue, forKey: "profile_complete")
//        }
//        get{
//            return UserDefaults.standard.string(forKey: "profile_complete")
//        }
//    }
    static var token:String?{
        set{
            UserDefaults.standard.set(newValue, forKey: "auth_token")
        }
        get{
            return UserDefaults.standard.string(forKey: "auth_token")
        }
    }
//    
    static var userFirstName:String?{
        set{
            UserDefaults.standard.set(newValue, forKey: "first_name")
        }
        get{
            return UserDefaults.standard.string(forKey: "first_name")
        }
    }
    
    static var userLastName:String?{
        set{
            UserDefaults.standard.set(newValue, forKey: "last_name")
        }
        get{
            return UserDefaults.standard.string(forKey: "last_name")
        }
    }
//    
//    static var userName:String?{
//        set{
//            UserDefaults.standard.set(newValue, forKey: "name")
//        }
//        get{
//            return UserDefaults.standard.string(forKey: "name")
//        }
//    }
//    
//    static var loginId:String?{
//        set{
//            UserDefaults.standard.set(newValue, forKey: "login_id")
//        }
//        get{
//            return UserDefaults.standard.string(forKey: "login_id")
//        }
//    }
//    
//    static var userImage:String?{
//        set{
//            UserDefaults.standard.set(newValue, forKey: "image")
//        }
//        get{
//            return UserDefaults.standard.string(forKey: "image")
//        }
//    }
//    
//    static var userEmail:String?{
//        set{
//            UserDefaults.standard.set(newValue, forKey: "email")
//        }
//        get{
//            return UserDefaults.standard.string(forKey: "email")
//        }
//    }
//    static var userRemember:Bool?{
//        set{
//            UserDefaults.standard.set(newValue, forKey: "remember")
//        }
//        get{
//            return UserDefaults.standard.bool(forKey: "remember")
//        }
//    }
//    
//    static var userPassword:String?{
//        set{
//            UserDefaults.standard.set(newValue, forKey: "password")
//        }
//        get{
//            return UserDefaults.standard.string(forKey: "password")
//        }
//    }
//    
    static var deviceToken:String?{
        set{
            UserDefaults.standard.set(newValue, forKey: "deviceToken")
        }
        get{
            return UserDefaults.standard.string(forKey: "deviceToken") ?? "1234"
        }
    }
//    
//    static var reviewId:String?{
//        set{
//            UserDefaults.standard.set(newValue, forKey: "reviewId")
//        }
//        get{
//            return UserDefaults.standard.string(forKey: "reviewId")
//        }
//    }
//    static var notificationType:String?{
//        set{
//            UserDefaults.standard.set(newValue, forKey: "notificationType")
//        }
//        get{
//            return UserDefaults.standard.string(forKey: "notificationType")
//        }
//    }
//    static var notificationId:String?{
//        set{
//            UserDefaults.standard.set(newValue, forKey: "notification_id")
//        }
//        get{
//            return UserDefaults.standard.string(forKey: "notification_id")
//        }
//    }
//    
}

func setAppDefaults<T>(_ value:T,key: String) {
    UserDefaults.standard.set(value, forKey: key)
    UserDefaults.standard.synchronize()
}

func getAppDefaults<T>(key:String) -> T? {
    guard let value = UserDefaults.standard.value(forKey: key) as? T else {
        return nil
    }
    return value
}
func getSAppDefault(key:String) -> Any{
    let value = UserDefaults.standard.value(forKey: key)
    return value as Any
}
func removeAppDefaults(key: String) {
    UserDefaults.standard.removeObject(forKey: key)
    UserDefaults.standard.synchronize()
}


