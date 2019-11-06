import Foundation
import SwiftUI
import AVFoundation
import UIKit
import GoogleMobileAds
import Combine

import UserNotifications

class MainController: ObservableObject {
    
    @ObservedObject var userSettings = UserSettings()
    
    @Published var userDegrees: Double = 90.0 {
        didSet {
            floor(userDegrees)
        }
    }
    
    func floorDegree() {
        
        self.userDegrees -= Double(Int(Int(self.userDegrees) % 6))
        self.userDegrees = Double(Int(self.userDegrees))
    }
    
    //MARK:- AboutTimer
    
    var scheduledTimer: Timer? = Timer()
    var processedDegrees: Int = 90
    let finalMinus = 90.0
    
//    let settingUserNotifications = SettingUserNotifications()
    
    @Published public var isTimerStarted: Bool = false
    @Published public var isTimerEnded: Bool = false
    
    func timeConverter() -> String {
        if self.isTimerStarted {
            return String(format: "%02d:%02d", Int(Int((self.userDegrees + self.finalMinus) * 10) / 60), Int(Int((self.userDegrees + self.finalMinus) * 10)) % 60)
        } else {
            return String(format: "%02d:00", Int(Int((self.userDegrees + self.finalMinus) * 10) / 60))
        }
    }
    

    let center = UNUserNotificationCenter.current()
    
    let bicycleNotificationSound = UNNotificationSoundName("Default Bell.MA4")
    let bellStoreDoorNotificationSound = UNNotificationSoundName("Bell store door.MA4")
    let cookooNotificationSound = UNNotificationSoundName("Cookoo.MA4")
    let towerBellNotificationSound = UNNotificationSoundName("Tower bell.MA4")
    
    func timerStart() {
        self.scheduledTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timeUpdater), userInfo: nil, repeats: true)
        isTimerStarted = true
        print("Timer is STARTED!")
        
        //MARK:- Setting UserNotifications
        
        let setTimerAgainUserNotificationActionButton = UNNotificationAction(identifier: "SET_TIMER_AGAIN", title: "Set T!mer again", options: .foreground)
        let dismissUserNotificationActionButton = UNNotificationAction(identifier: "DISMISS", title: "Dismiss", options: .foreground)
        
        let category = UNNotificationCategory(identifier: "finishNotificationCategory", actions: [setTimerAgainUserNotificationActionButton, dismissUserNotificationActionButton], intentIdentifiers: [])
        
        center.setNotificationCategories([category])
        
        
        
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
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: (self.userDegrees + 90) * 10, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        
        
        center.add(request) { (error) in
            print("UNNotificationCenter add error: \(String(describing: error))")
        }
        print("-------------UserNotifications is setting done!")
    }
    
    @objc func timeUpdater() {
        
        if Double(self.userDegrees + self.finalMinus) > 0.1 {
            
            self.userDegrees -= 0.1
        } else {
            
            self.userDegrees = 0.05 - 90
            self.endTimer()
            self.showInterstitialAds()
        }
    }
    
    func endTimer() {
        
        isTimerStarted = false
        isTimerEnded = true
        
        self.scheduledTimer?.invalidate()
        self.scheduledTimer = nil
        
        print("Timer is ENDED")
    }
    
    func arrangeDegrees() {
        
        self.processedDegrees = Int(self.userDegrees) - Int(self.userDegrees) % 6
        
        self.userDegrees = Double(self.processedDegrees)
    }
    
    func initTimerToFull() {
        self.userDegrees = 269.99
    }
    
    func initTimerToZero() {
        self.userDegrees = -89.99
    }
    
    //MARK:- For scene delegate
    
    @Published var newDate = Date()
    
//    @Published var intervalSinceOldDate = 0.0
    
    
    
    func whenEnterBackground() {
        
        print("-------------excute \"whenEnterBackgound()\"")
        
        self.userSettings.oldDate = Date.init()
        print("            ㄴoldTime: \(self.userSettings.oldDate)")
    }
    
    func updateTimerForSceneDelegate() {
        
        print("-------------excute \"updateTimerForSceneDelegate()\"")
        
        self.newDate = Date()
        
        self.userSettings.storedTime = self.userSettings.oldDate.distance(to: self.newDate)
        
        print("            ㄴnewTime: \(self.newDate)")
        print("            ㄴstoredTime: \(self.userSettings.storedTime)")
        
        
    }
    
    //MARK:- About Ads
    
    @State var interstitial: GADInterstitial!
    
    func showInterstitialAds() {
        
        //        self.interstitial = GADInterstitial(adUnitID: "ca-app-pub-3940256099942544/4411468910")
        //
        //        let request = GADRequest()
        //        self.interstitial.load(request)
        //
        //        if self.isUserPurchased {
        //
        //            return
        //        } else {
        //
        //            if self.interstitial.isReady {
        //
        //                guard let root = UIApplication.shared.windows.first?.rootViewController else { return }
        //                self.interstitial.present(fromRootViewController: root)
        //
        //            } else {
        //                print("Interstitial advertisment is not ready.")
        //            }
        //        }
    }
}
