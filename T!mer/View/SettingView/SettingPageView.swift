import SwiftUI
import Combine
import StoreKit

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
    
    var body: some View {
        List {
            Section(header: Text("About sound"), footer: Text("If you want to change notification sound, please set the sound before starting timer.")) {

                PickerView()
            }

            Section(header: Text("About purchase")) {
                Button("Remove Ads") {
                    self.userSettings.isUserPurchased.toggle()
                }
                Button(action: {

                    print("Restore In-app Purchase")
                    StoreObserver.shared.restore()
                }) {
                    Text("Restore in-app purchase")
                        .foregroundColor(Color.red)
                }

            }

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
