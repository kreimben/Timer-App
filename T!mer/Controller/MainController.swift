import Foundation
import SwiftUI
import UIKit
import GoogleMobileAds
import Combine

import UserNotifications

class MainController: ObservableObject {
    
    @ObservedObject var userSettings = UserSettings()
    
    //MARK:- AboutTimer
    
//    @Published var isTimerStarted = false
    
    @ObservedObject var userTouchController = UserTouchController()

    let center = UNUserNotificationCenter.current()
    
    let bicycleNotificationSound = UNNotificationSoundName("Default Bell")
    let bellStoreDoorNotificationSound = UNNotificationSoundName("Bell store door")
    let cookooNotificationSound = UNNotificationSoundName("Cookoo")
    let towerBellNotificationSound = UNNotificationSoundName("Tower bell")
    
    func setNotificationWhenTimerStart() {
        
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
            print("UNNotificationCenter add error: \(String(describing: error.debugDescription))")
        }
        print("UserNotifications is setting done!")
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
