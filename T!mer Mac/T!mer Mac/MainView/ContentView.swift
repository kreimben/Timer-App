//
//  ContentView.swift
//  T!mer Mac
//
//  Created by Aksidion Kreimben on 11/30/19.
//  Copyright © 2019 Aksidion Kreimben. All rights reserved.
//

import SwiftUI
import Combine
import Dispatch
import UserNotifications

struct ContentView: View {
    
    @State var preferenceSheet: Bool = false
    
    @ObservedObject var userSettings = UserSettings()
    @ObservedObject var statusBarController = StatusBarController()
    
    @EnvironmentObject var mainController: MainController
    
    @State var showingAlert = false
    
    let timer = Timer.publish(every: 1, on: .main, in: .default).autoconnect()
    
    //MARK: For DragGesture
    
    @GestureState var dragAmount = CGPoint.zero
    @State var currentPoint = CGPoint.zero
    @State var center = CGPoint.zero
    @State var atan2Var: CGFloat = 0.0
    
    @State var circleColor = Color.red
    @State var circleRadius = CGFloat(205 / 2)
    
    @State var gestureAllowed = false
    
    @ObservedObject var userTouchController = UserTouchController()
    
    var body: some View {
        ZStack {
            Color.blue.opacity(0.55)
                .edgesIgnoringSafeArea(.all)
            
            HStack {
                
                VStack {
                    
                    ZStack { //MARK:- Text Box
                        
                        Rectangle()
                            .frame(width: 230, height: 100)
                            .foregroundColor(Color.blue.opacity(0.8))
                            .cornerRadius(30)
                        
                        Text("\(self.userSettings.isTimerStarted ? String(format: "%02d:%02d", Int(self.mainController.timeDisplay / 60), Int(  self.mainController.timeDisplay  ) % 60) : String(format: "%02d:00", Int(  (  (self.userSettings.timeInputBeforeConvert + 90) * 10  ) / 60)  )/*앞에 String*/    )")
                            .font(.system(size: 75))
                            .font(.headline)
                            .foregroundColor(Color.white)
                            .onReceive(timer) { input in
                                
                                DispatchQueue.main.async {
                                    
                                    // About TIMER!
                                    if Date().distance(to: self.userSettings.notificationTime) > 0 && self.userSettings.isTimerStarted { // 시간이 0보다 작으면 타이머 종료
                                        
                                        if Date().distance(to: self.userSettings.notificationTime) > 0 {
                                            
                                            self.mainController.timeDisplay = Date().distance(to: self.userSettings.notificationTime)
                                            self.atan2Var = CGFloat((self.mainController.timeDisplay / 10) * (Double.pi / 180))
                                        }
                                        
                                        
                                    } else {
                                        
                                        self.userSettings.isTimerStarted = false
                                        self.circleColor = Color.red.opacity(0.5)
                                    }
                                    
                                    //MARK:- About StatusBar! (String Time / onReceive)
                                    if self.userSettings.displayStringTime && self.userSettings.isTimerStarted {

                                        self.statusBarController.statusBarButton.title = ""

                                        self.statusBarController.statusBarButton.title = String(format: "%02d:%02d", Int(self.mainController.timeDisplay / 60), Int(  self.mainController.timeDisplay  ) % 60)
                                    } else { // timer is off or not let display string time on preferences menu...

                                        self.statusBarController.statusBarButton.title = ""
                                        self.statusBarController.statusBarButton.title = "T!mer"
                                    }
                                    
                                }
                        }
                    }
                    
                    HStack {
                        
                        Button(action: {
                            
                            print("button pressed")
                            self.preferenceSheet = true
                        }) {
                            Text("Preferences...")
                        }
                        .padding()
                        .sheet(isPresented: $preferenceSheet) {
                            PreferenceView()
                        }
                        
                        Spacer()
                        
                        Button("Quit") {
                            
                            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                            print("All of pending notification requests is removed.")
                            NSApplication.shared.terminate(self)
                        }.padding()
                    }
                    
//                    Button("Change Title") {
//
//                        let statusBar = NSStatusBar.init()
//                        let statusBarItem = NSStatusItem()
//                    }
                }
                
                ZStack(alignment: .center) { //MARK:- Circle Timer
                    
                    Circle()
                        .fill(Color(red: 138 / 255, green: 51 / 255, blue: 36 / 255))
                        .frame(width: 240, height: 240)
                        .shadow(radius: 10)
                    
                    Circle()
                        .fill(Color.red.opacity(0.5))
                        .frame(width: 216, height: 230)
                        .shadow(radius: 10)
                    
                    UserTouchCircle(center: self.$center, atan2: self.$atan2Var, circleColor: self.$circleColor, circleRadius: self.$circleRadius)
                        .frame(width: 220, height: 220)
                    
                    Image("시계 바늘")
                        .resizable()
                        .frame(width: 240, height: 240)
                    
                    Circle() // Touch Center
                        .fill(Color.red.opacity(0.001))
                        .frame(width: 240, height: 240)
                        .shadow(radius: 10)
                        .onLongPressGesture(minimumDuration: 0.6, maximumDistance: 5) {
                            
                            print("onLongPressGesture is excuted.")
                            print("gesture allowed status: \(self.gestureAllowed)")
                            
                            if self.userSettings.isTimerStarted {
                                
                                self.userSettings.isTimerStarted = false
                                self.circleColor = Color.red.opacity(0.5)
                                
                                self.userSettings.notificationTime = Date()
                                self.atan2Var = CGFloat(0)
                                self.userSettings.timeInputBeforeConvert = -90
                                self.userSettings.initialNotificationTime = 0
                                
                                print("isTimerStarted gonna FALSE")
                                
                                UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                            }
                    }
                    .gesture(
                        DragGesture().updating($dragAmount) { value, state, transaction in
                            
                            if !self.userSettings.isTimerStarted {
                                
                                DispatchQueue.main.async {
                                    self.gestureAllowed = true
                                }
                                
                                state = value.location
                                
                                DispatchQueue.main.async {
                                    self.currentPoint = CGPoint(x: self.dragAmount.x - self.center.x, y: self.center.y - self.dragAmount.y)
                                    
                                    self.atan2Var = atan2(self.currentPoint.x, self.currentPoint.y)
                                    
                                    self.userSettings.timeInputBeforeConvert = self.userTouchController.atan2ToDegrees(tan: self.atan2Var)
                                }
                            }
                        }
                        .onEnded { (_) in
                            
                            if self.gestureAllowed { // 타이머가 멈췄을 때 = 제스쳐가 허용될 때
                                
                                if self.userSettings.timeInputBeforeConvert >= 0 { // 순수 restOfTime이 양수 일 때
                                    
                                    self.userSettings.timeInputBeforeConvert = Double(Int(self.userSettings.timeInputBeforeConvert) - (Int(self.userSettings.timeInputBeforeConvert) % 6))
                                } else { // 순수 restOfTime이 음수 일때
                                    
                                    self.userSettings.timeInputBeforeConvert = Double(Int(self.userSettings.timeInputBeforeConvert) + (Int(self.userSettings.timeInputBeforeConvert) % 6))
                                    
                                    if ((( Int(self.userSettings.timeInputBeforeConvert) + 90) * 10) % 60) == 20 {
                                        
                                        self.userSettings.timeInputBeforeConvert -= 2
                                    } else if ((( Int(self.userSettings.timeInputBeforeConvert) + 90) * 10) % 60) == 40 {
                                        
                                        self.userSettings.timeInputBeforeConvert -= 4
                                    }
                                }
                                
                                let degreeForConvert = (self.userSettings.timeInputBeforeConvert + 90)
                                
                                self.atan2Var = CGFloat(degreeForConvert * (Double.pi / 180))
                                
                                self.userSettings.initialNotificationTime = degreeForConvert * 10 // 각도에 10을 곱해 초(second)로 전환.
                                
                                self.showingAlert = true
                                
                            }
                        }
                    ) // .gesture
                        .alert(isPresented: self.$showingAlert, content: {
                            
                            if self.userSettings.initialNotificationTime > 0 { // which is MINUTE
                                return Alert(title: Text("Start T!mer"), message: Text("Do you want to start T!mer\nfor \(Int(self.userSettings.initialNotificationTime / 60) ) minutes?"), primaryButton: .cancel(Text("Cancel")), secondaryButton: .default(Text("OK")) {
                                    
                                    self.userSettings.notificationTime = Date().addingTimeInterval(self.userSettings.initialNotificationTime)
                                    
                                    self.mainController.setNotificationWhenTimerStart()
                                    self.userSettings.isTimerStarted = true
                                    
                                    self.gestureAllowed = false
                                    self.circleColor = Color.red.opacity(1.0)
                                    
                                    })
                            } else { // when userset timer 0 minute.
                                return Alert(title: Text("Nah!"), message: Text("No, No, No!\nYou can't start T!mer\nwhen you select 0 minute."))
                            }
                        })
                }.padding(.trailing, 6)
            }
        }
        .frame(width: 500, height: 300)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
