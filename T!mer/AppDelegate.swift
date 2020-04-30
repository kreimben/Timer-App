import UIKit
import StoreKit
import Combine
import SwiftUI

import GoogleMobileAds
//import SwiftyStoreKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    var mainController: MainController!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        mainController = MainController()
        
        
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        
        UNUserNotificationCenter.current().delegate = self
        
        ///FastLane!
        
        
//        SwiftyStoreKit.completeTransactions(atomically: true) { purchases in
//            /// Code's from official documentation at [https://github.com/bizz84/SwiftyStoreKit]
//            for purchase in purchases {
//                switch purchase.transaction.transactionState {
//                case .purchased, .restored:
//                    if purchase.needsFinishTransaction {
//                        /// Deliver content from server, then:
//                        SwiftyStoreKit.finishTransaction(purchase.transaction)
//                    }
//                    /// Unlock content
//                    
//                case .failed, .purchasing, .deferred:
//                    break /// Do nothing
//                @unknown default:
//                    fatalError("Error to App Delegate")
//                }
//            }
//        }
        
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        
        UNUserNotificationCenter.current().delegate = self
        
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
        
        print("did discard scene sessions at AppDelegate")
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        
    }
    
    // MARK: - UserNotificationCenter Foreground Setting Function
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        
        completionHandler([.alert, .sound])
    }
    
    // MARK: - UserNotificationCenter Background Setting Function
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        switch(response.actionIdentifier) {
            
        case "DISMISS_ACTION":
            print("Select Dismiss")
            
        default:
            print("Default Dismiss")
            
        }
        
        completionHandler()
    }
}

//
//  AppDelegate.swift
//  T!mer
//
//  Created by Aksidion Kreimben on 10/10/19.
//  Copyright © 2019 Aksidion Kreimben. All rights reserved.
//
