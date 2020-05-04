import SwiftUI
import Combine
import UserNotifications

import GoogleMobileAds

class MainController: ObservableObject {
    
    @ObservedObject var userSettings = UserSettings()
    
    //MARK:- AboutTimer
    
    @ObservedObject var userTouchController = UserTouchController()

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
    
    init() {
        
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
    
    
    func setNotificationWhenTimerStart(timeInterval: Double) {
        
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
}
