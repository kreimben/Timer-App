import SwiftUI
import UIKit

import CommonT_mer

struct DebugMenuView: View {
    
    @ObservedObject var userSettings = CTUserSettings()
    
    @State var turnOffAds: Bool = false
    
    let notiGenerator = UINotificationFeedbackGenerator()
    
    init() {
        
        notiGenerator.prepare()
    }
    
    var body: some View {
        
        List {
            
            Section(header: Text("Advertisment")) {
                
                Toggle(isOn: self.$turnOffAds) {
                    
                    Text("Turn off ads AT DEBUG")
                        .foregroundColor(.red)
                }.padding()
            }
            
            Section(header: Text("UINotificationFeedbackGenerator")) {
                
                Button("notificationOccured \"Success\"") {
                    
                    self.notiGenerator.notificationOccurred(.success)
                }
                
                Button("notificationOccured \"Error\"") {
                    
                    self.notiGenerator.notificationOccurred(.error)
                }
                
                Button("notificationOccured \"Warning\"") {
                    
                    self.notiGenerator.notificationOccurred(.warning)
                }
            } // UINotificationFeedbackGenerator
            
            Section(header: Text("UIImpactFeedbackGenerator")) {
                
                Button("heavy") {
                    
                    let gen = UIImpactFeedbackGenerator(style: .heavy)
                    gen.prepare()
                    gen.impactOccurred(intensity: 30)
                }
                
                Button("light") {
                    
                    let gen = UIImpactFeedbackGenerator(style: .light)
                    gen.prepare()
                    gen.impactOccurred()
                }
                
                Button("medium") {
                    
                    let gen = UIImpactFeedbackGenerator(style: .medium)
                    gen.prepare()
                    gen.impactOccurred()
                }
                
                Button("rigid") {
                    
                    let gen = UIImpactFeedbackGenerator(style: .rigid)
                    gen.prepare()
                    gen.impactOccurred()
                }
                
                Button("soft") {
                    
                    let gen = UIImpactFeedbackGenerator(style: .soft)
                    gen.prepare()
                    gen.impactOccurred()
                }
            } // UIImpactFeedbackGenerator
            
            Section(header: Text("UISelectionFeedbackGenerator")) {
                
                Button("Selection") {
                    
                    let gen = UISelectionFeedbackGenerator()
                    gen.prepare()
                    gen.selectionChanged()
                }
            } // UISelectionFeedbackGenerator
        }
        .listStyle(GroupedListStyle())
        .navigationBarTitle(Text("Haptic Touch Test"))
    }
}

struct HapticTouchView_Previews: PreviewProvider {
    static var previews: some View {
        DebugMenuView()
    }
}

//
//  HapticTouchView.swift
//  T!mer
//
//  Created by Aksidion Kreimben on 4/30/20.
//  Copyright © 2020 Aksidion Kreimben. All rights reserved.
//
