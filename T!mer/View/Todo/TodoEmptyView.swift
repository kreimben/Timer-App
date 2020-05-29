import SwiftUI
import UIKit

struct TodoEmptyView: View {
    
    /// @ObservedObject
    @ObservedObject var userSettings = UserSettings()
    /// @END
    
    /// @Environment
    @Environment(\.presentationMode) var presentationMode
    /// @END
    
    var body: some View {
        
        ZStack {
            
            Color.gray.opacity(0.4).edgesIgnoringSafeArea(.all)
            
            VStack {
                
                Image("empty_box_image")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 104)
                    .padding()
                
                Text("Nothing yet :(")
                    .foregroundColor(Color.gray.opacity(0.7))
                    .font(.system(size: 32, design: .rounded))
                    .padding()
                
                Group {
                    if self.userSettings.isTimerStarted {
                        
                        Button(action: {
                            
                            let newTimer = TimerElement(with: self.userSettings.notificationTime)
                            
                            TimerSession.shared.timers.append(newTimer)
                            
                            /// @When T!mer is added successfully
                            let gen = UINotificationFeedbackGenerator()
                            gen.prepare()
                            gen.notificationOccurred(.success)
                            /// @END
                        }) {
                            
                            Text("Add current T!mer")
                                .font(.system(size: 20, design: .rounded))
                            
                        }
                        .padding()
                    } else {
                        
                        Button(action: {
                            
                            self.presentationMode.wrappedValue.dismiss()
                        }) {
                            
                            Text("Start T!mer first :)")
                                .font(.system(size: 20, design: .rounded))
                        }
                    }
                }
            }
            
        }
        .navigationBarTitle(Text("To-do list"))
    }
}

struct TodoEmptyView_Previews: PreviewProvider {
    static var previews: some View {
        TodoEmptyView()
    }
}

//
//  TodoEmptyView.swift
//  T!mer
//
//  Created by Aksidion Kreimben on 5/28/20.
//  Copyright © 2020 Aksidion Kreimben. All rights reserved.
//
