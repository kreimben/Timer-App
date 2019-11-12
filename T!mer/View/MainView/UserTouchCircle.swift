import SwiftUI
import Combine
import Foundation
import Dispatch


struct UserTouchCircle: View {
    
    @Binding var center: CGPoint
    @Binding var atan2: CGFloat
    @Binding var circleColor: Color
    @Binding var circleRadius: CGFloat
    
    @EnvironmentObject var mainController: MainController
    
    @ObservedObject var userTouchController = UserTouchController()
    @ObservedObject var userSettings = UserSettings()
    
    var body: some View {
        
        GeometryReader { geometry -> Path in
            Path { path in
                
                DispatchQueue.main.async {
                    self.center = CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2)
                }
                    
                path.move(to: self.center)
                    
                path.addArc(center: self.center, radius: self.circleRadius/*UIScreen.main.bounds.width * (0.73 / 2)*/, startAngle: .degrees(-90), endAngle: .degrees(self.atan2ToDegrees(tan: self.atan2)), clockwise: false)
                
            }
        }
        .foregroundColor(self.circleColor)
    }
    
    func atan2ToDegrees(tan: CGFloat) -> Double {
        
        if tan > 0 {
            
            return (Double(tan) * (180 / Double.pi) - 90)
            
        } else if tan < 0 {
            
            return  (Double(tan) * (180 / Double.pi) + 270)
            
        } else {
            
            return -90
            
        }
    }
}

public class UserTouchController: ObservableObject {
    
    func atan2ToDegrees(tan: CGFloat) -> Double {
        
        if tan > 0 {
            
            return (Double(tan) * (180 / Double.pi) - 90)
            
        } else if tan < 0 {
            
            return  (Double(tan) * (180 / Double.pi) + 270)
            
        } else {
            
            return 90
            
        }
    }
}
