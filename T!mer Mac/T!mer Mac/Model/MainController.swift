import Foundation
import SwiftUI
import Combine
import UserNotifications

class MainController: ObservableObject {
    
    @ObservedObject var userSettings = UserSettings()
    
    //MARK:- AboutTimer
    @Published var timeDisplay: TimeInterval = 0 // NECESSARY VARIABLE
    
    @ObservedObject var userTouchController = UserTouchController()

    let center = UNUserNotificationCenter.current()
    
    let bicycleNotificationSound = UNNotificationSoundName("Default Bell")
    let bellStoreDoorNotificationSound = UNNotificationSoundName("Bell store door")
    let cookooNotificationSound = UNNotificationSoundName("Cookoo")
    let towerBellNotificationSound = UNNotificationSoundName("Tower bell")
    
    func setNotificationWhenTimerStart(timeInterval: Double) {
        
        let content = UNMutableNotificationContent()
        content.title = "T!mer done"
        content.body = "Your T!mer is done!"
        content.categoryIdentifier = "finishNotificationCategory"
        
        switch self.userSettings.soundIndex {
        case 0:
            content.sound = UNNotificationSound.default
        case 1:
            content.sound = UNNotificationSound(named: self.bicycleNotificationSound)
        case 2:
            content.sound = UNNotificationSound(named: self.bellStoreDoorNotificationSound)
        case 3:
            content.sound = UNNotificationSound(named: self.cookooNotificationSound)
        case 4:
            content.sound = UNNotificationSound(named: self.towerBellNotificationSound)
        default:
            print("------------Error occured in fixing UNNotificationSound.")
        }
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: self.userSettings.initialNotificationTime, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        
        
        center.add(request) { (error) in
            if let err = error {
                print("UNNotificationCenter add error: \(String(describing: err.localizedDescription))")
            }
        }
        print("UserNotifications is setting done!")
    }
}

//
//  MainController.swift
//  T!mer Mac
//
//  Created by Aksidion Kreimben on 11/30/19.
//  Copyright © 2019 Aksidion Kreimben. All rights reserved.
//
