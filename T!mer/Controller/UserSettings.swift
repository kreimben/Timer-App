:import Foundation
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
    
    @UserDefault(key: "isTimerStarted", value: false)
    var isTimerStarted: Bool {
        willSet {
            self.objectWillChange.send()
        }
    }
    
    @UserDefault(key: "isUserPurchased", value: false)
    var isUserPurchased: Bool {
        willSet {
            objectWillChange.send()
        }
    }
    
}

//MARK:- @propertyWrapper "UserDefault<T>

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
