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

/*
 
 struct UserTouchCircle: View {
     
     // atan2가     0일 때는 -90
     // atan2가  1.57일 때는   0
     // atan2가  3.14일 때는  90
     //           =
     // atan2가 -3.14일 때는  90
     // atan2가 -1.57일 때는 180
     // atan2가    -0일 때는 270
     //
     // atan2값이 양수이든 음수이든 0일때는 -90이 나와야 하고 3일 때는 90이 나와야 함.
     //
     //
     
     @Binding var center: CGPoint
     @Binding var atan2: CGFloat
 
     @EnvironmentObject var mainController: MainController
     
     var body: some View {
         
         GeometryReader { geometry in
             Path { path in
                 
                 self.center = CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2)
                 
                 path.move(to: self.center)
                 
                 path.addArc(center: self.center, radius: UIScreen.main.bounds.width * 0.40, startAngle: .degrees(-90), endAngle: .degrees(self.atan2ToDegrees(tan: self.atan2)), clockwise: false)
             }
         }
 .foregroundColor(Color.red)
     }
     
     func atan2ToDegrees(tan: CGFloat) -> Double {
         
         if tan > 0 {
             return (Double(tan) * (180 / Double.pi) - 90)
         } else {
             return (Double(tan) * (180 / Double.pi) + 270)
         }
     }
 }
 
 */

struct UserTouchCircle_Previews: PreviewProvider {
    static var previews: some View {
        UserTouchCircle()
    }
}
