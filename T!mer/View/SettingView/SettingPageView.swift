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
        List {
            
            Section(header: Text("Preferences..."), footer: Text("If you want to change notification sound, please set the sound before starting timer.")) {
                
                SoundPickerView()
                ColorPickerView()
            }
            
            Section(header: Text("General")) {
                HStack {
                    Text("Version")
                    Spacer()
                    Text(self.appVersion)
                }
                
                NavigationLink(destination: HowToUseThisApp()) {
                    
                    Text("Some tips")
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
                
                NavigationLink(destination: DebugMenuView()) {
                    Text("Debug Menu").foregroundColor(.red)
                }
                
                NavigationLink(destination: SoundPicker()) {
                    
                    Text("SoundPicker").foregroundColor(.red)
                }
            }
            #endif
        }
        .listStyle(GroupedListStyle())
    }
}

// MARK: - SettingPageView_Previews

struct SettingPageView_Previews: PreviewProvider {
    static var previews: some View {
        SettingPageView()
    }
}
