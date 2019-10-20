import SwiftUI
import UIKit

struct ContentView: View {
    
    @State var timeDisplay = "00:00"
    @State var restOfTime: Double = 1800
    @State private var alertAnimation: Bool = false
    
    var body: some View {
        
        NavigationView {
            
            ZStack {
                
                Color.red.opacity(0.75)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Text(timeDisplay)
                        .font(.system(size: 100))
                        .font(.headline)
                        .foregroundColor(Color.white)
                    
                    Circle()
                        .fill(Color(red: 138 / 255, green: 51 / 255, blue: 36 / 255))
                        .frame(width: UIScreen.main.bounds.width * 0.85)
                    
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
