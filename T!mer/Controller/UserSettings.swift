import Foundation
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
    
    @UserDefault(key: "storedTime", value: 5.0)
    var storedTime: Double {
        willSet {
            objectWillChange.send()
            
            print("            ㄴstoredTime: \(self.storedTime)")
        }
    }
    
    @UserDefault(key: "oldDate", value: Date())
    var oldDate: Date {
        willSet {
            objectWillChange.send()
        }
    }
    
    @UserDefault(key: "isAppInActiveButBeforeAdjustTime", value: true)
    var isAppInActiveButBeforeAdjustTime: Bool {
        willSet {
            objectWillChange.send()
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
