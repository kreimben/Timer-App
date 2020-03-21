import SwiftUI
import UserNotifications
import AppKit
import Combine

struct PreferenceView: View {
    
    @ObservedObject var userSettings = UserSettings()
    @EnvironmentObject var mainController: MainController
    
    var userDefaults = UserDefaults()
    
    /// @Sound Related
    @State var selectedSound = 0
    var sounds: [String] = [
        "Default Notification Sound",
        "Bicycle Bell",
        "Bell - Store door",
        "Cookoo",
        "Tower bell"
    ]
    /// @END
    
    /// @Color Related
    @State var selectedColor = 0
    /// @END
    
    /// @Environment
    @Environment(\.presentationMode) var presentationMode
    /// @END
    
    /// @Sheet Bool
    @State var quitAlert: Bool = false
    /// @END
    
    var body: some View {
        VStack {
            Text("Preferences")
                .font(.custom("Avenir Next Medium", size: 35))
                .padding(.top, 13)
            
            Text("These options will be activated after closing the app")
                .font(.system(size: 11))
                .foregroundColor(.gray)
            
            ScrollView(.vertical, showsIndicators: true) {
                
                VStack(alignment: .leading) { /// For Alignment multiple setting options
                    
                    Toggle(isOn: self.$userSettings.displayStringTime) {
                        Text("Display remain time when T!mer is running")
                    }
                    
                    Toggle(isOn: self.$userSettings.dismissByEventMonitor) {
                        Text("Dismiss by clicking outside the app")
                    }
                    
                    Picker(selection: $selectedColor, label: Text("Color")) {
                        ForEach(0 ..< Colors.allCases.count, id: \.self) {
                            Text(String(ColorScheme().scheme[$0])).tag($0)
                        }
                    }
                    .padding([.top], 10)
                }
            } // ScrollView
                .padding([.leading, .trailing], 10)
            
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
            
            HStack(alignment: .center) {
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
                    
                    // MARK: - Setting sound TO USERDEFAULTS
                    self.userSettings.soundIndex = self.selectedSound
                    print("\tStoring selected sound to UserDefault's soundIndex at Done button.\n\tNumber(soundIndex): \(self.userSettings.soundIndex)")
                    /// @END
                    
                    // MARK: - Setting color TO USERDEFAULTS
                    self.userSettings.colorIndex = self.selectedColor
                    print("\tStoring selected color to UserDefualt's colorIndex at Done button.\n\tNumber(colorIndex): \(self.userSettings.colorIndex)")
                    /// @END
                    
                    self.presentationMode.wrappedValue.dismiss()
                }
                .padding()
                .onAppear {
                    
                    // MARK: - Settting sound to this view
                    self.selectedSound = self.userSettings.soundIndex
                    print("\tSetting selected sound from UserDefault's soundIndex at onAppear of Done button.\n\tNumber(selectedSound): \(self.selectedSound)")
                    /// @END
                    
                    // MARK: - Setting color to this view
                    self.selectedColor = self.userSettings.colorIndex
                    print("\tSetting selected color from UserDefault's colorIndex at onAppear of Done button.\n\tNumber(selectedColor): \(self.selectedColor)")
                    /// @END
                    
                }
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

//
//  PreferenceView.swift
//  T!mer Mac
//
//  Created by Aksidion Kreimben on 12/4/19.
//  Copyright © 2019 Aksidion Kreimben. All rights reserved.
//
