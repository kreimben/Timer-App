//
//  PreferenceViewController.swift
//  T!mer Mac
//
//  Created by Aksidion Kreimben on 12/1/19.
//  Copyright © 2019 Aksidion Kreimben. All rights reserved.
//

import Cocoa
import SwiftUI
import Combine

class PreferenceViewController: NSViewController {
    
    @ObservedObject var userSettings = UserSettings()
    
    @IBOutlet var notificationSoundPopupButton: NSPopUpButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        self.view.wantsLayer = true
        self.view.layer?.backgroundColor = NSColor(red: 0, green: 0.55, blue: 1, alpha: 0.8).cgColor
        
        self.forInitialization()
    }
    
}

extension PreferenceViewController {
    
    func forInitialization() {
        
        notificationSoundPopupButton.removeAllItems()
        
        notificationSoundPopupButton.addItems(withTitles: [
            "Default Notification Sound",
            "Bicycle Bell",
            "Bell - Store door",
            "Cookoo",
            "Tower bell"
        ])
    }
}

extension PreferenceViewController {
    
    @IBAction func settingNotificationSound(_ sender: NSPopUpButton) {
        
        self.userSettings.soundIndex = sender.indexOfSelectedItem
        print("UserSettings's soundIndex: \(sender.indexOfSelectedItem)")
    }
}
