import UIKit
import AVFoundation

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
        
        tableView.register(UINib(nibName: "SoundTable", bundle: nil), forCellReuseIdentifier: "SoundCell")
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 11
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> SoundTableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SoundCell", for: indexPath) as! SoundTableViewCell
        
        cell.selectionStyle = .none
        
        cell.nameOfCell?.text = self.sounds[indexPath.row].soundName
//        cell.buttonImage?.image = UIImage(systemName: "checkmark.circle")

        return cell
    }
    
    func makeSound(_ number: Int) {
            
            var player: AVAudioPlayer?
            
            print("Selected: \(number)")
            
            var path: String?

            switch number {

            case 1:
                path = Bundle.main.path(forResource: "Default Bell", ofType: nil)
                
            case 2:
                path = Bundle.main.path(forResource: "Bell store door", ofType: nil)
                
            case 3:
                path = Bundle.main.path(forResource: "Cookoo", ofType: nil)
                
            case 4:
                path = Bundle.main.path(forResource: "Tower bell", ofType: nil)
                
            case 5:
                path = Bundle.main.path(forResource: "bicycle", ofType: nil)
                
            case 6:
                path = Bundle.main.path(forResource: "ghost", ofType: nil)
                
            case 7:
                path = Bundle.main.path(forResource: "home-bell", ofType: nil)
                
            case 8:
                path = Bundle.main.path(forResource: "elevator", ofType: nil)
                
            case 9:
                path = Bundle.main.path(forResource: "single", ofType: nil)
                
            case 10:
                path = Bundle.main.path(forResource: "zen", ofType: nil)
                
            default:
                NSLog("Error occured in fixing UNNotificationSound.")
                
            }

            guard let comfirmedPath = path else { return }

            let url = URL(fileURLWithPath: comfirmedPath)

            do {

                player = try AVAudioPlayer(contentsOf: url)
                player?.play()

            } catch let error {

                NSLog("Error while playing notification sound: \(error.localizedDescription)")
            }
        }
}

//
//  SoundTableViewController.swift
//  T!mer
//
//  Created by Aksidion Kreimben on 7/21/20.
//  Copyright © 2020 Aksidion Kreimben. All rights reserved.
//
