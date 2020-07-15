import SwiftUI
import Combine

public final class CTUserSettings: ObservableObject {
    
    public init() { }
    
    public let objectWillChange = PassthroughSubject<Void, Never>()
    
    @UserDefault(key: "soundIndex", value: 0) // Defining firstly
    public var soundIndex: Int {
        willSet {
            objectWillChange.send() // Save value FOREVER
        }
    }
    
    /// @Color Number Index
    @UserDefault(key: "colorIndex", value: 0)
    public var colorIndex: Int {
        willSet {
            objectWillChange.send()
            UserDefaults(suiteName: "group.com.KriembenPro.Timer")?.setValue(newValue, forKey: "colorIndex")
            
            print("Color Index at UserDefaults suite: \(String(describing: UserDefaults(suiteName: "group.com.KriembenPro.Timer")?.value(forKey: "colorIndex")))")
        }
    }
    /// @END
    
    @UserDefault(key: "timeInputBeforeConvert", value: 0.0)
    public var timeInputBeforeConvert: Double {
        willSet {
            DispatchQueue.main.async {
                self.objectWillChange.send()
            }
        }
    }
    
    @UserDefault(key: "notificationTime", value: Date())
    public var notificationTime: Date {
        willSet {
            DispatchQueue.main.async {
                self.objectWillChange.send()
            }
        }
    }
    
    @UserDefault(key: "initialNotificationTime", value: 0.0)
    public var initialNotificationTime: Double {
        willSet {
            self.objectWillChange.send()
        }
    }
    
    /// @Write Review
    @UserDefault(key: "howManyOpenThisApp", value: 1)
    public var howManyOpenThisApp: Int {
        willSet {
            objectWillChange.send()
        }
    }
    /// @END
}

// MARK: - @propertyWrapper "UserDefault<T>

@propertyWrapper
public struct UserDefault<T> {
    
    let key: String
    let value: T
    
    public var wrappedValue: T {
        get {
            return UserDefaults.standard.object(forKey: key) as? T ?? value
        }
        set {
            return UserDefaults.standard.set(newValue, forKey: key)
        }
    }
}

//
//  CTUserSettings.swift
//  CommonT!mer
//
//  Created by Aksidion Kreimben on 7/16/20.
//  Copyright © 2020 Aksidion Kreimben. All rights reserved.
//
