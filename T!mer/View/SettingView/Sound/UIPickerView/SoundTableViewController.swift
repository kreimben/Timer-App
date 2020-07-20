import UIKit

class SoundTableViewController: UITableViewController {
    
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
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 11
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SoundCell") as! SoundTableViewCell
        
        cell.title.text = self.sounds[indexPath.row].soundName
        
        return cell
    }
}

//
//  SoundTableViewController.swift
//  T!mer
//
//  Created by Aksidion Kreimben on 7/20/20.
//  Copyright © 2020 Aksidion Kreimben. All rights reserved.
//
