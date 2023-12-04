//
//  AppDelegate+custom.swift
//  EGame
//
//  Created by apple on 13/05/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

typealias JSON = [String: Any]


//MARK: SET NOTIFICATION
extension AppDelegate {
    
    func setNotification(_ application: UIApplication) {
//         For iOS 10 display notification (sent via APNS)
//        guard UserDefaultsCustom.firstTimeOpen == false else { return }
        
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: { _, _ in
                print("notificaiton allowed")
            })
//        UserDefaults.standard.setValue(nil, forKey: UserDefaultsCustom.messageKey)
        UNUserNotificationCenter.current().delegate = self
        application.registerForRemoteNotifications()
    }
    
}


//MARK:- Push notifications method(s)
extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print(print("didReceive response"), response.notification.request.content.userInfo)
        
        let userInfo = response.notification.request.content.userInfo
        if let aps = userInfo["aps"] as? [String: Any] {
            if let notifyData = aps["data"] as? [String:Any] {
                handleNotificationRedirection(data: notifyData)
            }
           
        }
        completionHandler()
    }
    
    func handleNotificationRedirection(data: [String: Any]) {
            let notificationTypeStr = data["type"] as? String ?? ""
        if notificationTypeStr == "3"{
            let idd = "\(UserDefaults.standard.integer(forKey: "Project_id"))"
            let id = data[idd] as? String ?? ""
            let rootVc = HomeVC()
            rootVc.selectedIndex = 0
            let nav =  UINavigationController()
            if #available(iOS 14.0, *) {
                nav.viewControllers = [rootVc, NotificationVC()]
            } else {
                // Fallback on earlier versions
            }
            nav.isNavigationBarHidden = true

            if #available(iOS 13.0, *) {
                if let scene = UIApplication.shared.connectedScenes.first {
                    let windowScene = (scene as? UIWindowScene)
                    print(">>> windowScene: \(windowScene)")
                    let window: UIWindow = UIWindow(frame: (windowScene?.coordinateSpace.bounds)!)
                    window.windowScene = windowScene //Make sure to do this
                    window.rootViewController = nav
                    window.makeKeyAndVisible()
                    self.window = window
                }
            } else {
                self.window?.rootViewController = nav
                self.window?.makeKeyAndVisible()
            }

        }
//        else{
//            let rootVc = TabBarVC()
//            rootVc.selectedIndex = 0
//            let nav =  UINavigationController()
//            nav.viewControllers = [rootVc, NotificationVC()]
//            nav.isNavigationBarHidden = true
//
//            if #available(iOS 13.0, *) {
//                if let scene = UIApplication.shared.connectedScenes.first {
//                    let windowScene = (scene as? UIWindowScene)
//                    print(">>> windowScene: \(windowScene)")
//                    let window: UIWindow = UIWindow(frame: (windowScene?.coordinateSpace.bounds)!)
//                    window.windowScene = windowScene //Make sure to do this
//                    window.rootViewController = nav
//                    window.makeKeyAndVisible()
//                    self.window = window
//                }
//            } else {
//                self.window?.rootViewController = nav
//                self.window?.makeKeyAndVisible()
//            }
//
//        }
    }

    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("APNs registration failed: \(error)")
    }
    
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        print("didReceiveRemoteNotification")
        let userDict = userInfo as! [String:Any]
        print("received", userDict)
        if application.applicationState == .inactive{
            
        }else{
            print("not invoked cause its in foreground")
        }
        completionHandler(.newData)
    }
    
    // Receive displayed notifications for iOS 10 devices.
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("willPresent notification")
        
        completionHandler([.alert, .badge, .sound])
    }
}

extension UIWindow {
    /// Returns the currently visible view controller if any reachable within the window.
    public static var visibleViewController: UIViewController? {
        let rootViewController = UIApplication.shared.windows.first(where: {$0.isKeyWindow})?.rootViewController
        return UIWindow.visibleViewController(from: rootViewController)
    }

    /// Recursively follows navigation controllers, tab bar controllers and modal presented view controllers starting
    /// from the given view controller to find the currently visible view controller.
    ///
    /// - Parameters:
    ///   - viewController: The view controller to start the recursive search from.
    /// - Returns: The view controller that is most probably visible on screen right now.
    public static func visibleViewController(from viewController: UIViewController?) -> UIViewController? {
        switch viewController {
        case let navigationController as UINavigationController:
            return UIWindow.visibleViewController(from: navigationController.visibleViewController ?? navigationController.topViewController)

        case let tabBarController as UITabBarController:
            return UIWindow.visibleViewController(from: tabBarController.selectedViewController)

        case let presentingViewController where viewController?.presentedViewController != nil:
            return UIWindow.visibleViewController(from: presentingViewController?.presentedViewController)

        default:
            return viewController
        }
    }
}
