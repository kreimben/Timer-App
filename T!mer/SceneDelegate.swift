import UIKit
import SwiftUI
import Foundation
import UserNotifications

import CommonT_mer

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    @ObservedObject var mainController = CTMainController()
    @ObservedObject var userSettings = CTUserSettings()
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        let contentView = ContentView()
        
        let mainController = CTMainController()
        
        // MARK: CoreData Context
        guard let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext else {
            fatalError("Failed to load Persistent Container")
        }
        
        // Use a UIHostingController as window root view controller.
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: contentView
                .environmentObject(mainController).environment(\.managedObjectContext, context)
            )
            self.window = window
            window.makeKeyAndVisible()
        }
        
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .announcement]) { (granted, error) in
            
            if let error = error {
                
                print("requestAuthorization Error: \(error.localizedDescription)")
            }
            
            print("\(granted)")
        }
        
        if let shortcutItem = connectionOptions.shortcutItem { // When The App Hasn’t Been Loaded.
            
            shortcutSettingTimer(shortcutItemType: shortcutItem.type.description)
        }
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
        
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
        
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
        
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
        
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
        
        TimerEntities.saveContext()
    }
}

extension SceneDelegate {
    
    func windowScene(_ windowScene: UIWindowScene, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) { // When The App Has Been Loaded.
        
        shortcutSettingTimer(shortcutItemType: shortcutItem.type.description)
    }
    
    func shortcutSettingTimer(shortcutItemType type: String) {
        
        print("Shortcut Action: \(type)")
        
        if self.mainController.isTimerRunning() {
            
            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        }
        
        switch type {
            
        case "Set 3 Minutes":
            self.userSettings.initialNotificationTime = 60 * 3
        case "Set 15 Minutes":
            self.userSettings.initialNotificationTime = 60 * 15
        case "Set 30 Minutes":
            self.userSettings.initialNotificationTime = 60 * 30
        case "Set 60 Minutes":
            self.userSettings.initialNotificationTime = 60 * 60
        default:
            print("Error: shortcut settings")
        }
        
        self.userSettings.notificationTime = Date().addingTimeInterval(self.userSettings.initialNotificationTime)
        
        self.mainController.setNotificationWhenTimerStart(timeInterval: self.userSettings.initialNotificationTime)
        
        ContentView().visualSettingsWhileTimerIsWorking()
        
        // MARK: Interstitial
        let interstitial = Interstitial()
        interstitial.settingTimer()

        UserDefaults(suiteName: "group.com.KreimbenPro.Timer")?.setValue(self.userSettings.notificationTime, forKey: "notificationTime")
    }
}
