import SwiftUI
import Combine
import MessageUI

//import SwiftyStoreKit

struct SoundsArray: Identifiable, Hashable {
    
    let id = UUID()
    let soundName: String
    
    init(soundName: String) {
        
        self.soundName = soundName
    }
}

//MARK:- SettingPageView

struct SettingPageView: View {
    
    /// @Flag
    @State var showingModal = false
    /// @END
    
    /// @Marketin_Version
    @State var appVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
    /// @END
    
    /// @MailView-related
    @State var result: Result<MFMailComposeResult, Error>? = nil
    @State var isShowingMailView = false
    /// @END
    
    @ObservedObject var userSettings = UserSettings()
    
    @Environment(\.presentationMode) var presentation
    
//    @State var productID = "nonConsumable.removeads"  //"com.KreimbenPro.nonConsumable.removeads"
    
    var body: some View {
        List {
            
            Section(header: Text("Preferences..."), footer: Text("If you want to change notification sound, please set the sound before starting timer.")) {
                
                SoundPickerView()
                ColorPickerView()
            }
            
//            Section(header: Text("In-app purchase")) {
//
//                NavigationLink(destination: IAPView(productID: self.$productID)) {
//                    
//                    Text("Get T!mer Pro").foregroundColor(.blue)
//                }
//            }
            
            Section(header: Text("General")) {
                HStack {
                    Text("Version")
                    Spacer()
                    Text(self.appVersion)
                }
                
                Button(action: {
                    self.showingModal = true
                }) {
                    Text("Visit Kreimben.com")
                }.sheet(isPresented: $showingModal) {
                    SafariView(url: URL(string: "http://www.kreimben.com"))
                }
            }
                
            Section(header: Text("Special")) {
                
                Button(action: {
                    
                    self.isShowingMailView.toggle()
                }) {
                    
                    Text("Please give me feedback...")
                }
                .disabled(!MFMailComposeViewController.canSendMail())
                .sheet(isPresented: self.$isShowingMailView) {
                    
                    MailView(result: self.$result)
                }
            }
            .navigationBarTitle(Text("Settings"), displayMode: .inline)
            
            #if DEBUG
            Section(header: Text("For Debug")) {
                NavigationLink(destination: HapticTouchView()) {
                    Text("Haptic Touch Test")
                }
            }
            #endif
        }
        .listStyle(GroupedListStyle())
    }
}

//MARK:- SettingPageView_Previews

struct SettingPageView_Previews: PreviewProvider {
    static var previews: some View {
        SettingPageView()
    }
}
