//
//  AppDelegate.swift
//  T!mer Mac
//
//  Created by Aksidion Kreimben on 11/30/19.
//  Copyright © 2019 Aksidion Kreimben. All rights reserved.
//

import Cocoa
import SwiftUI
import UserNotifications

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    let popover = NSPopover()
    
    let mainController = MainController()

    var window: NSWindow!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        
        let contentView = ContentView()

        popover.contentViewController = MainViewController()
        popover.contentSize = NSSize(width: 500, height: 300)
        popover.contentViewController?.view = NSHostingView(rootView: contentView.environmentObject(mainController))
        
        StatusBarController.popover = self.popover
        
        /// @Setting Notification
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                print("UserNotifications request authorization: \(granted.description)")
            } else if error != nil {
                print("UserNotifications request authorization: \(error.debugDescription)")
            }
        }
        /// @END
    }
    
    func applicationDidResignActive(_ notification: Notification) {
        print("Resign")
        
    }
    
}
