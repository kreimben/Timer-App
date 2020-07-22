import SwiftUI

import CommonT_mer

struct StopwatchView: View {
    
    /// @ObservedObejects
    @ObservedObject var userSettings = CTUserSettings()
    /// @END
    
    // MARK: - Init()
    init() {
        
        let appearance = UINavigationBarAppearance()
        
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
        
        appearance.shadowColor = nil
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        
        UINavigationController().hidesBarsOnSwipe = true
    }
    
    var body: some View {
        
        NavigationView {
            
            ZStack {
                Color.white.opacity(0.3).edgesIgnoringSafeArea(.all)
                CTColorScheme.getColor(self.userSettings.colorIndex).opacity(0.55)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    
                    Text("Stopwatch test view")
                    
                    Spacer()
                    BannerVC()
                        .frame(width: 320, height: 50, alignment: .center)
                }
            }
        }
        .navigationBarTitle("Stopwatch", displayMode: .inline)
    }
}

struct StopwatchView_Previews: PreviewProvider {
    static var previews: some View {
        StopwatchView()
    }
}

//
//  StopwatchView.swift
//  T!mer
//
//  Created by Aksidion Kreimben on 7/23/20.
//  Copyright © 2020 Aksidion Kreimben. All rights reserved.
//
