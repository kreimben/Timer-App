import SwiftUI
import Combine
import Foundation

struct UserTouchCircle: View {
    
    @EnvironmentObject var mainController: MainController
    
    var body: some View {
        
        GeometryReader { geometry -> Path in
            Path { path in
                
                let centerView = CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2)

                path.move(to: centerView)

                if self.mainController.userDegrees >= -90 && self.mainController.userDegrees <= 270 {
                    path.addArc(center: centerView, radius: UIScreen.main.bounds.width * (0.735 / 2), startAngle: .degrees(270), endAngle: .degrees(self.mainController.userDegrees), clockwise: false)
                } else if self.mainController.userDegrees == 270 {
                    path.addArc(center: centerView, radius: UIScreen.main.bounds.width * (0.735 / 2), startAngle: .degrees(0), endAngle: .degrees(369.99), clockwise: false)
                }
                else {
                    path.addArc(center: centerView, radius: UIScreen.main.bounds.width * (0.735 / 2), startAngle: .degrees(270), endAngle: .degrees(269.99), clockwise: false)
                }
            }
        }
        .foregroundColor(Color.red)
        
        
    }
}

struct UserTouchCircle_Previews: PreviewProvider {
    static var previews: some View {
        UserTouchCircle()
    }
}
