import SwiftUI
import Combine
import UIKit
import CoreHaptics
import GoogleMobileAds
import Dispatch


struct ContentView: View {
    @ObservedObject var userSettings = UserSettings()
    
    @EnvironmentObject var mainController: MainController
    
    @State var angles: Double = 0
    @State var showingAlert = false
    
//    var userHapticFeedback = UserHapticFeedback()
    
    var forStroke = UIScreen.main.bounds.width / 18.75
    @State var rotaionAngle: Int = 0
    
    let userTouchCurrentPointConverter = MainController()
    
    //MARK:- var body: some View
    var body: some View {
        
        NavigationView {
            
            ZStack {
                
                Color.blue.opacity(0.55)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    
                    ZStack { //MARK:- Textbox
                        Rectangle()
                            .frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.15)
                            .foregroundColor(Color.blue.opacity(0.8))
                            .cornerRadius(UIScreen.main.bounds.width * 0.1)
                        
                        Text("\(self.mainController.timeConverter())")
                            .font(.system(size: UIScreen.main.bounds.width * 0.25))
                            .font(.headline)
                            .foregroundColor(Color.white)
                    }
                    .padding(EdgeInsets(top: UIScreen.main.bounds.height * 0.1, leading: 0, bottom: 0, trailing: 0))
                    
                    Button("Adjust") {
                        print(self.userSettings.storedTime)
                        
                        self.mainController.userDegrees -= self.userSettings.storedTime / 10
                    }
                    
                    ZStack { //MARK:- Circle Timer
                        
                        Circle()
                            .fill(Color(red: 138 / 255, green: 51 / 255, blue: 36 / 255))
                            .frame(width: UIScreen.main.bounds.width * 0.85)
                            .shadow(radius: 10)
                        
                        Circle()
                            .fill(Color.red.opacity(0.5))
                            .frame(width: UIScreen.main.bounds.width * 0.77)
                            .shadow(radius: 10)
                        
                        UserTouchCircle()
                            .frame(width: UIScreen.main.bounds.width * 0.75, height: UIScreen.main.bounds.width * 0.75)
                        
                        Image("시계 바늘")
                            .resizable()
                            .frame(width: UIScreen.main.bounds.width * 0.85, height: UIScreen.main.bounds.width * 0.85)
                        
                        Circle() // touch center
                            .fill(Color.red.opacity(0.001))
                            .frame(width: UIScreen.main.bounds.width * 0.8)
                            .shadow(radius: 10)
                            .gesture(
                                RotationGesture()
                                    .onChanged { angle in
                                        
                                        self.rotaionAngle = Int(Double(self.mainController.userDegrees + 90) * 10)
                                        
                                        DispatchQueue.global(qos: .background).async {
                                            if Int(Double(self.mainController.userDegrees + 90) * 10) % 60 == 0 {
                                                DispatchQueue.main.async {
//                                                    self.userHapticFeedback.hapticFeedbackWhenUserRotatesDial()
                                                }
                                            }
                                        }
                                        
                                        if self.mainController.isTimerStarted == false { // when timer is not working
                                            
                                            if (90 + self.mainController.userDegrees) * 10 >= 0 && (90 + self.mainController.userDegrees) * 10 <= 3600 {
                                                
                                                self.mainController.userDegrees += (angle.degrees) / 80
                                                
                                            } else {
                                                print("error")
                                                
                                                if (90 + self.mainController.userDegrees) * 10 <= 0 {
                                                    self.mainController.initTimerToZero()
                                                } else {
                                                    self.mainController.initTimerToFull()
                                                }
                                            }
                                        } else { // when timer is WORKING!!!
                                            
                                            self.mainController.endTimer()
                                            
                                            if (90 + self.mainController.userDegrees) * 10 >= 0 && (90 + self.mainController.userDegrees) * 10 <= 3600 {
                                                
                                                self.mainController.userDegrees += (angle.degrees) / 80
                                                
                                            } else {
                                                print("error")
                                                
                                                if (90 + self.mainController.userDegrees) * 10 <= 0 {
                                                    self.mainController.initTimerToZero()
                                                } else {
                                                    self.mainController.initTimerToFull()
                                                }
                                            }
                                        }
                                } // .onChanged
                                    .onEnded { (_) in
                                        self.showingAlert = true
                                } // .onEnded
                        ) // .gesture
                            .alert(isPresented: self.$showingAlert, content: {
                                Alert(title: Text("Start T!mer"), message: Text("Do you want to start T!mer\nfor \(Int((self.mainController.userDegrees + 90) * 10)/60) minutes?"), primaryButton: .cancel(Text("Cancel")), secondaryButton: .default(Text("OK")) {
                                    
                                    self.mainController.floorDegree()
                                    self.mainController.timerStart()
                                    self.mainController.floorDegree()
                                    
                                    self.mainController.arrangeDegrees()
                                    })
                            })
                        
                    }
                    
                    
                    Spacer()
                    //MARK:- Banner ad
                    BannerVC(purchased: self.userSettings.isUserPurchased)
                        .frame(width: 320, height: 50, alignment: .center)
                    
                }
                .navigationBarTitle(Text("T!mer"), displayMode: .inline)
                    //                .navigationBarItems(trailing: TrailingButtonView())
                    
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

