import UIKit
import AVFoundation
import Dispatch
import AudioToolbox

class SoundTableViewCell: UITableViewCell {
    
    @IBOutlet var nameOfCell: UILabel!
    @IBOutlet var selectImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func makeSound(_ number: Int) {
        
        print("Selected: \(number)")
        
        var path: String?
        
        switch number {
        case 0:
            AudioServicesPlaySystemSound(1050)
            return
            
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
        
        DispatchQueue.main.async {
            
            do {
                
                let player = try AVAudioPlayer(contentsOf: url)
                
//                try AVAudioSession.sharedInstance().setCategory(
//                    .playback,
//                    mode: .default,
//                    options: [.duckOthers]
//                )
//                try AVAudioSession.sharedInstance().setActive(true)
                
//                player.numberOfLoops = -1
                
                if player.prepareToPlay() {
                    
                    print("Prepared to play!")
                    
                    player.play()
                    print("Played!")
                }
                
            } catch let error {
                
                NSLog("Error while playing notification sound: \(error.localizedDescription)")
            }
        }
    }
}

//
//  SoundTableViewCell.swift
//  T!mer
//
//  Created by Aksidion Kreimben on 7/21/20.
//  Copyright © 2020 Aksidion Kreimben. All rights reserved.
//
