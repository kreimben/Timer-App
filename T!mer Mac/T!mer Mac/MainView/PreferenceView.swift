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
    
    /// @Binding for alternating "presentationMode"
    @Binding var isPresented: Bool
    /// @END
    
    var body: some View {
        VStack {
            Text("Preferences")
                .font(.custom("Avenir Next Medium", size: 35))
                .padding(.top, 4)
            
            ScrollView(.vertical, showsIndicators: true) {
                
                VStack(alignment: .leading) { /// For Alignment multiple setting options
                    
                    Toggle(isOn: self.$userSettings.displayStringTime) {
                        Text("Display remain time when T!mer is running")
                    }
                    
                    VStack(alignment: .leading) {
                        Toggle(isOn: self.$userSettings.dismissByEventMonitor) {
                            Text("Dismiss by clicking outside the app")
                        }
                        
                        Text("This option will be activated after closing the app")
                            .font(.system(size: 11))
                            .foregroundColor(.gray)
                    }
                    
                    Picker(selection: self.$selectedColor, label: Text("Color")) {
                        ForEach(0 ..< Colors.allCases.count, id: \.self) { index in
                            PickerView(index: index).tag(index)
                        }
                    }
                    .padding([.top], 10)
                    
//                    Picker(selection: $selectedSound, label: Text("Select notification sound")) {
//                        ForEach(0 ..< self.sounds.count, id: \.self) {
//                            Text(self.sounds[$0]).tag($0)
//                        }
//                    }
//
//                    Text("If you want to change notification sound, please set the sound before starting timer.")
//                        .font(.system(size: 11))
//                        .foregroundColor(Color.gray)
//                        .padding(.bottom)
                }
            } // ScrollView
            .padding([.leading, .trailing], 10)
            
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
                
                Button("Done") {
                    
                    // MARK: - Setting sound TO USERDEFAULTS
//                    self.userSettings.soundIndex = self.selectedSound
//                    print("\tStoring selected sound to UserDefault's soundIndex at Done button.\n\tNumber(soundIndex): \(self.userSettings.soundIndex)")
                    /// @END
                    
                    // MARK: - Setting color TO USERDEFAULTS
                    self.userSettings.colorIndex = self.selectedColor
                    print("\tStoring selected color to UserDefualt's colorIndex at Done button.\n\tNumber(colorIndex): \(self.userSettings.colorIndex)")
                    /// @END
                    
                    self.isPresented = false
                }
                .onAppear {
                    
                    // MARK: - Settting sound to this view
//                    self.selectedSound = self.userSettings.soundIndex
//                    print("\tSetting selected sound from UserDefault's soundIndex at onAppear of Done button.\n\tNumber(selectedSound): \(self.selectedSound)")
                    /// @END
                    
                    // MARK: - Setting color to this view
                    self.selectedColor = self.userSettings.colorIndex
                    print("\tSetting selected color from UserDefault's colorIndex at onAppear of Done button.\n\tNumber(selectedColor): \(self.selectedColor)")
                    /// @END
                    
                }
            }.padding(.bottom, 10)
        }
        .frame(width: 450, height: 275)
    }
}

struct PickerView: View {
    
    @State var index: Int
    
    var body: some View {
        HStack {
            Text(String(ColorScheme().scheme[index]))//.tag($0)
            Spacer()
            ColorScheme.getColor(index).opacity(0.8)
                .frame(width: 17, height: 17)
                .cornerRadius(4)
                .shadow(radius: 10)
                .border(ColorScheme.getColor(index).opacity(0.55), width: 5)
                .cornerRadius(4)
        }
    }
}

//
//  PreferenceView.swift
//  T!mer Mac
//
//  Created by Aksidion Kreimben on 12/4/19.
//  Copyright © 2019 Aksidion Kreimben. All rights reserved.
//
