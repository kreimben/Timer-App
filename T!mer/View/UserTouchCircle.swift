import SwiftUI

struct UserTouchCircle: View {
    var body: some View {
        
        drawingArc()
        
    }
}

struct drawingArc: Shape  {
    func path(in rect: CGRect) -> Path {
        let centerView = CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2)
        var p = Path()
        
        p.addArc(center: centerView, radius: UIScreen.main.bounds.width * (0.85 / 2), startAngle: .degrees(0), endAngle: .degrees(120), clockwise: true)
        
        return p
    }
}

struct UserTouchCircle_Previews: PreviewProvider {
    static var previews: some View {
        UserTouchCircle()
    }
}
