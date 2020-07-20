import UIKit

class SoundTableViewController: UITableViewController {
    
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
        
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 11
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SoundTableViewCell") as! SoundTableViewCell
        
        NSLog("Array Info[\(indexPath.row)]: \(self.soundsArray[indexPath.row].soundName)")
        
        cell.title.text = self.soundsArray[indexPath.row].soundName
        
        return cell
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }

    
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return false
    }
}

//
//  SoundTableViewController.swift
//  T!mer
//
//  Created by Aksidion Kreimben on 7/20/20.
//  Copyright © 2020 Aksidion Kreimben. All rights reserved.
//
