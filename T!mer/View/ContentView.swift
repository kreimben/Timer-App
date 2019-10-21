import SwiftUI
import Combine

struct ContentView: View {
    
    @EnvironmentObject var mainController: MainController
    
    @State var angles: Double = 0
    
    let userTouchCurrentPointConverter = MainController()
    
    lazy var copyBool: Bool = self.mainController.isTimerStarted
    
    var body: some View {
        
        NavigationView {
            
            ZStack {
                
                Color.red.opacity(0.55)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Text("\(self.mainController.timeConverter())")
                        .font(.system(size: 100))
                        .font(.headline)
                        .foregroundColor(Color.white)
                    
                    Text("Result Degrees: \(self.mainController.userDegrees)")
                        .font(.system(size: 20))
                    
                    Text("Is timer working? \(self.mainController.isTimerStarted.description)")
                        .font(.system(size: 30))
                        .foregroundColor(Color.blue)
                    
                    Button("Clear") {
                        self.mainController.userDegrees = -89
                    }
                    .padding()
                    
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
                                        if self.mainController.isTimerStarted == false { // when timer is not working
                                            
                                            if (90 + self.mainController.userDegrees) * 10 >= 0 && (90 + self.mainController.userDegrees) * 10 < 3600 {
                                                
                                                self.mainController.userDegrees += (angle.degrees) / 18
                                                
                                            } else {
                                                print("error")
                                            }
                                        } else { // when timer is WORKING!!!
                                            
                                            self.mainController.endTimer()
                                            
                                            if (90 + self.mainController.userDegrees) * 10 >= 0 && (90 + self.mainController.userDegrees) * 10 < 3600 {
                                                
                                                self.mainController.userDegrees += (angle.degrees) / 18
                                                
                                            } else {
                                                print("error")
                                            }
                                        }
                                }
                                .onEnded { (_) in
                                    
                                    self.mainController.floorDegree()
                                    self.mainController.timerStart()
                                    self.mainController.floorDegree()
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
