import UIKit

class SoundTableViewCell: UITableViewCell {
    
    @IBOutlet var title: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func playButton(_ sender: UIButton) {
        
        print("Button Tapped!")
    }

}

//
//  SoundTableViewCell.swift
//  T!mer
//
//  Created by Aksidion Kreimben on 7/20/20.
//  Copyright © 2020 Aksidion Kreimben. All rights reserved.
//
