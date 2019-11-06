import SwiftUI
import Foundation
import Combine

struct SoundsArray: Identifiable, Hashable {
    
    let id = UUID()
    let soundName: String
    
    init(soundName: String) {
        
        self.soundName = soundName
    }
}

//MARK:- SettingPageView

struct SettingPageView: View {
    
    @ObservedObject var userSettings = UserSettings()
    
    var body: some View {
        List {
            Section(header: Text("About sound")) {
                Toggle(isOn: $userSettings.alertSoundIsOn) {
                    Text("Alert when timer is finish")
                }
                
                PickerView()
            }
            
            Section(header: Text("About purchase")) {
                Button("Remove Ads") {
                    self.userSettings.isUserPurchased.toggle()
                }
                Button(action: {
                    
                }) {
                    Text("Restore in-app purchase")
                        .foregroundColor(Color.red)
                }
                
            }
            
            Section(header: Text("General")) {
                HStack {
                    Text("Version")
                    Spacer()
                    Text("1.0.0")
                }
                
                NavigationLink(destination: Text("About \"Erlkoenig Soft\"")) {
                    Text("About \"Erlkoenig Soft\"")
                }
                
            }
            .navigationBarTitle(Text("Settings"), displayMode: .inline)
                
            .onAppear() {
                
                if self.userSettings.userDonotCheckedOurAppCannotSupportPerfectBackgroundTask == false &&
                self.userSettings.forCheckFirstAlert == true {
                    self.userSettings.userDonotCheckedOurAppCannotSupportPerfectBackgroundTask = true
                }
            }
                
//            .alert(isPresented: self.$userSettings.userDonotCheckedOurAppCannotSupportPerfectBackgroundTask) {
//
//                Alert(title: Text("Caution") , message: Text("Unfortunately, We can't support background timer feature perfectly due to some kinds of reasons and bugs yet.\nSorry!"), primaryButton: .default(Text("OK")), secondaryButton: .destructive(Text("Don't show again")) {
//                    self.userSettings.userDonotCheckedOurAppCannotSupportPerfectBackgroundTask = false
//                    self.userSettings.forCheckFirstAlert = false
//                    })
//            }
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
