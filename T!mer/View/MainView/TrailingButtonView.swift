import SwiftUI

struct TrailingButtonView: View {
    
    @ObservedObject var userSettings = UserSettings()
    
    var body: some View {
        Group {
            if self.userSettings.alertSoundIsOn {
                NavigationLink(destination: SettingPageView()) {
                    Image(systemName: "bell.fill")
                        .foregroundColor(Color.red.opacity(1.0))
                        .padding(8)
                        .background(Color.white.opacity(0.5))
                        .clipShape(Circle())
                }
            } else {
                NavigationLink(destination: SettingPageView()) {
                    Image(systemName: "bell.slash.fill")
                        .foregroundColor(Color.red.opacity(1.0))
                        .padding(8)
                        .background(Color.white.opacity(0.5))
                        .overlay(SlashPathView())
                        .clipShape(Circle())

                }
            }
        }
        
        
//        NavigationLink(destination: SettingPageView()) {
//            Image(systemName: "bell.fill")
//                .foregroundColor(Color.red.opacity(1.0))
//                .padding(8)
//                .background(Color.white.opacity(0.5))
//                .clipShape(Circle())
//        }
    }
}


struct TraillingButtonView_Previews: PreviewProvider {
    static var previews: some View {
        TrailingButtonView()
    }
}
