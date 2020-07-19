import SwiftUI
import UIKit
import Combine
import UserNotifications

/// This class takes all of operations about timer
public class CTMainController: ObservableObject {
    
    @ObservedObject var userSettings = CTUserSettings()

    let center = UNUserNotificationCenter.current()
    
    /// @Notification Sounds
    let bicycleNotificationSound = UNNotificationSoundName("Default Bell")
    let bellStoreDoorNotificationSound = UNNotificationSoundName("Bell store door")
    let cookooNotificationSound = UNNotificationSoundName("Cookoo")
    let towerBellNotificationSound = UNNotificationSoundName("Tower bell")
    
    let bicycle2NotificationSound = UNNotificationSoundName("bicycle")
    let ghostNofiticationSound = UNNotificationSoundName("ghost")
    let homeBellNotificationSound = UNNotificationSoundName("home-bell")
    let elevatorNotificationSound = UNNotificationSoundName("elevator")
    let singleNotificationSound = UNNotificationSoundName("single")
    let zenNotificationSound = UNNotificationSoundName("zen")
    /// @END
    
    /// @For custom action in UserNotification
    var dismissAction: UNNotificationAction
    /// @END
    
    public init() {
        
        dismissAction = UNNotificationAction(
            identifier: "DISMISS_ACTION",
            title: "Dismiss",
            options: UNNotificationActionOptions(rawValue: 0)
        )
        
        let afterTimerEndCat = UNNotificationCategory(
            identifier: "AFTER_TIMER_END",
            actions: [/*self.rerunAction, */self.dismissAction],
            intentIdentifiers: [],
            hiddenPreviewsBodyPlaceholder: "",
            options: .allowAnnouncement)
        
        self.center.setNotificationCategories([afterTimerEndCat])
    }
    
    public func setNotificationTime(timeInterval: Double) {
        
        let content = UNMutableNotificationContent()
        content.title = "T!mer done"
        content.body = "Your T!mer is done!"
        content.categoryIdentifier = "AFTER_TIMER_END"
        
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
        case 5:
            content.sound = UNNotificationSound(named: self.bicycle2NotificationSound)
        case 6:
            content.sound = UNNotificationSound(named: self.ghostNofiticationSound)
        case 7:
            content.sound = UNNotificationSound(named: self.homeBellNotificationSound)
        case 8:
            content.sound = UNNotificationSound(named: self.elevatorNotificationSound)
        case 9:
            content.sound = UNNotificationSound(named: self.singleNotificationSound)
        case 10:
            content.sound = UNNotificationSound(named: self.zenNotificationSound)
        default:
            print("------------Error occured in fixing UNNotificationSound.")
        }
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        center.add(request) { (error) in
            if let err = error {
                print("UNNotificationCenter add error: \(String(describing: err.localizedDescription))")
            }
        }
        print("UserNotifications is setting done!")
    }
    
    public func isTimerRunning() -> Bool {
        
        let notificationTime = UserDefaults(suiteName: "group.com.KreimbenPro.Timer")?.value(forKey: "notificationTime") as? Date ?? Date()
        
        let result = Date().distance(to: notificationTime)
        
        return result > 0
    }
    
    public func setDisplay(completion: @escaping ((Double, CGFloat) -> Void)  ) {
        
        var time: Double = 0
        var atan2:CGFloat = 0
        
        if self.isTimerRunning() {
            
            guard let notiTime: Date = UserDefaults(suiteName: "group.com.KreimbenPro.Timer")?.value(forKey: "notificationTime") as? Date else { return }
            
            time = Date().distance(to: notiTime)
            atan2 = ((CGFloat(time) / 10) * (CGFloat.pi / 180))
        }
        
        completion(time, atan2)
    }
    
    public func generateHapticFeedback(as style: UIImpactFeedbackGenerator.FeedbackStyle) {
        
        /// @Generate hapticfeedback
        let gen = UIImpactFeedbackGenerator(style: style)
        gen.prepare()
        gen.impactOccurred(intensity: 30)
        /// @END
    }
    
    public func generateNotificationFeedback(as style: UINotificationFeedbackGenerator.FeedbackType) {

        /// @Input HapticTouch Feedback
        let notiGen = UINotificationFeedbackGenerator()
        notiGen.prepare()
        notiGen.notificationOccurred(style)
        /// @END
    }
    
    public func startTimer(with minute: TimeInterval, completion: @escaping ((Bool) -> Void)) {
        
        UserDefaults(suiteName: "group.com.KreimbenPro.Timer")?.setValue( Date().addingTimeInterval(minute), forKey: "notificationTime")
        
        self.setNotificationTime(timeInterval: minute)
        
        /// @For "Today Extension"
        UserDefaults(suiteName: "group.com.KreimbenPro.Timer")?.synchronize()
        /// @END
        
        completion(false)
    }
    
    public func stopTimer(completion: @escaping ((TimeInterval, CGFloat, Bool) -> Void)) {
        
        UserDefaults(suiteName: "group.com.KreimbenPro.Timer")?.setValue(Date(), forKey: "notificationTime")
        UserDefaults(suiteName: "group.com.KreimbenPro.Timer")?.synchronize()

        self.userSettings.timeInputBeforeConvert = -90
        self.userSettings.initialNotificationTime = 0
        
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        
        completion(0, 0, true)
    }
    
    public func adjustTimerValue(with amount: Double) -> Double {
        
        var amount = amount
        
        if amount >= 0 { // 순수 restOfTime이 양수 일 때
            
            amount = Double(Int(amount) - (Int(amount) % 6))
        } else { // 순수 restOfTime이 음수 일때
            
            amount = Double(Int(amount) + (Int(amount) % 6))
            
            if ((( Int(amount) + 90) * 10) % 60) == 20 {
                
                amount -= 2
            } else if ((( Int(amount) + 90) * 10) % 60) == 40 {
                
                amount -= 4
            }
        }
        
        return amount
    }
    
    public func shortcutSettingTimer(shortcutItemType type: String) {
        
        print("Shortcut Action: \(type)")
        
        if self.isTimerRunning() {
            
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
        
        self.setNotificationTime(timeInterval: self.userSettings.initialNotificationTime)
        
        // MARK: Interstitial
//        let interstitial = Interstitial()
//        interstitial.settingTimer()

        UserDefaults(suiteName: "group.com.KreimbenPro.Timer")?.setValue(self.userSettings.notificationTime, forKey: "notificationTime")
    }
}

//
//  CTMainController.swift
//  CommonT!mer
//
//  Created by Aksidion Kreimben on 7/16/20.
//  Copyright © 2020 Aksidion Kreimben. All rights reserved.
//
