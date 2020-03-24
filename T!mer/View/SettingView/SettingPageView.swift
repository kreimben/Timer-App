import SwiftUI
import Combine

import SwiftyStoreKit

struct SoundsArray: Identifiable, Hashable {
    
    let id = UUID()
    let soundName: String
    
    init(soundName: String) {
        
        self.soundName = soundName
    }
}

//MARK:- SettingPageView

struct SettingPageView: View {
    
    @State var showingModal = false
    
    @ObservedObject var userSettings = UserSettings()
    
    @Environment(\.presentationMode) var presentation
    
    @State var productID = "nonConsumable.removeads"  //"com.KreimbenPro.nonConsumable.removeads"
    
    var body: some View {
        List {
            
            Section(header: Text("About sound"), footer: Text("If you want to change notification sound, please set the sound before starting timer.")) {
                
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
                    Text("1.0")
                }
                
                Button(action: {
                    self.showingModal = true
                }) {
                    Text("Visit Kreimben.com")
                }.sheet(isPresented: $showingModal) {
                    SafariView(url: URL(string: "http://www.kreimben.com"))
                }
            }
            .navigationBarTitle(Text("Settings"), displayMode: .inline)
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
