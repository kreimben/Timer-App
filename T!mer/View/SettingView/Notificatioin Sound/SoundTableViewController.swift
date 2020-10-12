import UIKit
import SwiftUI

import CommonT_mer

class SoundTableViewController: UITableViewController {
    
    @ObservedObject var userSettings = CTUserSettings()
    
    private var sounds: [NotificationSound] = [
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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "SoundTable", bundle: nil), forCellReuseIdentifier: "SoundCell")
        
        /// Code's from [https://stackoverflow.com/questions/38973010/add-empty-blank-space-under-in-the-end-of-uitableview]
        self.tableView.tableFooterView = UIView()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 11
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> SoundTableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SoundCell", for: indexPath) as! SoundTableViewCell
        
        cell.selectionStyle = .blue
        
        cell.tintColor = CTColorScheme.getSystemUIColor(self.userSettings.colorIndex)
        
        cell.nameOfCell?.text = self.sounds[indexPath.row].soundName
        
        if self.userSettings.soundIndex == indexPath.row { // Selected

            cell.selectImage.image = UIImage(systemName: "largecircle.fill.circle")
        } else { // Not selected
            
            cell.selectImage.image = UIImage(systemName: "circle")
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SoundCell", for: indexPath) as! SoundTableViewCell
        
        cell.makeSound(indexPath.row)
        
        self.userSettings.soundIndex = indexPath.row
        tableView.reloadData()
    }
}

//
//  SoundTableViewController.swift
//  T!mer
//
//  Created by Aksidion Kreimben on 7/21/20.
//  Copyright © 2020 Aksidion Kreimben. All rights reserved.
//
