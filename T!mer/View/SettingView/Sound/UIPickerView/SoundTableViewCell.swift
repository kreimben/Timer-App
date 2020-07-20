import UIKit

class SoundTableViewCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    
}

extension SoundTableViewCell {
    
    @IBAction func playNotificationSound(_ sender: UIButton) {
        
        print("Button tapped!")
    }
}

//
//  SoundTableViewCell.swift
//  T!mer
//
//  Created by Aksidion Kreimben on 7/20/20.
//  Copyright © 2020 Aksidion Kreimben. All rights reserved.
//
