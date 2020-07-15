import SwiftUI
import Combine

final class UserSettings: ObservableObject {
    
    let objectWillChange = PassthroughSubject<Void, Never>()
    
    @UserDefault(key: "soundIndex", value: 0) // Defining firstly
    var soundIndex: Int {
        willSet {
            objectWillChange.send() // Save value FOREVER
        }
    }
    
    /// @Color Number Index
    @UserDefault(key: "colorIndex", value: 0)
    var colorIndex: Int {
        willSet {
            objectWillChange.send()
            UserDefaults(suiteName: "group.com.KriembenPro.Timer")?.setValue(newValue, forKey: "colorIndex")
            
            print("Color Index at UserDefaults suite: \(String(describing: UserDefaults(suiteName: "group.com.KriembenPro.Timer")?.value(forKey: "colorIndex")))")
        }
    }
    /// @END
    
    @UserDefault(key: "timeInputBeforeConvert", value: 0.0)
    var timeInputBeforeConvert: Double {
        willSet {
            DispatchQueue.main.async {
                self.objectWillChange.send()
            }
        }
    }
    
    @UserDefault(key: "notificationTime", value: Date())
    var notificationTime: Date {
        willSet {
            DispatchQueue.main.async {
                self.objectWillChange.send()
            }
        }
    }
    
    @UserDefault(key: "initialNotificationTime", value: 0.0)
    var initialNotificationTime: Double {
        willSet {
            self.objectWillChange.send()
        }
    }
    
//    @UserDefault(key: "isTimerStarted", value: false)
//    var isTimerStarted: Bool {
//        willSet {
//            self.objectWillChange.send()
//        }
//    }
    
    /// @Write Review
    @UserDefault(key: "howManyOpenThisApp", value: 1)
    var howManyOpenThisApp: Int {
        willSet {
            objectWillChange.send()
        }
    }
    /// @END
    
    /// @For Check Update
    @UserDefault(key: "latestBuildVersion", value: 1)
    var latestBuildVersion: Int {
        willSet {
            objectWillChange.send()
        }
    }
    /// @END
    
    /// @Update Log Blur Value
    @UserDefault(key: "updateLogBlurValue", value: 5)
    var updateLogBlurValue: CGFloat {
        willSet {
            objectWillChange.send()
        }
    }
    /// @END
}

// MARK: - @propertyWrapper "UserDefault<T>

@propertyWrapper
struct UserDefault<T> {
    
    let key: String
    let value: T
    
    var wrappedValue: T {
        get {
            return UserDefaults.standard.object(forKey: key) as? T ?? value
        }
        set {
            return UserDefaults.standard.set(newValue, forKey: key)
        }
    }
}
