//
//  AppDelegate.swift
//  Budtender
//
//  Created by apple on 07/08/23.
//

import UIKit
import IQKeyboardManagerSwift
import Firebase
import FirebaseCore
import GoogleSignIn
import FacebookCore
import GoogleMaps
import GooglePlaces
//import SideMenu
@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    static var shared: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        //print(UIFont.fontNames(forFamilyName: "coolvetica"))
//        let splash = LoginTypeVC()
//        let navController = UINavigationController(rootViewController: splash)
        sleep(5)
//        navController.navigationBar.isHidden = true
//        window?.rootViewController = splash
//        window?.makeKeyAndVisible()
        
        window = UIWindow(frame:UIScreen.main.bounds)
        application.applicationIconBadgeNumber = 0
        IQKeyboardManager.shared.enable = true
        
        GMSPlacesClient.provideAPIKey("AIzaSyAaO0eopDgMstq-zTuJjofRp_vaAg8786s")
//        GMSServices.provideAPIKey("AIzaSyD8J9CA5NYcS7zNJfEOFT6DDipZwVgesZA")
        
        self.setNotification(application)
        let accesstoken = UserDefaultsCustom.getUserData()
        if accesstoken?.auth_token?.count ?? 0 > 0 {
            if UserDefaults.standard.string(forKey: "LoginType") == "business" {
                Singleton.shared.setBussinessHome(window: self.window)
            } else {
                Singleton.shared.setHomeView(window: self.window)
            }   
        } else if UserDefaults.standard.string(forKey: "LoginType") == "guest" {
            Singleton.shared.setHomeView(window: self.window)
        } else {
            Singleton.shared.gotoLogin(window: self.window)
        }
        
        
        FirebaseApp.configure()
        ApplicationDelegate.shared.application(application,didFinishLaunchingWithOptions: launchOptions)
        return true
    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let deviceTokenString = deviceToken.map { String(format: "%02x", $0) }.joined()
        UserDefaults.standard.set(deviceTokenString, forKey: "deviceToken")
        debugPrint("device token is \(deviceTokenString)")
        AppDefaults.deviceToken = deviceTokenString
//        UserDefaults.standard.set(deviceTokenString, forKey: DefaultKeys.deviceToken)
    }
    
    
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

