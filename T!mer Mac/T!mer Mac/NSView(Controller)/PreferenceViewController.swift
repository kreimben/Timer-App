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
        
        guard let path = Bundle.main.path(forResource: "Cookoo", ofType: "MA4") else {
            return print("error to set notification sound path.")
        }
        
        do {
            
            let player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            
            player.play()
        } catch {
            print("\(error)")
        }
    }
}

struct PreferenceRepresentaion: NSViewControllerRepresentable {
    
    typealias NSViewControllerType = PreferenceViewController
    
    func makeNSViewController(context: NSViewControllerRepresentableContext<PreferenceRepresentaion>) -> NSViewControllerType {
        
        print("PreferenceRepresentaion Clicked")
        return PreferenceViewController()
    }

    func updateNSViewController(_ preferenceViewController: NSViewControllerType, context: NSViewControllerRepresentableContext<PreferenceRepresentaion>) {

    }
}
