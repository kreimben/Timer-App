//
//  UserSettings.swift
//  T!mer Mac
//
//  Created by Aksidion Kreimben on 11/30/19.
//  Copyright © 2019 Aksidion Kreimben. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

final class UserSettings: ObservableObject {
    
    @Published var isTerminate: Bool = false {
        willSet {
            print(newValue)
        }
    }
    
    let objectWillChange = PassthroughSubject<Void, Never>()
    
    /// @Notification Sound Number Index
    @UserDefault(key: "soundIndex", value: 0) // Defining firstly
    var soundIndex: Int {
        willSet {
            objectWillChange.send() // Save value FOREVER
        }
    }
    /// @END
    
    /// @Color Number Index
    @UserDefault(key: "colorIndex", value: 0)
    var colorIndex: Int {
        willSet {
            objectWillChange.send()
        }
    }
    /// @END
    
    /// @Time converting properties
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
    /// @END
    
    /// @ETC
    @UserDefault(key: "isTimerStarted", value: false)
    var isTimerStarted: Bool {
        willSet {
            self.objectWillChange.send()
        }
    }
    
    @UserDefault(key: "displayStringTime", value: true)
    var displayStringTime: Bool {
        willSet {
            objectWillChange.send()
        }
    }
    /// @END
    
    /// @Dismiss by "EventMonitor"
    @UserDefault(key: "dismissByEventMonitor", value: false)
    var dismissByEventMonitor: Bool {
        willSet {
            objectWillChange.send()
        }
    }
    /// @END
    
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
