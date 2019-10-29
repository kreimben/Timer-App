import SwiftUI
import Combine
import GoogleMobileAds
import UIKit

struct ContentView: View {
    @ObservedObject var userSettings = UserSettings()
    
    @EnvironmentObject var mainController: MainController
    
    @State var angles: Double = 0
    
    let userTouchCurrentPointConverter = MainController()
    
    lazy var copyBool: Bool = self.mainController.isTimerStarted
    
    var body: some View {
        
        NavigationView {
            
            ZStack {
                
                Color.blue.opacity(0.55)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    
                    ZStack {
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
                    
                    Text("Current state : "+String(userSettings.alertSoundIsOn))
                    
                    ZStack {
                        
                        Circle()
                            .fill(Color(red: 138 / 255, green: 51 / 255, blue: 36 / 255))
                            .frame(width: UIScreen.main.bounds.width * 0.85)
                            .shadow(radius: 10)
                        
                        Circle()
                            .fill(Color.red.opacity(0.5))
                            .frame(width: UIScreen.main.bounds.width * 0.8)
                            .shadow(radius: 10)
                        
                        UserTouchCircle()
                            .frame(width: UIScreen.main.bounds.width * 0.75,height: UIScreen.main.bounds.width * 0.75)
                        
                        Circle()
                            .fill(Color.red.opacity(0.001))
                            .frame(width: UIScreen.main.bounds.width * 0.75)
                            .shadow(radius: 10)
                            .gesture(
                                RotationGesture()
                                    .onChanged { angle in
                                        if self.mainController.isTimerStarted == false { // when timer is not working
                                            
                                            if (90 + self.mainController.userDegrees) * 10 >= 0 && (90 + self.mainController.userDegrees) * 10 < 3600 {
                                                
                                                self.mainController.userDegrees += (angle.degrees) / 18
                                                
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
                                            
                                            if (90 + self.mainController.userDegrees) * 10 >= 0 && (90 + self.mainController.userDegrees) * 10 < 3600 {
                                                
                                                self.mainController.userDegrees += (angle.degrees) / 18
                                                
                                            } else {
                                                print("error")
                                                
                                                if (90 + self.mainController.userDegrees) * 10 <= 0 {
                                                    self.mainController.initTimerToZero()
                                                } else {
                                                    self.mainController.initTimerToFull()
                                                }
                                            }
                                        }
                                }
                                .onEnded { (_) in
                                    
                                    self.mainController.floorDegree()
                                    self.mainController.timerStart()
                                    self.mainController.floorDegree()
                                    
                                    self.mainController.arrangeDegrees()
                                }
                        )
                    }
                    
                    Spacer()
                    BannerVC(purchased: self.mainController.isUserPurchased)
                        .frame(width: 320, height: 50, alignment: .center)
                    
                }
                .navigationBarTitle(Text("T!mer"), displayMode: .inline)
//                .navigationBarItems(trailing: NavigationLink(destination: SettingPageView()) {
//
//                    if userSettings.alertSoundIsOn {
//                        Image(systemName: "bell.fill")
//                            .foregroundColor(Color.red.opacity(1.0))
//                            .padding(8)
//                            .background(Color.white.opacity(0.5))
//                            .clipShape(Circle())
//                    } else {
//                        Image(systemName: "bell.slash.fill")
//                            .foregroundColor(Color.red.opacity(1.0))
//                            .padding(8)
//                            .background(Color.white.opacity(0.5))
//                            .clipShape(Circle())
//                    }
//                })
                .navigationBarItems(trailing: TrailingButtonView())
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
    
    var isUserPurchased: Bool
    
    init(purchased: Bool) {
        
        self.isUserPurchased = purchased
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<BannerVC>) -> BannerVC.UIViewControllerType {
        
        let view = GADBannerView(adSize: kGADAdSizeBanner)
        
        let viewController = UIViewController()
        
        if isUserPurchased  {
            
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

