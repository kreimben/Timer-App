import Cocoa
import SwiftUI
import Combine
import UserNotifications

class MainViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    @ObservedObject var userSettings = UserSettings()
    @ObservedObject var mainController = MainController()
//    @EnvironmentObject var mainController: MainController
    
}

extension MainViewController {
    
    @IBAction func startTimer(_ sender: NSMenuItem) {
        
        /// @If timer is running, Cancle it.
        if self.userSettings.isTimerStarted {
            
            self.userSettings.isTimerStarted = false
            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        }
        /// @END
        
        /// @Change flag to start
        self.userSettings.isTimerStarted = true
        /// @END
        
        /// @Get title
        let title = sender.title
        /// @END
        
        /// @Get minute from title
        let arr = title.components(separatedBy: " ")
        guard let timeSecond = Double(String(arr[0])) else { return }
        /// @END
        
        /// @For debugging
        print("time: \(timeSecond)")
        /// @END
        
        /// @Set time to UserSettings()
        self.userSettings.initialNotificationTime = timeSecond * 60
        /// @END
        
        /// @Set Timer
        self.userSettings.notificationTime = Date().addingTimeInterval(self.userSettings.initialNotificationTime)
        self.mainController.setNotificationWhenTimerStart(timeInterval: self.userSettings.initialNotificationTime)
        /// @END
        
        /// @Set circle graphic to start timer
        ContentView.shared.VisualSettingsWhileTimerIsWorking()
        /// @END
    }
    
    @IBAction func stopTimer(_ sender: NSMenuItem) {
        
        ContentView.shared.stopTimer()
    }
    
    @IBAction func openPreference(_ sender: NSMenuItem) {
        
        print("openPreference pressed")
        ContentView.shared.preferenceSheet = true
        print("preferenceSheet: \(ContentView.shared.preferenceSheet)")
    }
}

//
//  MainViewController.swift
//  T!mer Mac
//
//  Created by Aksidion Kreimben on 11/30/19.
//  Copyright © 2019 Aksidion Kreimben. All rights reserved.
//
