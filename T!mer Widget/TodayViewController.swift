import UIKit
import SwiftUI
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Allow the today widget to be expanded or contracted.
        extensionContext?.widgetLargestAvailableDisplayMode = .expanded
        
    }
    // MARK: - viewDidAppear
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        let vc = UIHostingController(rootView: MainWidgetView())
        
        present(vc, animated: true)
    }
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.newData)
    }
    
}

struct MainWidgetView: View {
    
    /// @ObservedObject
    @ObservedObject var userSettings = UserSettings()
    @ObservedObject var mainController = MainController()
    /// @END
    
    /// @Timer
    var timer = Timer.publish(every: 1, on: .current, in: .default).autoconnect()
    /// @END
    
    /// @For DragGesture
    @GestureState var dragAmount = CGPoint.zero
    @State var currentPoint = CGPoint.zero
    @State var center = CGPoint.zero
    @State var atan2Var: CGFloat = 0.0
    /// @END
    
    /// @For Circle
    @State var circleColor = Color.red.opacity(0.5)
    @State var circleRadius = CGFloat(70)
    /// @END
    
    @State var timeDisplay: TimeInterval = 0
    
    func visualSettingsWhileTimerIsWorking() {
        
        self.circleColor = Color.red.opacity(1.0)
    }
    
    var body: some View {
        
        ZStack {
            
            Color.white.opacity(0.3).edgesIgnoringSafeArea(.all)
            ColorScheme.getColor(self.userSettings.colorIndex).opacity(0.55)
                .edgesIgnoringSafeArea(.all)
            
            HStack {
                
                ZStack {
                    Circle()
                        .fill(Color(red: 138 / 255, green: 51 / 255, blue: 36 / 255))
                        .frame(width: 90)
                        .shadow(radius: 10)
                    
                    Circle()
                        .fill(Color.red.opacity(0.5))
                        .frame(width: 80)
                        .shadow(radius: 10)
                    
                    Image("시계 바늘")
                        .resizable()
                        .frame(width: 90, height: 90)
                    
                    UserTouchCircle(
                        center: self.$center,
                        atan2: self.$atan2Var,
                        circleColor: self.$circleColor,
                        circleRadius: self.$circleRadius
                    )
                        .frame(width: 85, height: 85)
                } // Circle View
                    .padding(.trailing, 70)
                
                ZStack {
                    
                    Rectangle()
                        .frame(width: 120, height: 60)
                        .foregroundColor(ColorScheme.getColor(self.userSettings.colorIndex).opacity(0.8))
                        .cornerRadius(15)
                    
                    Text("\(self.userSettings.isTimerStarted ? String(format: "%02d:%02d", Int(timeDisplay / 60), Int(  timeDisplay  ) % 60) : String(format: "%02d:00", Int(  (  (self.userSettings.timeInputBeforeConvert + 90) * 10  ) / 60)  )/*앞에 String*/    )")
                        .font(.system(size: 40))
                        .font(.headline)
                        .foregroundColor(Color.white)
                        .onReceive(timer) { _ in
                            
                            DispatchQueue.main.async {
                                
                                if Date().distance(to: self.userSettings.notificationTime) > 0 && self.userSettings.isTimerStarted { // 시간이 0보다 작으면 타이머 종료
                                    
                                    self.timeDisplay = UserDefaults(suiteName: "group.com.KreimbenPro.Timer")?.value(forKey: "timeDisplay") as? TimeInterval ?? 1111
                                    
                                    print("timeDisplay fetch from UserDefaults(suiteName:) \(self.timeDisplay)")
                                    
                                    if Date().distance(to: self.userSettings.notificationTime) > 0 {
                                        
                                        self.timeDisplay = Date().distance(to: self.userSettings.notificationTime)
                                        self.atan2Var = CGFloat((self.timeDisplay / 10) * (Double.pi / 180))
                                    }
                                    
                                } else {
                                    
                                    self.userSettings.isTimerStarted = false
                                    self.circleColor = Color.red.opacity(0.5)
                                }
                                
                                ///For color setting
                                self.visualSettingsWhileTimerIsWorking()
                            }
                    }
                } // Text Box View
            }
        }
    }
}

//
//  TodayViewController.swift
//  T!mer Widget
//
//  Created by Aksidion Kreimben on 5/19/20.
//  Copyright © 2020 Aksidion Kreimben. All rights reserved.
//
