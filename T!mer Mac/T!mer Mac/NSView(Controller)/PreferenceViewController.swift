//
//  PreferenceViewController.swift
//  T!mer Mac
//
//  Created by Aksidion Kreimben on 12/1/19.
//  Copyright © 2019 Aksidion Kreimben. All rights reserved.
//

import Cocoa
import SwiftUI
import AppKit
import AVKit
import AVFoundation

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
        
        notificationSoundPopupButton.selectItem(at: userSettings.soundIndex)
    }
}

extension PreferenceViewController {
    
    @IBAction func settingNotificationSound(_ sender: NSPopUpButton) {
        
        self.userSettings.soundIndex = sender.indexOfSelectedItem
        print("UserSettings's soundIndex: \(sender.indexOfSelectedItem)")
        
        var path = String("")
        
        switch (self.userSettings.soundIndex) {
        case 1:
            path = Bundle.main.path(forResource: "Default Bell", ofType: nil)!
        case 2:
            path = Bundle.main.path(forResource: "Bell store door", ofType: nil)!
        case 3:
            path = Bundle.main.path(forResource: "Cookoo", ofType: nil)!
        case 4:
            path = Bundle.main.path(forResource: "Tower bell", ofType: nil)!
        default:
            print("default notification sound")
        }
        
        print(path)
        
        do {
            
            let player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            
            player.play()
            print("Played!")
        } catch {
            print("\(error)")
        }
    }
}
