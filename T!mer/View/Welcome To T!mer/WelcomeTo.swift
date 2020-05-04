import SwiftUI
import Dispatch

struct WelcomeTo: View {
    
    /// @ObservedObject
    @ObservedObject var userSettings = UserSettings()
    /// @END
    
    /// @AnimationBool
    @State var animationBool = 0
    /// @END
    
    var body: some View {
        
        GeometryReader { _ in
            
            ZStack {
                
                Color.white
                
                VStack {
                    
                    Text("Welcome to T!mer!")
                        .bold()
                        .font(.system(.largeTitle, design: .rounded))
                        .padding(.top, Bool(truncating: NSNumber(value: self.animationBool)) ? -100 : 30)
                        .animation(.easeInOut(duration: 1.2))
                    
                    Image("App Icon-1024 without background color")
                        .resizable()
                        .scaledToFit()
                        .scaleEffect(Bool(truncating: NSNumber(value: self.animationBool)) ? 0 : 1)
                        .animation(.easeInOut(duration: 1.2))
                    
                    Text("T!mer is GOOD for concentration to study or do work.")
                        .bold()
                        .padding(
                            EdgeInsets(
                                top: Bool(truncating: NSNumber(value: self.animationBool)) ? -330 : -600,
                                leading: 10,
                                bottom: 0,
                                trailing: 10
                            )
                    )
                        .font(.system(.title, design: .rounded))
                        .animation(.easeInOut(duration: 1.2))
                    
                    Image("focus")
                        .resizable()
                        .scaledToFit()
//                        .scaleEffect(Bool(truncating: NSNumber(value: self.animationBool)) ? 0 : 1)
                        .padding(
                            EdgeInsets(
                                top: Bool(truncating: NSNumber(value: self.animationBool)) ? -220 : -700,
                                leading: 10,
                                bottom: 0,
                                trailing: 10
                            )
                    )
                        .animation(.easeInOut(duration: 1.2))
                    
                    Spacer()
                    
                    ZStack {
                        
                        Color.blue
                        .cornerRadius(12)
                        
                        Button(action: {
                            
                            self.animationBool += 1
                            print("Button tapped!\tanimationBool: \(self.animationBool)")
                            
                            if self.animationBool == 2 {
                                
                                self.userSettings.latestBuildVersion = 2
                            }
                        }) {
                            
                            Bool(truncating: NSNumber(value: self.animationBool)) ? Text("Use it!").foregroundColor(.white) : Text("Next").foregroundColor(.white)
                        }
                    }
                    .frame(width: 104, height: 40)
                    .padding()
                }
            }
        }
    }
}

struct WelcomeTo_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeTo()
    }
}

//
//  WelcomeTo.swift
//  T!mer
//
//  Created by Aksidion Kreimben on 5/3/20.
//  Copyright © 2020 Aksidion Kreimben. All rights reserved.
//
