import SwiftUI
import Combine
import UIKit
import CoreHaptics
import Dispatch

import GoogleMobileAds

struct ContentView: View {
    
    //MARK: For Timer
    
    @State var timeDisplay: TimeInterval = 0
    
    @ObservedObject var userSettings = UserSettings()
    
    @EnvironmentObject var mainController: MainController
    
    @State var showingAlert = false
    
    let timer = Timer.publish(every: 1, on: .main, in: .default).autoconnect()
    
    @State var userHapticFeedback = UserHapticFeedback()
    
    //MARK: For Interstitial Ads
    
    @State var interstitial: Interstitial!
    
    //MARK: For DragGesture
    
    @GestureState var dragAmount = CGPoint.zero
    @State var currentPoint = CGPoint.zero
    @State var center = CGPoint.zero
    @State var atan2Var: CGFloat = 0.0
    
    @State var circleColor = Color.red
    @State var circleRadius = CGFloat(UIScreen.main.bounds.width * 0.73 / 2)
    
    @State var gestureAllowed = false
    
    @ObservedObject var userTouchController = UserTouchController()
    
    //MARK:- var body: some View
    var body: some View {
        
        NavigationView {
            
            ZStack {
                
                Color.blue.opacity(0.55)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    
                    ZStack { //MARK:- Textbox
                        Rectangle()
                            .frame(width: 340, height: 140)
                            .foregroundColor(Color.blue.opacity(0.8))
                            .cornerRadius(30)
                        
                        
                        Text("\(self.userSettings.isTimerStarted ? String(format: "%02d:%02d", Int(timeDisplay / 60), Int(  timeDisplay  ) % 60) : String(format: "%02d:00", Int(  (  (self.userSettings.timeInputBeforeConvert + 90) * 10  ) / 60)  )/*앞에 String*/    )")
                            .font(.system(size: 110))
                            .font(.headline)
                            .foregroundColor(Color.white)
                            .onReceive(timer) { input in
                                
                                self.userHapticFeedback = UserHapticFeedback()
                                
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
                                }
                        }
                        
                    }
                    .padding(EdgeInsets(top: 50, leading: 0, bottom: 0, trailing: 0))
//                        .onAppear { //MARK: Interstitial ready
//
//                            self.interstitial = GADInterstitial(adUnitID: "ca-app-pub-3940256099942544/4411468910") // test id
//                            let request = GADRequest()
//                            self.interstitial.load(request)
//
//                    }
                    
                    ZStack(alignment: .center) { //MARK:- Circle Timer
                        
                        Circle()
                            .fill(Color(red: 138 / 255, green: 51 / 255, blue: 36 / 255))
                            .frame(width: UIScreen.main.bounds.width * 0.85)
                            .shadow(radius: 10)
                        
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
                                
                                print("onLongPressGesture is excuted.")
                                print("gesture allowed status: \(self.gestureAllowed)")
                                
                                if self.userSettings.isTimerStarted {
                                    
                                    self.userHapticFeedback.hapticFeedbackPlay()
                                    
                                    self.userSettings.isTimerStarted = false
                                    self.circleColor = Color.red.opacity(0.5)
                                    
                                    self.userSettings.notificationTime = Date()
                                    self.atan2Var = CGFloat(0)
                                    self.userSettings.timeInputBeforeConvert = -90
                                    self.userSettings.initialNotificationTime = 0
                                    
                                    print("isTimerStarted gonna FALSE")
                                    
                                    UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                                    
                                    //MARK: Interstitial
                                    self.interstitial = Interstitial()
                                    self.interstitial.showAd()
                                } else { // 멈춰 있는 상태에서 꾹 누르면 바로 60분 맞춰주기 shortcut!
                                    
                                    self.userHapticFeedback.hapticFeedbackPlay()
                                    
                                    self.userSettings.notificationTime = Date().addingTimeInterval(3600)
                                    
                                    self.mainController.setNotificationWhenTimerStart(timeInterval: 3600)
                                    self.userSettings.isTimerStarted = true
                                    
                                    self.gestureAllowed = false
                                    self.circleColor = Color.red.opacity(1.0)
                                    
                                    //MARK: Interstitial
                                    self.interstitial = Interstitial()
                                    self.interstitial.settingTimer()
                                }
                        }
                        .gesture(
                            DragGesture().updating($dragAmount) { value, state, transaction in
                                
                                if !self.userSettings.isTimerStarted {
                                    
                                    self.gestureAllowed = true
                                    
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
                                    
                                    self.userHapticFeedback.hapticFeedbackPlay()
                                    
                                    self.showingAlert = true
                                    
                                }
                            }
                        ) // .gesture
                            .alert(isPresented: self.$showingAlert, content: {
                                
                                if self.userSettings.initialNotificationTime > 0 { // which is MINUTE
                                    return Alert(title: Text("Start T!mer"), message: Text("Do you want to start T!mer\nfor \(Int(self.userSettings.initialNotificationTime / 60) ) minutes?"), primaryButton: .cancel(Text("Cancel")), secondaryButton: .default(Text("OK")) { //MARK: OK Button!
                                        
                                        //MARK: T!mer Setting
                                        self.userSettings.notificationTime = Date().addingTimeInterval(self.userSettings.initialNotificationTime)
                                        
                                        self.mainController.setNotificationWhenTimerStart(timeInterval: self.userSettings.initialNotificationTime)
                                        self.userSettings.isTimerStarted = true
                                        
                                        self.gestureAllowed = false
                                        self.circleColor = Color.red.opacity(1.0)
                                        
                                        //MARK: Interstitial
                                        self.interstitial = Interstitial()
                                        self.interstitial.settingTimer()
                                        })
                                } else { // when userset timer 0 minute.
                                    return Alert(title: Text("Nah!"), message: Text("No, No, No!\nYou can't start T!mer\nwhen you select 0 minute."))
                                }
                            })
                    }
                    
                    
                    Spacer()
                    //MARK:- Banner ad
                    BannerVC(purchased: self.userSettings.isUserPurchased)
                        .frame(width: 320, height: 50, alignment: .center)
                    
                }
                .navigationBarTitle(self.userSettings.isUserPurchased ? Text("T!mer PRO") : Text("T!mer"), displayMode: .inline)
                    
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
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    func shortcutVisualSettings() {
        
        self.gestureAllowed = false
        self.circleColor = Color.red.opacity(1.0)
    }
}

//MARK:- Previews
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//MARK:- BannerVC
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
            
            view.adUnitID = "ca-app-pub-3940256099942544/2934735716" // 배너광고 ID
            view.rootViewController = viewController
            viewController.view.addSubview(view)
            viewController.view.frame = CGRect(origin: .zero, size: kGADAdSizeBanner.size)
            view.load(GADRequest())
        }
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}

