import SwiftUI
import Combine
import CoreHaptics
import Dispatch
import StoreKit

import CommonT_mer

struct ContentView: View {
    
    // MARK: - Init()
    init() {

        let appearance = UINavigationBarAppearance()

        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)

        appearance.shadowColor = nil
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance

        self.selGen.prepare()
    }
    
    // MARK: - CoreData related variables
    @Environment(\.managedObjectContext) var managedObjectContext
    
    // MARK: - Timer related variables
    
    @State var timeDisplay: TimeInterval = 0
    
    /// @ObservedObject
    @ObservedObject var userSettings = CTUserSettings()
    @ObservedObject var userTouchController = CTUserTouchController()
    @ObservedObject var mainController = CTMainController()
    /// @END
    
    /// @Bool-related
    @State var showingAlert = false
    @State var todoViewBool = false
    /// @END
    
    /// @Timer-related
    @State var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
//    let dispatch = DispatchQueue(label: "Timer", qos: .userInteractive, attributes: .concurrent, autoreleaseFrequency: .inherit, target: .global())
    /// @END
    
    /// @For Interstitial Ads
    @State var interstitial: Interstitial!
    /// @END
    
    /// @For DragGesture
    @GestureState var dragAmount = CGPoint.zero
    @State var currentPoint = CGPoint.zero
    @State var center = CGPoint.zero
    @State var atan2Var: CGFloat = 0.0
    /// @END
    
    /// @Circle related
    @State var circleColor = Color.red
    @State var circleRadius = CGFloat(UIScreen.main.bounds.width * 0.73 / 2)
    /// @END
    
    /// @Drag related
    @State var gestureAllowed = false
    /// @END
    
    /// @For selection feedback
    @State var selGen = UISelectionFeedbackGenerator()
    /// @END
    
    // MARK: - var body: some View
    var body: some View {
        
        NavigationView {
            
            ZStack {
                Color.white.opacity(0.3).edgesIgnoringSafeArea(.all)
                CTColorScheme.getColor(self.userSettings.colorIndex).opacity(0.55)
                    .edgesIgnoringSafeArea(.all)
                    .onAppear {
                        
                        self.timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
                }
                
                VStack {
                    
                    ZStack { // MARK: - Textbox
                        Rectangle()
                            .frame(width: 340, height: 140)
                            .foregroundColor(CTColorScheme.getColor(self.userSettings.colorIndex).opacity(0.8))
                            .cornerRadius(30)
                            
                        Group {
                            if self.mainController.isTimerRunning() {
                                
                                Text(String(format: "%02d:%02d", Int(  timeDisplay / 60  ), Int(  timeDisplay  ) % 60 ))
                            } else {
                                
                                Text(String(format: "%02d:00", Int( timeDisplay / 60 ) ))
                            }
                        }
                            .font(.system(size: 110))
                            .font(.headline)
                            .foregroundColor(Color.white)
                            .onReceive(timer) { _ in
                                
                                DispatchQueue.main.async { // self.dispatch.async {
                                    // MARK: Reflect other things EVERY SECONDS
                                    self.mainController.setDisplay(completion: { (time, atan2) in
                                        
                                        if time != 0 && atan2 != 0 {

                                            self.timeDisplay = time
                                            self.atan2Var = atan2
                                        }
                                    })
                                }
                        }
                    } // TextBox Elements
                        .padding(EdgeInsets(top: 50, leading: 0, bottom: 0, trailing: 0))
                    
                    ZStack(alignment: .center) { // MARK: - Circle Timer
                        
                        Circle()
                            .fill(Color(red: 138 / 255, green: 51 / 255, blue: 36 / 255))
                            .frame(width: UIScreen.main.bounds.width * 0.85)
                            .shadow(radius: 10)
                        
                        ZStack(alignment: .center) {
                            
                            Image("T!mer base after 1.4.0")
                                .resizable()
                                .scaledToFit()
                                .frame(width: UIScreen.main.bounds.width * 0.85)
                            
                            Circle()
                                .fill(Color.red)
                                .frame(width: 40)
                                .padding(EdgeInsets(
                                    top: 10,
                                    leading: UIScreen.main.bounds.width * 0.72,
                                    bottom: UIScreen.main.bounds.width * 0.72,
                                    trailing: 10
                                ))
                        }
                        
                        Circle()
                            .fill(Color.red.opacity(0.5))
                            .frame(width: UIScreen.main.bounds.width * 0.77)
                            .shadow(radius: 10)
                        
                        CTUserTouchCircle(center: self.$center, atan2: self.$atan2Var, circleColor: self.$circleColor, circleRadius: self.$circleRadius)
                            .frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.width * 0.8)
                        
                        Image("시계 바늘")
                            .resizable()
                            .frame(width: UIScreen.main.bounds.width * 0.85, height: UIScreen.main.bounds.width * 0.85)
                        
                        Circle() // Touch Center
                            .fill(Color.red.opacity(0.001))
                            .frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.width * 0.8)
                            .shadow(radius: 10)
                            .onLongPressGesture(minimumDuration: 0.6, maximumDistance: 5) {
                                
                                // MARK: - Long Press Gesture
                                print("onLongPressGesture is excuted.")
                                print("gesture allowed status: \(self.gestureAllowed)")
                                
                                if self.mainController.isTimerRunning() { // Cancle it while timer is running
                                    
                                    /// @Cancel T!mer feedback
                                    self.mainController.generateHapticFeedback(as: .soft)
                                    /// @END
                                    
                                    self.mainController.stopTimer { (timeDisplay, atan2, gesture) in
                                        
                                        self.timeDisplay = timeDisplay
                                        self.atan2Var = atan2
                                        self.changeGestureValue(as: gesture)
                                    }
                                    
                                } else { // 멈춰 있는 상태에서 꾹 누르면 바로 60분 맞춰주기 shortcut!
                                    
                                    /// @Generate hapticfeedback
                                    self.mainController.generateHapticFeedback(as: .heavy)
                                    /// @END
                                    
                                    self.mainController.startTimer(with: 3600) { (gesture) in
                                        
                                        self.changeGestureValue(as: gesture)
                                    }
                                    
                                    if !self.userSettings.turnOffAds {
                                        // initializing interstitial ad
                                        self.interstitial = Interstitial()
                                        self.interstitial.settingTimer()
                                    }
                                }
                        }
                        .gesture( // MARK: Gesture
                            DragGesture().updating($dragAmount) { value, state, _ in
                                
                                if !(self.mainController.isTimerRunning()) {
                                    
                                    self.changeGestureValue(as: true)
                                    
                                    state = value.location
                                    
                                    DispatchQueue.main.async { // self.dispatch.async { 
                                        self.currentPoint = CGPoint(x: self.dragAmount.x - self.center.x, y: self.center.y - self.dragAmount.y)
                                        
                                        self.atan2Var = atan2(self.currentPoint.x, self.currentPoint.y)
                                        
                                        _ = self.mainController.arrangeAtanValue(atan2: self.atan2Var) { (convertedTime) in
                                            
                                            self.timeDisplay = convertedTime
                                        }
                                    }
                                    
                                    self.selGen.selectionChanged()
                                }
                            }
                            .onEnded { (_) in // MARK: After gesture ended
                                
                                if self.gestureAllowed { // 타이머가 멈췄을 때 = 제스쳐가 허용될 때
                                    
                                    self.atan2Var = self.mainController.arrangeAtanValue(atan2: self.atan2Var) { (convertedTime) in
                                        
                                        self.userSettings.initialNotificationTime = convertedTime
                                    }
                                    
                                    if self.userSettings.initialNotificationTime > 60 {

                                        /// @Generate hapticfeedback
                                        self.mainController.generateHapticFeedback(as: .heavy)
                                        /// @END
                                    } else {

                                        /// @Input HapticTouch Feedback
                                        self.mainController.generateNotificationFeedback(as: .error)
                                        /// @END
                                    }
                                    
                                    self.showingAlert = true
                                }
                            }
                        ) // .gesture
                            .alert(isPresented: self.$showingAlert, content: { // MARK: Alert
                                
                                if self.userSettings.initialNotificationTime > 0 { // which is SECOND
                                    
                                    return Alert(title: Text("Start T!mer"), message: Text("Do you want to start T!mer\nfor \(Int(self.userSettings.initialNotificationTime / 60) ) minutes?"), primaryButton: .cancel(Text("Cancel")), secondaryButton: .default(Text("OK")) { // MARK: OK Button!
                                        
                                        self.mainController.startTimer(with: self.userSettings.initialNotificationTime) { (gesture) in
                                            
                                            self.changeGestureValue(as: false)
                                        }
                                        
                                        if !self.userSettings.turnOffAds {
                                            // initializing interstitial ad
                                            self.interstitial = Interstitial()
                                            self.interstitial.settingTimer()
                                        }
                                        
                                        } // OK Button
                                    )
                                } else { // when user set timer 0 minute.
                                    
                                    #if DEBUG
                                    
                                    self.mainController.setNotificationTime(timeInterval: 1)
                                    return Alert(title: Text("DEBUG"), message: Text("For test notification sound"))
                                    
                                    #else
                                    return Alert(title: Text("Nah!"), message: Text("T!mer can't be started in 0 minutes."))
                                    #endif
                                }
                            })
                        
                        ZStack {
                            
                            // MARK: TodoMasterView link here
                            NavigationLink(destination: TodoView().environment(\.managedObjectContext, self.managedObjectContext)) {
                                
                                Image(systemName: "plus.circle.fill")                               .resizable()
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(Color.orange.opacity(1))
                            }
                        }
                        .padding(EdgeInsets(
                            top: 10,
                            leading: UIScreen.main.bounds.width * 0.72,
                            bottom: UIScreen.main.bounds.width * 0.72,
                            trailing: 10
                        ))
                            .padding()
                    } // Circle Timer Elements
                    
                    Spacer()
                    BannerVC()
                        .frame(width: 320, height: 50, alignment: .center)
                    
                }
                .navigationBarTitle(Text("T!mer"), displayMode: .inline)
                    
//                .navigationBarItems(trailing:
//                    NavigationLink(destination: SettingPageView()) {
//                        Image(systemName: "bell.fill")
//                            .foregroundColor(Color.red.opacity(1.0))
//                            .padding(8)
//                            .background(Color.white.opacity(0.5))
//                            .clipShape(Circle())
//                    }
//                )
                
            }
            .onAppear {
                
                self.userSettings.howManyOpenThisApp += 1
                
                print("UserSettings howManyOpenThisApp: \(self.userSettings.howManyOpenThisApp)")
                
                if ((self.userSettings.howManyOpenThisApp % 100) == 0) && self.userSettings.howManyOpenThisApp > 0 {
                    
                    SKStoreReviewController.requestReview()
                }
            } // Display Review
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    func changeGestureValue(as value: Bool) {

        self.gestureAllowed = value
    }
}

// MARK: - Previews
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
