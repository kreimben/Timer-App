import SwiftUI

import CommonT_mer

struct StopwatchView: View {
    
    /// @ObservedObejects
    @ObservedObject var userSettings = CTUserSettings()
    @ObservedObject var mainController = CTMainController()
    /// @END
    
    @State var timeDisplay: Double = 3600 - 0.55
    
    @State var center = CGPoint.zero
    @State var atan2Var: CGFloat = 0.0
    @State var circleColor = Color.red
    @State var circleRadius = CGFloat(UIScreen.main.bounds.width * 0.73 / 2)
    
    @State var fontSize: CGFloat = 77
    
    /// @Timer-related
    let timer = Timer.publish(every: 1, on: .main, in: .default).autoconnect()
//    let dispatch = DispatchQueue(label: "Timer", qos: .userInteractive, attributes: .concurrent, autoreleaseFrequency: .inherit, target: .global())
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
                            
                                Text(String(format: "%02d:%02d.%02d", Int(self.timeDisplay / 60), Int(self.timeDisplay) % 60, Int( (self.timeDisplay - CGFloat(Int(self.timeDisplay)) ) * 100) ) )
                            } else {
                                
                                Text(String(format: "%02d:%02d:%02d", Int(self.timeDisplay / 3600), Int(self.timeDisplay / 60), Int(self.timeDisplay) % 60))
                            }
                        }
                        .font(.system(size: self.fontSize))
                        .font(.headline)
                        .foregroundColor(Color.white)
                        .onReceive(timer) { _ in
                            
                            DispatchQueue.main.async {
                                
                            }
                        }
                    } // TextBox Elements
                        .padding(EdgeInsets(top: 50, leading: 0, bottom: 0, trailing: 0))
                    
                    ZStack(alignment: .center) { // MARK: - Circle Timer
                        
                        Circle()
                            .fill(Color(red: 138 / 255, green: 51 / 255, blue: 36 / 255))
                            .frame(width: UIScreen.main.bounds.width * 0.85)
                            .shadow(radius: 10)
                        
                        Circle()
                            .fill(Color.red.opacity(0.5))
                            .frame(width: UIScreen.main.bounds.width * 0.77)
                            .shadow(radius: 10)
                        
                        CTUserTouchCircle(center: self.$center, atan2: self.$atan2Var, circleColor: self.$circleColor, circleRadius: self.$circleRadius)
                            .frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.width * 0.8)
                        
                        Image("시계 바늘")
                            .resizable()
                            .frame(width: UIScreen.main.bounds.width * 0.85, height: UIScreen.main.bounds.width * 0.85)
                        
                        Circle() // Touch center
                            .fill(Color.red.opacity(0.001))
                            .frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.width * 0.8)
                            .shadow(radius: 10)
                            .onLongPressGesture(minimumDuration: 0.5, maximumDistance: 5) {
                                
                                print("pressed!")
                            }
                    }
                    
                    Spacer()
                    BannerVC()
                        .frame(width: 320, height: 50, alignment: .center)
                }
            }
            .navigationBarHidden(true)
        }
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
