import Foundation
import SwiftUI
import UIKit
import GoogleMobileAds
import Combine

import UserNotifications

class MainController: ObservableObject {
    
    @ObservedObject var userSettings = UserSettings()
    
    //MARK:- AboutTimer
    
    @Published var isTimerStarted = false
    
    @ObservedObject var userTouchController = UserTouchController()

    let center = UNUserNotificationCenter.current()
    
    let bicycleNotificationSound = UNNotificationSoundName("Default Bell.MA4")
    let bellStoreDoorNotificationSound = UNNotificationSoundName("Bell store door.MA4")
    let cookooNotificationSound = UNNotificationSoundName("Cookoo.MA4")
    let towerBellNotificationSound = UNNotificationSoundName("Tower bell.MA4")
    
    func setNotificationWhenTimerStart() {
        
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
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: (self.userSettings.restOfTime + 90) * 10, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        
        
        center.add(request) { (error) in
            print("UNNotificationCenter add error: \(String(describing: error.debugDescription))")
        }
        print("-------------UserNotifications is setting done!")
    }
    
    
    //MARK:- For scene delegate
    
    var newDate = Date()
//    @Published var timeInterval = 0.0
    
    func whenEnterBackground() {
        
        print("-------------excute \"whenEnterBackgound()\"")
        
        self.userSettings.oldTime = Date.init()
        print("            ㄴoldTime: \(self.userSettings.oldTime)")
    }
    
//    func whenEnterForeground() {
//        
//        print("-------------excute \"whenEnterForeground()\"")
//        
//        self.newDate = Date()
//
//        self.userSettings.timeInterval = self.userSettings.oldTime.distance(to: self.newDate)
//        
//        print("            ㄴtimeInterval: \(self.userSettings.timeInterval)")
//    }
    
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
