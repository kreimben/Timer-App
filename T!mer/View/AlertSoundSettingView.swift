//
//  AlertSoundSettingView.swift
//  T!mer
//
//  Created by Aksidion Kreimben on 10/28/19.
//  Copyright © 2019 Aksidion Kreimben. All rights reserved.
//

import SwiftUI

struct AlertSoundSettingView: View {
    var colors = ["Red", "Green", "Blue", "Tartan"]
    
    @State private var selectedColor = 0
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker(selection: $selectedColor, label: Text("Please choose a color")) {
                        ForEach(0 ..< colors.count) {
                            Text(self.colors[$0])
                        }
                    }
                }
            }
        }
    }
}

struct AlertSoundSettingView_Previews: PreviewProvider {
    static var previews: some View {
        AlertSoundSettingView()
    }
}
