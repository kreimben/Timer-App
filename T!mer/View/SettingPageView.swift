import SwiftUI
import Foundation
import Combine

@propertyWrapper
struct UserDefault<T> {
    
    let key: String
    let value: T
    
    var wrappedValue: T {
        get {
            return UserDefaults.standard.object(forKey: key) as? T ?? value
        }
        set {
            return UserDefaults.standard.set(newValue, forKey: key)
        }
    }
}

struct SettingPageView: View {
    
    var soundsArray = ["Default Bell", "Others", "Others 2", "Others 3", "Others 4", "Others 5"]
    
    @ObservedObject var userSettings = UserSettings()
    
    var body: some View {
        List {
            Section {
                Toggle(isOn: $userSettings.alertSoundIsOn) {
                    Text("Alert when timer is done")
                }
                
                Picker(selection: $userSettings.soundIndex, label: Text("Sound")) {
                    ForEach(0 ..< soundsArray.count) { index in
                        Text(self.soundsArray[index]).tag(index)
                    }
                }
                
                Text("Hello World")
            }
            .navigationBarTitle(Text("Settings"), displayMode: .inline)
        }
        .listStyle(GroupedListStyle())
    }
}

final class UserSettings: ObservableObject {
    
    let objectWillChange = PassthroughSubject<Void, Never>()
    
    @UserDefault(key: "alertSoundIsOn", value: true)
    var alertSoundIsOn: Bool {
        willSet {
            objectWillChange.send()
        }
    }
    
    @UserDefault(key: "soundIndex", value: 0)
    var soundIndex: Int {
        willSet {
            objectWillChange.send()
        }
    }
}

//MARK:- SettingPageView_Previews

struct SettingPageView_Previews: PreviewProvider {
    static var previews: some View {
        SettingPageView()
    }
}
