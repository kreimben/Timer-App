//
//  EventMonitor.swift
//  Ambar
//
//  Created by Anagh Sharma on 12/11/19.
//  Copyright © 2019 Golden Chopper. All rights reserved.
//

import Cocoa
import SwiftUI

class EventMonitor {
    
    /// @Class properties
    private var monitor: Any?
    private let mask: NSEvent.EventTypeMask
    private let handler: (NSEvent?) -> Void
    /// @END
    
    /// @ObservedObject
    @ObservedObject var userSettings = UserSettings()
    /// @END
    
    public init(mask: NSEvent.EventTypeMask, handler: @escaping (NSEvent?) -> Void) {
        self.mask = mask
        self.handler = handler
    }
    
    deinit {
        stop()
    }
    
    /// @START
    public func start() {
        if self.userSettings.dismissByEventMonitor {
            monitor = NSEvent.addGlobalMonitorForEvents(matching: mask, handler: handler) as! NSObject
        }
    }
    /// @END
    
    /// @STOP
    public func stop() {
        if monitor != nil {
            NSEvent.removeMonitor(monitor!)
            monitor = nil
        }
    }
    /// @END
}
