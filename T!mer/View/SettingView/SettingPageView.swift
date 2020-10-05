import SwiftUI
import Combine
import MessageUI

import CommonT_mer

// MARK: - SettingPageView

struct SettingPageView: View {
    
    /// @Flag
    @State var showingModal = false
    /// @END
    
    /// @Marketin_Version
    @State var appVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String ?? ""
    /// @END
    
    /// @MailView-related
    @State var result: Result<MFMailComposeResult, Error>? = nil
    @State var isShowingMailView = false
    /// @END
    
    @ObservedObject var userSettings = CTUserSettings()
    
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        
        NavigationView {
            
            List {
                
                Section(header: Text("Preferences..."), footer: Text("If you want to change notification sound, please set the sound before starting timer.")) {
                    
                    NavigationLink(destination: SoundPickerWrapper()) {
                        
                        Text("Notification Sound")
                    }
                    ColorPickerView()
                }
                
                Section(header: Text("General")) {
                    HStack {
                        Text("Version")
                        Spacer()
                        Text(self.appVersion)
                    }
                    
                    NavigationLink(destination: HowToUseThisApp()) {
                        
                        Text("How to use this app?")
                            .foregroundColor(.orange)
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
                    
                    Toggle(isOn: self.$userSettings.turnOffAds) {
                        
                        Text("Turn off ads")
                    }
                    
                    NavigationLink(destination: HapticFeedbackDebugMenuView()) {
                        Text("Haptic Feedback")
                    }
                }
                #endif
            }
            .listStyle(GroupedListStyle())
            .navigationBarTitle(Text("Settings"), displayMode: .inline)
        }
    }
}

// MARK: - SettingPageView_Previews

struct SettingPageView_Previews: PreviewProvider {
    static var previews: some View {
        SettingPageView()
    }
}
