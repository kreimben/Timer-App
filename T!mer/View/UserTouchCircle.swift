import SwiftUI

struct UserTouchCircle: View {
    
    @EnvironmentObject var userTouchCurrentPointConverter: UserTouchCurrentPointConverter
    
    let initialValueOfDegrees = 90
    
    var body: some View {
        
        GeometryReader { geometry -> Path in
            Path { path in
                
                let centerView = CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2)
                
                path.move(to: centerView)
                path.addArc(center: centerView, radius: UIScreen.main.bounds.width * (0.75 / 2), startAngle: .degrees(270), endAngle: .degrees(self.userTouchCurrentPointConverter.returnPreciseDegrees()), clockwise: false)
                
            }//Path
        }//GeometryReader
    }//var body: some View
}//struct UserTouchCircle: View

class UserTouchCurrentPointConverter: ObservableObject {
    
    @Published var currentUser_sDegree = 0.0
    
    @EnvironmentObject var aboutTime: AboutTime
    
    var result: Double
    
    init() {
        
        self.result = 90
    }
    
    func returnPreciseDegrees() -> Double {
        
        result += self.currentUser_sDegree
        
        self.aboutTime.restOfTime += Int(self.currentUser_sDegree / 6) * 60
        
        return result
    }
}

struct UserTouchCircle_Previews: PreviewProvider {
    static var previews: some View {
        UserTouchCircle()
    }
}
