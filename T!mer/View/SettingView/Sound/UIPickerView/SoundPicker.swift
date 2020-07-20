import SwiftUI
import UIKit

final class SoundPicker: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> UITableViewController {
        
        let vc = SoundTableViewController()
        
        return vc
    }
    
    func updateUIViewController(_ tableView: UITableViewController, context: Context) { }
    
    class Coordinator: NSObject {
        
        private var soundsArray: [NotificationSound] = [
            NotificationSound(soundName: "Default Sound"),
            NotificationSound(soundName: "Bicycle"),
            NotificationSound(soundName: "Store"),
            NotificationSound(soundName: "Cookoo"),
            NotificationSound(soundName: "Tower"),
            
            NotificationSound(soundName: "Bicycle 2"),
            NotificationSound(soundName: "Ghost"),
            NotificationSound(soundName: "House"),
            NotificationSound(soundName: "Elevator"),
            NotificationSound(soundName: "Single"),
            NotificationSound(soundName: "Zen")
        ]
    }
    
    func makeCoordinator() -> Coordinator {
        
        return Coordinator()
    }
}

//
//  SoundPicker.swift
//  T!mer
//
//  Created by Aksidion Kreimben on 7/20/20.
//  Copyright © 2020 Aksidion Kreimben. All rights reserved.
//
