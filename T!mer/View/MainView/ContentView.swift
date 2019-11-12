import SwiftUI
import Combine
import UIKit
import CoreHaptics
import GoogleMobileAds
import Dispatch


struct ContentView: View {
    @ObservedObject var userSettings = UserSettings()
    
    @EnvironmentObject var mainController: MainController
    
    @State var showingAlert = false
    
    //    @State var isTimerStarted = false
    let timer = Timer.publish(every: 1, on: .main, in: .default).autoconnect()
    
    var userHapticFeedback = UserHapticFeedback()
    
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
                            .frame(width: 340/*UIScreen.main.bounds.width * 0.8*/, height: 140/*UIScreen.main.bounds.height * 0.15*/)
                            .foregroundColor(Color.blue.opacity(0.8))
                            .cornerRadius(30/*UIScreen.main.bounds.width * 0.07*/)
                        
                        
                        Text("\(self.mainController.isTimerStarted ? String(format: "%02d:%02d", Int(((self.userSettings.restOfTime + 90) * 10) / 60), Int((self.userSettings.restOfTime + 90) * 10) % 60) : String(format: "%02d:00", Int(((self.userSettings.restOfTime + 90) * 10) / 60))    )")
                            .font(.system(size: 110/*UIScreen.main.bounds.width * 0.2*/))
                            .font(.headline)
                            .foregroundColor(Color.white)
                            .onReceive(timer) { input in
                                
                                DispatchQueue.global(qos: .background).async {
                                    if !self.userSettings.backgroundTimeIntervalSynchronized {
                                        
                                        let newDate = Date()
                                        self.userSettings.timeInterval = self.userSettings.oldTime.distance(to: newDate)
                                        
                                        print("////////////REST OF TIME: \((self.userSettings.restOfTime + 90) * 10)")
                                        print("////////////TIME INTERVAL: \(self.userSettings.timeInterval)")
                                        
                                        if (self.userSettings.restOfTime + 90) * 10 > self.userSettings.timeInterval {
                                            
                                            self.userSettings.restOfTime -= self.userSettings.timeInterval * 0.1
                                            self.atan2Var -= CGFloat((self.userSettings.timeInterval * 0.1) * (Double.pi / 180))
                                            print("                  Timer is SYNCHRONIZED!")
                                        } else {
                                            self.userSettings.restOfTime = -90
                                            self.atan2Var = CGFloat(0)
                                        }
                                        
                                        self.userSettings.backgroundTimeIntervalSynchronized = true
                                        print("                  backgroundTimerIntervalSynchronized become TRUE")
                                        
                                        self.userSettings.timeInterval = 0
                                        print("                  timeInterval is \(self.userSettings.timeInterval) now")
                                    }
                                    
                                    if self.mainController.isTimerStarted {
                                        
                                        if (self.userSettings.restOfTime + 90) > 0 {
                                            
                                            self.atan2Var -= 0.1 * (CGFloat.pi / 180)
                                            self.userSettings.restOfTime -= 0.1
                                        } else { // when timer is done!
                                            
                                            self.mainController.isTimerStarted = false
                                            self.gestureAllowed = true
                                            self.circleColor = Color.red.opacity(0.5)
                                        }
                                    }
                                }
                        }
                    }
                    .padding(EdgeInsets(top: 50/*UIScreen.main.bounds.height * 0.1*/, leading: 0, bottom: 0, trailing: 0))
                    
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
                                
                                if self.mainController.isTimerStarted {
                                    self.userHapticFeedback.hapticFeedbackWhenUserRotatesDial()
                                    
                                    self.mainController.isTimerStarted = false
                                    self.circleColor = Color.red.opacity(0.5)
                                    print("isTimerStarted gonna FALSE")
                                } else {
                                    
                                }
                                
                        }
                        .gesture(
                            DragGesture().updating($dragAmount) { value, state, transaction in
                                
                                if !self.mainController.isTimerStarted {
                                    
                                    self.gestureAllowed = true
                                    
                                    state = value.location
                                    
                                    DispatchQueue.main.async {
                                        self.currentPoint = CGPoint(x: self.dragAmount.x - self.center.x, y: self.center.y - self.dragAmount.y)
                                        
                                        self.atan2Var = atan2(self.currentPoint.x, self.currentPoint.y)
                                        
                                        self.userSettings.restOfTime = self.userTouchController.atan2ToDegrees(tan: self.atan2Var)
                                    }
                                }
                            }
                            .onChanged { (_) in
                                
                                if self.gestureAllowed {
                                    
                                    UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                                }
                            }
                            .onEnded { (_) in
                                
                                if self.gestureAllowed {
                                    
                                    if self.userSettings.restOfTime >= 0 {
                                        
                                        self.userSettings.restOfTime = Double(Int(self.userSettings.restOfTime) - (Int(self.userSettings.restOfTime) % 6))
                                    } else {
                                        
                                        self.userSettings.restOfTime = Double(Int(self.userSettings.restOfTime) + (Int(self.userSettings.restOfTime) % 6))
                                        
                                        if ((( Int(self.userSettings.restOfTime) + 90) * 10) % 60) == 20 {
                                            
                                            self.userSettings.restOfTime -= 2
                                        } else if ((( Int(self.userSettings.restOfTime) + 90) * 10) % 60) == 40 {
                                            
                                            self.userSettings.restOfTime -= 4
                                        }
                                    }
                                    
                                    let degreeForConvert = (self.userSettings.restOfTime + 90)
                                    
                                    self.atan2Var = CGFloat(degreeForConvert * (Double.pi / 180))
                                    
                                    self.userHapticFeedback.hapticFeedbackWhenUserRotatesDial()
                                    
                                    self.showingAlert = true
                                }
                            }
                        ) // .gesture
                            .alert(isPresented: self.$showingAlert, content: {
                                
                                if ((self.userSettings.restOfTime + 90) * 10) / 60 > 0 { // which is MINUTE
                                    return Alert(title: Text("Start T!mer"), message: Text("Do you want to start T!mer\nfor \(Int((self.userSettings.restOfTime + 90) * 10)/60) minutes?"), primaryButton: .cancel(Text("Cancel")), secondaryButton: .default(Text("OK")) {
                                        
                                        self.mainController.setNotificationWhenTimerStart()
                                        self.mainController.isTimerStarted = true
                                        
                                        self.gestureAllowed = false
                                        self.circleColor = Color.red.opacity(1.0)
                                        
                                        })
                                } else {
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

