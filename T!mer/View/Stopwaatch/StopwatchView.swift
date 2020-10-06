import SwiftUI

import CommonT_mer

struct StopwatchView: View {
    
    /// @ObservedObejects
    @ObservedObject var userSettings = CTUserSettings()
    @ObservedObject var mainController = CTMainController()
    /// @END
    
    @State var timeDisplay: Float = 0
    
    @State var center = CGPoint.zero
    @State var atan2Var: CGFloat = 0.0
    @State var circleColor = Color.red
    @State var circleRadius = CGFloat(UIScreen.main.bounds.width * 0.73 / 2)
    
    @State var fontSize: CGFloat = 77
    
    //    @State var isStopwatchStarted = false
    
    @State var firstButtonLabel = "Reset"
    @State var secondButtonLabel = "Start"
    
    @State var buttonSpaceHalf = UIScreen.main.bounds.width / 9
    
    /// @Timer-related
    let timer = Timer.publish(every: 0.01, on: .main, in: .default).autoconnect()
    /// @END
    
    var body: some View {
        
        NavigationView {
            
            ZStack {
                
                Color.white.opacity(0.3).edgesIgnoringSafeArea(.all)
                CTColorScheme.getColor(self.userSettings.colorIndex).opacity(0.55)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    
                    ZStack { // MARK: - Textbox
                        Rectangle()
                            .frame(width: 340, height: 140)
                            .foregroundColor(CTColorScheme.getColor(self.userSettings.colorIndex).opacity(0.8))
                            .cornerRadius(30)
                        
                        Group {
                            
                            if self.timeDisplay < 3600 {
                                
                                Text(String(format: "%02d:%02d.%02d", Int(self.timeDisplay / 60), Int(self.timeDisplay) % 60, self.getTimeDecimal()))
                            } else {
                                
                                Text(String(format: "%02d:%02d:%02d", Int(self.timeDisplay / 3600), Int(self.timeDisplay) / 60 - 60, Int(self.timeDisplay) % 60))
                            }
                        }
                        .font(.init(UIFont.monospacedDigitSystemFont(ofSize: self.fontSize, weight: .regular)))
                        .foregroundColor(Color.white)
                        .onReceive(timer) { _ in
                            
                            DispatchQueue.main.async {
                                if self.userSettings.isStopwatchStarted {
                                    
                                    let flag = self.userSettings.stopwatchTime
                                    self.timeDisplay = Float(flag.distance(to: Date()))
                                    
                                    self.firstButtonLabel = "Lap"
                                    self.secondButtonLabel = "Stop"
                                } else {
                                    
                                    self.firstButtonLabel = "Reset"
                                    self.secondButtonLabel = "Start"
                                }
                            }
                        }
                    } // TextBox Elements
                    .padding(EdgeInsets(top: 50, leading: 0, bottom: 0, trailing: 0))
                    
                    HStack {
                        
                        Button(action: {
                            
                            if self.userSettings.isStopwatchStarted {
                                
                                
                            } else {
                                
                                
                            }
                        }) {
                            
                            ZStack(alignment: .center) {
                                Circle()
                                    .frame(width: 120, height: 120)
                                
                                Text(self.firstButtonLabel)
                                    .foregroundColor(.white)
                                    .font(.system(size: 24))
                            }
                        }
                        .padding(.trailing, self.buttonSpaceHalf)
                        
                        Button(action: {
                            
                            if self.userSettings.isStopwatchStarted {
                                
                                self.stopStopwatch()
                            } else {
                                
                                self.startStopwatch()
                            }
                        }) {
                            
                            ZStack(alignment: .center) {
                                Circle()
                                    .frame(width: 120, height: 120)
                                
                                Text(self.secondButtonLabel)
                                    .foregroundColor(.white)
                                    .font(.system(size: 24))
                            }
                        }
                        .padding(.leading, self.buttonSpaceHalf)
                    }
                    .padding(.top, 24)
                    
                    Spacer()
                    BannerVC()
                        .frame(width: 320, height: 50, alignment: .center)
                }
            }
            .navigationBarHidden(true)
        }
    }
    
    private func getTimeDecimal() -> Int {
        
        let s = self.timeDisplay
        
        let result = Int( (s - Float(Int(s)) ) * 100)
        
        return result
    }
    
    private func startStopwatch() {
        
        self.mainController.generateHapticFeedback(as: .heavy)
        
        self.userSettings.isStopwatchStarted = true
        self.userSettings.stopwatchTime = Date()
    }
    
    private func stopStopwatch() {
        
        self.mainController.generateHapticFeedback(as: .heavy)
        
        self.userSettings.isStopwatchStarted = false
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
