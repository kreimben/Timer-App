//
//  PreferenceView.swift
//  T!mer Mac
//
//  Created by Aksidion Kreimben on 12/4/19.
//  Copyright © 2019 Aksidion Kreimben. All rights reserved.
//

import SwiftUI
import UserNotifications
import AppKit
import Combine

struct PreferenceView: View {
    
    @ObservedObject var userSettings = UserSettings()
    @EnvironmentObject var mainController: MainController
    
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
    
    @State var quitAlert: Bool = false
    
    var body: some View {
        VStack {
            Text("Preferences...")
                .font(.custom("Avenir Next Medium", size: 35))
                .padding(.top, 13)
            
            VStack(alignment: .leading) {
                
                Text("Settings about when timer is working...")
                    .font(.caption)
                    .font(.system(size: 9))
                    .foregroundColor(Color.gray)
                    .padding(.top, 10)
                
                Toggle(isOn: self.$userSettings.displayStringTime) {
                    Text("Display remain time")
                }
            }
            
            //            Picker(selection: $selectedSound, label: Text("Select notification sound")) {
            //                ForEach(0 ..< self.sounds.count, id: \.self) {
            //                    Text(self.sounds[$0]).tag($0)
            //                }
            //            }
            //            .padding([.leading, .trailing], 15)
            //
            //            Text("If you want to change notification sound,")
            //                .padding([.leading, .trailing], 15)
            //                .font(.system(size: 11))
            //                .foregroundColor(Color.gray)
            //            Text("please set the sound before starting timer.")
            //                .padding([.leading, .trailing], 15)
            //                .font(.system(size: 11))
            //                .foregroundColor(Color.gray)
            
            
            Button(action: {
                
                print("Website button pressed")
                
                if let url = URL(string: "http://www.kreimben.com") {
                    NSWorkspace.shared.open(url)
                }
            }) {
                Text("Visit Kreimben.com")
            }
            .buttonStyle(LinkButtonStyle())
            .padding([.top], 8)
            
            Button("Done") {
                
                //MARK:- Setting sound index
                self.userSettings.soundIndex = self.selectedSound
                print("\tStoring selected sound to UserDefault's soundIndex at Done button.\n\tNumber(soundIndex): \(self.userSettings.soundIndex)")
                self.presentationMode.wrappedValue.dismiss()
            }
            .padding()
            .onAppear {
                
                self.selectedSound = self.userSettings.soundIndex
                print("\tSetting selected sound from UserDefault's soundIndex at onAppear of Done button.\n\tNumber(selectedSound): \(self.selectedSound)")
            }
            
        }
        .frame(width: 450, height: 275)
    }
}

struct PreferenceView_Previews: PreviewProvider {
    static var previews: some View {
        PreferenceView()
    }
}
