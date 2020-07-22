import SwiftUI

struct MainMasterView: View {
    var body: some View {
        
        TabView {
        
            ContentView()
                .tabItem {
                    TabLabel(imageName: "timer", label: "Timer")
            }
            
            StopwatchView()
                .tabItem {
                    TabLabel(imageName: "stopwatch", label: "Stopwatch")
            }
        }
    }
}

fileprivate struct TabLabel: View {
    
    let imageName: String
    let label: String
    
    var body: some View {
        HStack {
            Image(systemName: imageName)
            Text(label)
        }
    }
}

struct MainMasterView_Previews: PreviewProvider {
    static var previews: some View {
        MainMasterView()
    }
}

//
//  MainMasterView.swift
//  T!mer
//
//  Created by Aksidion Kreimben on 7/23/20.
//  Copyright © 2020 Aksidion Kreimben. All rights reserved.
//
