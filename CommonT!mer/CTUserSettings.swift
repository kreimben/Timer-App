import SwiftUI
import Combine

public final class CTUserSettings: ObservableObject {
    
    public init() { }
    
    public let objectWillChange = PassthroughSubject<Void, Never>()
    
//    private let dispatch = DispatchQueue(label: "Timer", qos: .userInteractive, attributes: .concurrent, autoreleaseFrequency: .inherit, target: .global())
    
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
            DispatchQueue.main.async { // dispatch.async { 
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
    
    @UserDefault(key: "turnOffAds", value: false)
    public var turnOffAds: Bool {
        willSet {
            self.objectWillChange.send()
        }
    }
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
