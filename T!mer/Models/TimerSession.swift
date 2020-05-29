import Foundation

class TimerSession {
    
    /// @Boiler Plate for Singleton
    static var shared = TimerSession()
    
    private init() {
        
        self.timers = [TimerElement]()
    }
    /// @END
    
    var timers: [TimerElement]
}

//
//  TimerSession.swift
//  T!mer
//
//  Created by Aksidion Kreimben on 5/28/20.
//  Copyright © 2020 Aksidion Kreimben. All rights reserved.
//
