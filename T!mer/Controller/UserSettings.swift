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
    
    @UserDefault(key: "restOfTime", value: 0.0)
    var restOfTime: Double {
        willSet {
            objectWillChange.send()
        }
    }
    
    @UserDefault(key: "oldTime", value: Date())
    var oldTime: Date {
        willSet {
            objectWillChange.send()
        }
    }
    
    @UserDefault(key: "timeInterval", value: 0.0)
    var timeInterval: Double {
        willSet {
            objectWillChange.send()
        }
    }
    
    @UserDefault(key: "backgroundTimeIntervalSynchronized", value: true)
    var backgroundTimeIntervalSynchronized: Bool {
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
