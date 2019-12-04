//
//  PreferenceView.swift
//  T!mer Mac
//
//  Created by Aksidion Kreimben on 12/4/19.
//  Copyright © 2019 Aksidion Kreimben. All rights reserved.
//

import SwiftUI

struct PreferenceView: View {
    
    @State var statusBarTimeToggle: Bool = true
    @State var staturBarIconToggle: Bool = true
    
    var userDefaults = UserDefaults()
    @State var selectedSound = 0
    var sounds: [String] = [
        "Default Notification Sound",
        "Bicycle Bell",
        "Bell - Store door",
        "Cookoo",
        "Tower bell"
    ]
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            Text("Preferences...")
                .font(.custom("Avenir Next Medium", size: 35))
                .padding(.top, 15)
            
            VStack(alignment: .leading) {
                
                Text("Settings about when timer is working...")
                    .font(.caption)
                    .font(.system(size: 9))
                    .foregroundColor(Color.gray)
                    .padding(.top, 10)
                
                Toggle(isOn: $statusBarTimeToggle) {
                    Text("Display remain time")
                }
                
                Toggle(isOn: $staturBarIconToggle) {
                    Text("Display visualized time")
                }
            }
            
            Picker(selection: $selectedSound, label: Text("Select notification sound")) {
                ForEach(0 ..< self.sounds.count, id: \.self) {
                    Text(self.sounds[$0]).tag($0)
                }
            }
            .padding([.leading, .trailing], 10)
            
            HStack {
                Button(action: {
                    
                    print("Instagram button pressed")
                }) {
                    Image("instagram-logo")
                        .resizable()
                        .frame(width: 80, height: 55)
                        .padding(.trailing, 30)
                }.buttonStyle(PlainButtonStyle())
                
                Button(action: {
                    
                    print("Website button pressed")
                }) {
                    Text("Visit Kreimben.com")
                }
            }
            
            Button("Done") {
                
                self.userDefaults.set(self.selectedSound, forKey: "selectedSound")
                print("\tStroing selected sound to UserDefaults at Done button.\n\tNumber(UserDefaults): \(self.userDefaults.integer(forKey: "selectedSound"))")
                
                self.presentationMode.wrappedValue.dismiss()
            }
            .onAppear {
                
                self.selectedSound = self.userDefaults.integer(forKey: "selectedSound")
                print("\tSetting selected sound from UserDefaults at onAppear of \"Done\" button\n\tNumber(selectedSound): \(self.selectedSound)")
            }
            
            
            
            
        }
            .frame(width: 450, height: 280)
    }
}

struct PreferenceView_Previews: PreviewProvider {
    static var previews: some View {
        PreferenceView()
    }
}
