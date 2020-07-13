import UIKit
import StoreKit
import Combine
import SwiftUI
import CoreData

import GoogleMobileAds

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    // MARK: CoreData Stack
    lazy var persistentContainer: NSPersistentContainer = {

        let container = NSPersistentContainer(name: "TimerCoreData")
        container.loadPersistentStores { (storeDescription, error) in
            
            if let error = error as NSError? {
                
                fatalError("Error while load persistent container at AppDelegate: \(error), \(error.userInfo)")
            }
            
            print("Store Descripsion at AppDelegate: \(storeDescription)")
        }

        return container
    }()
    
    // MARK: - Core Data Saving support
    func saveContext() {
        
        let context = persistentContainer.viewContext
        
        if context.hasChanges {
            do {
                
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                
            }
        }
    }
    
    var mainController: MainController!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        mainController = MainController()
        
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        
        UNUserNotificationCenter.current().delegate = self
        
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
        
        switch response.actionIdentifier {
            
        case "DISMISS_ACTION":
            print("Select Dismiss")
            
        default:
            print("Default Dismiss")
            
        }
        
        completionHandler()
    }
    
    // MARK: - Open App from "Today Extension"
    
}

//
//  AppDelegate.swift
//  T!mer
//
//  Created by Aksidion Kreimben on 10/10/19.
//  Copyright © 2019 Aksidion Kreimben. All rights reserved.
//
