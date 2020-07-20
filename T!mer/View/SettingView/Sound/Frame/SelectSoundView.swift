import SwiftUI

import CommonT_mer

struct SelectSoundView: View {
    
    @ObservedObject var userSettings = CTUserSettings()
    
    var sounds: [NotificationSound]
    var index: Int
    
    init(array: [NotificationSound], index: Int) {
        self.sounds = array
        self.index = index
    }
    
    var body: some View {
        HStack {
            
            Text(self.sounds[index].soundName).tag(index)
        }
    }
}

//
//  SelectSoundView.swift
//  T!mer
//
//  Created by Aksidion Kreimben on 5/4/20.
//  Copyright © 2020 Aksidion Kreimben. All rights reserved.
//
