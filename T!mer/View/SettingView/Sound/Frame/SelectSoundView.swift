import SwiftUI

struct SelectSoundView: View {
    
    var array: [NotificationSound]
    var index: Int
    
    init(array: [NotificationSound], index: Int) {
        self.array = array
        self.index = index
    }
    
    var body: some View {
        HStack {
            
            Text(self.array[index].soundName).tag(index)
            
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
