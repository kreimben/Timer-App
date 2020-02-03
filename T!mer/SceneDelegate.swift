import UIKit
import SwiftUI
import Foundation
import UserNotifications

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    @ObservedObject var mainController = MainController()
    @ObservedObject var userSettings = UserSettings()
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        
        // Create the SwiftUI view that provides the window contents.
        let contentView = ContentView()
        
        let mainController = MainController()
        
        // Use a UIHostingController as window root view controller.
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: contentView
                .environmentObject(mainController)
            )
            self.window = window
            window.makeKeyAndVisible()
        }
        
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
            
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
        
    }
}

extension SceneDelegate {
    
    func windowScene(_ windowScene: UIWindowScene, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) { // When The App Has Been Loaded.
        
        shortcutSettingTimer(shortcutIte≈mType: shortcutItem.type.description)
    }
    
    func shortcutSettingTimer(shortcutItemType type: String) {
        
        print("Shortcut Action: \(type)")
        
        if self.userSettings.isTimerStarted {
            
            self.userSettings.isTimerStarted = false
            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        }
        
        switch type {
            
        case "Set 15 Minutes":
            self.userSettings.initialNotificationTime = 15 * 60
        case "Set 30 Minutes":
            self.userSettings.initialNotificationTime = 30 * 60
        case "Set 45 Minutes":
            self.userSettings.initialNotificationTime = 45 * 60
        case "Set 60 Minutes":
            self.userSettings.initialNotificationTime = 60 * 60
        default:
            print("Error: shortcut settings")
        }
        
        self.userSettings.notificationTime = Date().addingTimeInterval(self.userSettings.initialNotificationTime)
        
        self.mainController.setNotificationWhenTimerStart(timeInterval: self.userSettings.initialNotificationTime)
        self.userSettings.isTimerStarted = true
        
        ContentView().shortcutVisualSettings()
    }
}
