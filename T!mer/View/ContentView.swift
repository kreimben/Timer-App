import SwiftUI
import UIKit

struct ContentView: View {
    
    @EnvironmentObject var rotationAmount: UserTouchCurrentPointConverter
    
    @ObservedObject var aboutTime = AboutTime()
    
    
    var body: some View {
        
        NavigationView {
            
            ZStack {
                
                Color.red.opacity(0.55)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Text(aboutTime.timeConverter(self.aboutTime.restOfTime))
                        .font(.system(size: 100))
                        .font(.headline)
                        .foregroundColor(Color.white)
                    
                    ZStack {
                        Circle()
                            .fill(Color(red: 138 / 255, green: 51 / 255, blue: 36 / 255))
                            .frame(width: UIScreen.main.bounds.width * 0.85)
                        
                        Circle()
                            .fill(Color.red.opacity(0.5))
                            .frame(width: UIScreen.main.bounds.width * 0.8)
                        
                        UserTouchCircle()
                            .frame(width: UIScreen.main.bounds.width * 0.75,height: UIScreen.main.bounds.width * 0.75)
                        
                        Circle()
                            .fill(Color.red.opacity(0.001))
                            .frame(width: UIScreen.main.bounds.width * 0.8)
                            .gesture(
                                RotationGesture()
                                    .onChanged { angle in
                                        
                                        if self.aboutTime.restOfTime > 0 && self.aboutTime.restOfTime < 1800 {
                                            self.rotationAmount.currentUser_sDegree = angle.degrees / 15
                                        } else {
                                            print("error")
                                        }
                                }
                                .onEnded { (_) in
                                    
                                }
                        )
                    }
                }
                .navigationBarTitle(Text("T!mer for Concentration"), displayMode: .inline)
                .navigationBarItems(trailing: NavigationLink(destination: SettingPageView()) {
                    Image(systemName: "bell.fill")
                        .foregroundColor(Color.red.opacity(1.0))
                        .padding(8)
                        .background(Color.white.opacity(0.5))
                        .clipShape(Circle())
                })
            }
        }
    }
}

class AboutTime: ObservableObject {
    
    @Published var restOfTime: Int = 1800
    
    func timeConverter(_ time: Int) -> String {
        
        if restOfTime % 60 > 10 {
            return "\(restOfTime / 60):\(restOfTime % 60)"
        } else {
            return "\(restOfTime / 60):0\(restOfTime % 60)"
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
