import SwiftUI

struct SlashPathView: View {
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                
                path.move(to: CGPoint(x: 0, y: 0))
                
                path.addLine(to: CGPoint(x: geometry.size.width, y: geometry.size.width))
                
            }
            .stroke(Color.red, lineWidth: 2.5)
        }
    }
}

struct SlashPathView_Previews: PreviewProvider {
    static var previews: some View {
        SlashPathView()
    }
}
