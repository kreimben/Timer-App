import SwiftUI
import Combine
import UIKit
import CoreHaptics
import Dispatch
//import StoreKit

import GoogleMobileAds

#if os(iOS)
struct ContentView: View {
    
    // MARK: - Init()
    init() {
        
        let appearance = UINavigationBarAppearance()
        
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
        
        appearance.shadowColor = nil
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        
        UINavigationController().hidesBarsOnSwipe = true
        
        self.selGen.prepare()
    }
    
    // MARK: For Timer
    
    @State var timeDisplay: TimeInterval = 0
    
    /// @ObservedObject
    @ObservedObject var userSettings = UserSettings()
    @ObservedObject var userTouchController = UserTouchController()
    /// @END
    
    /// @EndvironmentObject
    @EnvironmentObject var mainController: MainController
    /// @END
    
    /// @Bool-related
    @State var showingAlert = false
    @State var todoViewBool = false
    /// @END
    
    let timer = Timer.publish(every: 1, on: .main, in: .default).autoconnect()
    
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
    
    /// @Current Build Version
    @State var currentBuildVersion = Int(Bundle.main.infoDictionary!["CFBundleVersion"] as? String ?? "0")!
    /// @END
    
    // MARK: - var body: some View
    var body: some View {
        
        NavigationView {
            
            ZStack {
                Color.white.opacity(0.3).edgesIgnoringSafeArea(.all)
                ColorScheme.getColor(self.userSettings.colorIndex).opacity(0.55)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    
                    ZStack { // MARK: - Textbox
                        Rectangle()
                            .frame(width: 340, height: 140)
                            .foregroundColor(ColorScheme.getColor(self.userSettings.colorIndex).opacity(0.8))
                            .cornerRadius(30)
                        
                        Text("\(self.userSettings.isTimerStarted ? String(format: "%02d:%02d", Int(timeDisplay / 60), Int(  timeDisplay  ) % 60) : String(format: "%02d:00", Int(  (  (self.userSettings.timeInputBeforeConvert + 90) * 10  ) / 60)  )/*앞에 String*/    )")
                            .font(.system(size: 110))
                            .font(.headline)
                            .foregroundColor(Color.white)
                            .onReceive(timer) { _ in
                                
                                DispatchQueue.main.async {
                                    
                                    if Date().distance(to: self.userSettings.notificationTime) > 0 && self.userSettings.isTimerStarted { // 시간이 0보다 작으면 타이머 종료
                                        
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
                        
                        UserTouchCircle(center: self.$center, atan2: self.$atan2Var, circleColor: self.$circleColor, circleRadius: self.$circleRadius)
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
                                
                                if self.userSettings.isTimerStarted { // Cancle it while timer is working
                                    
                                    /// @Cancel T!mer feedback
                                    let gen = UIImpactFeedbackGenerator(style: .soft)
                                    gen.prepare()
                                    gen.impactOccurred()
                                    /// @END
                                    
                                    /// @Set T!mer settings
                                    self.userSettings.isTimerStarted = false
                                    self.circleColor = Color.red.opacity(0.5)
                                    /// @For "Today Extension"
                                    UserDefaults(suiteName: "group.com.KreimbenPro.Timer")?.setValue(self.userSettings.isTimerStarted, forKey: "isTimerStarted")
                                    /// @END
                                    /// @END
                                    
                                    /// @Adjust after timer is stopped
                                    self.userSettings.notificationTime = Date()
                                    UserDefaults(suiteName: "group.com.KreimbenPro.Timer")?.setValue( self.userSettings.notificationTime, forKey: "notificationTime")
                                    UserDefaults(suiteName: "group.com.KreimbenPro.Timer")?.synchronize()
                                    self.atan2Var = CGFloat(0)
                                    self.userSettings.timeInputBeforeConvert = -90
                                    self.userSettings.initialNotificationTime = 0
                                    self.timeDisplay = 0
                                    /// @END
                                    
                                    print("isTimerStarted gonna FALSE")
                                    
                                    UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                                    
                                    /// @Interstitial
                                    self.interstitial = Interstitial()
                                    self.interstitial.showAd()
                                    /// @END
                                } else { // 멈춰 있는 상태에서 꾹 누르면 바로 60분 맞춰주기 shortcut!
                                    
                                    /// @Generate hapticfeedback
                                    let gen = UIImpactFeedbackGenerator(style: .heavy)
                                    gen.prepare()
                                    gen.impactOccurred(intensity: 30)
                                    /// @END
                                    
                                    self.userSettings.notificationTime = Date().addingTimeInterval(3600)
                                    UserDefaults(suiteName: "group.com.KreimbenPro.Timer")?.setValue( self.userSettings.notificationTime, forKey: "notificationTime")
                                    
                                    self.mainController.setNotificationWhenTimerStart(timeInterval: 3600)
                                    self.userSettings.isTimerStarted = true
                                    /// @For "Today Extension"
                                    UserDefaults(suiteName: "group.com.KreimbenPro.Timer")?.setValue(self.userSettings.isTimerStarted, forKey: "isTimerStarted")
                                    UserDefaults(suiteName: "group.com.KreimbenPro.Timer")?.synchronize()
                                    /// @END
                                    
                                    self.gestureAllowed = false
                                    self.circleColor = Color.red.opacity(1.0)
                                    
                                    // MARK: Interstitial
                                    self.interstitial = Interstitial()
                                    self.interstitial.settingTimer()
                                }
                        }
                        .gesture(
                            DragGesture().updating($dragAmount) { value, state, _ in
                                
                                if !self.userSettings.isTimerStarted {
                                    
                                    self.gestureAllowed = true
                                    
                                    state = value.location
                                    
                                    DispatchQueue.main.async {
                                        self.currentPoint = CGPoint(x: self.dragAmount.x - self.center.x, y: self.center.y - self.dragAmount.y)
                                        
                                        self.atan2Var = atan2(self.currentPoint.x, self.currentPoint.y)
                                        
                                        self.userSettings.timeInputBeforeConvert = self.userTouchController.atan2ToDegrees(tan: self.atan2Var)
                                        
                                        /// @Selection Feedback
                                        self.selGen.selectionChanged()
                                        /// @END
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
                                    
                                    if self.userSettings.initialNotificationTime > 60 {
                                        
                                        /// @Generate hapticfeedback
                                        let gen = UIImpactFeedbackGenerator(style: .heavy)
                                        gen.prepare()
                                        gen.impactOccurred(intensity: 30)
                                        /// @END
                                    } else {
                                        
                                        /// @Input HapticTouch Feedback
                                        let notiGen = UINotificationFeedbackGenerator()
                                        notiGen.prepare()
                                        notiGen.notificationOccurred(.error)
                                        /// @END
                                    }
                                    
                                    self.showingAlert = true
                                    
                                }
                            }
                        ) // .gesture
                            .alert(isPresented: self.$showingAlert, content: {
                                
                                if self.userSettings.initialNotificationTime > 0 { // which is MINUTE
                                    
                                    return Alert(title: Text("Start T!mer"), message: Text("Do you want to start T!mer\nfor \(Int(self.userSettings.initialNotificationTime / 60) ) minutes?"), primaryButton: .cancel(Text("Cancel")), secondaryButton: .default(Text("OK")) { // MARK: OK Button!
                                        
                                        self.userSettings.notificationTime = Date().addingTimeInterval(self.userSettings.initialNotificationTime)
                                        UserDefaults(suiteName: "group.com.KreimbenPro.Timer")?.setValue( self.userSettings.notificationTime, forKey: "notificationTime")
                                        
                                        self.mainController.setNotificationWhenTimerStart(timeInterval: self.userSettings.initialNotificationTime)
                                        self.userSettings.isTimerStarted = true
                                        /// @For "Today Extension"
                                        UserDefaults(suiteName: "group.com.KreimbenPro.Timer")?.setValue(self.userSettings.isTimerStarted, forKey: "isTimerStarted")
                                        UserDefaults(suiteName: "group.com.KreimbenPro.Timer")?.synchronize()
                                        /// @END
                                        
                                        self.gestureAllowed = false
                                        self.circleColor = Color.red.opacity(1.0)
                                        
                                        // MARK: Interstitial
                                        self.interstitial = Interstitial()
                                        self.interstitial.settingTimer()
                                        })
                                } else { // when userset timer 0 minute.
                                    
                                    #if DEBUG
                                    
                                    self.mainController.setNotificationWhenTimerStart(timeInterval: 1)
                                    return Alert(title: Text("DEBUG"), message: Text("For test notification sound"))
                                    
                                    #else
                                    return Alert(title: Text("Nah!"), message: Text("T!mer can't be started in 0 minutes."))
                                    #endif
                                }
                            })
                        
                        ZStack {
                            Image(systemName: "plus.circle.fill")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(Color.orange.opacity(1))
                                .onTapGesture {
                                    
                                    print("TodoView() NavigationLink button tapped!")
                                    self.todoViewBool.toggle()
                            }
                            .sheet(isPresented: self.$todoViewBool) {

                                TodoMasterView()
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
                    // MARK: - Banner ad
                    BannerVC(purchased: false)// self.userSettings.isUserPurchased)
                        .frame(width: 320, height: 50, alignment: .center)
                    
                }
                .blur(radius: self.userSettings.updateLogBlurValue)
                
                VStack {
                    
                    if self.userSettings.latestBuildVersion == 1 {
                        
                        WelcomeTo()
                    } else if self.userSettings.latestBuildVersion < currentBuildVersion {
                        
                        UpdateLogView()
                    }
                }
                .cornerRadius(20)
                .frame(
                    width: UIScreen.main.bounds.width * 0.85,
                    height: 450
                )
                    .navigationBarTitle(Text("T!mer"), displayMode: .inline)
                    
                    .navigationBarItems(trailing:
                        NavigationLink(destination: SettingPageView()) {
                            Image(systemName: "bell.fill")
                                .foregroundColor(Color.red.opacity(1.0))
                                .padding(8)
                                .background(Color.white.opacity(0.5))
                                .clipShape(Circle())
                        }
                )
                
            }
            .onAppear {
                
                self.userSettings.howManyOpenThisApp += 1
                
                print("UserSettings howManyOpenThisApp: \(self.userSettings.howManyOpenThisApp)")
                
                if ((self.userSettings.howManyOpenThisApp % 50) == 0) && self.userSettings.howManyOpenThisApp > 0 {
                    
                    SKStoreReviewController.requestReview()
                }
            } // Display Review
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    func visualSettingsWhileTimerIsWorking() {
        
        self.gestureAllowed = false
        self.circleColor = Color.red.opacity(1.0)
    }
}

// MARK: - Previews
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// MARK: - BannerVC
final private class BannerVC: UIViewControllerRepresentable {
    
    var isUserPurchased: Bool // getting the UserDefaults value from MainController()
    
    init(purchased isUserPurchased: Bool) {
        self.isUserPurchased = isUserPurchased
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<BannerVC>) -> BannerVC.UIViewControllerType {
        
        let view = GADBannerView(adSize: kGADAdSizeBanner)
        
        let viewController = UIViewController()
        
        if self.isUserPurchased {
            
        } else {
            
            #if DEBUG
            view.adUnitID = "ca-app-pub-3940256099942544/2934735716" // 배너광고 ID (for Test)
            #else
            view.adUnitID = "ca-app-pub-4942689053880729/1552889082" // 진짜 배너광고 ID
            #endif
            
            view.rootViewController = viewController
            viewController.view.addSubview(view)
            viewController.view.frame = CGRect(origin: .zero, size: kGADAdSizeBanner.size)
            view.load(GADRequest())
        }
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}
#endif
