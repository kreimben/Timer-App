import SwiftUI
import Foundation
import Combine

//MARK:- @propertyWrapper "UserDefault<T>

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

//MARK:- SettingPageView

struct SettingPageView: View {
    
    var soundsArray = ["Default Bell", "Others", "Others 2", "Others 3", "Others 4", "Others 5"]
    
    @ObservedObject var userSettings = UserSettings()
    
    var body: some View {
        List {
            Section {
                Toggle(isOn: $userSettings.alertSoundIsOn) {
                    Text("Alert when timer is finish")
                }
                
                Picker(selection: $userSettings.soundIndex, label: Text("Sound")) {
                    ForEach(0 ..< soundsArray.count) { index in
                        HStack {
//                        Image(systemName: "playpause.fill")
                        Text(self.soundsArray[index]).tag(index)
                        }
                    }
                }
            }
            .navigationBarTitle(Text("Settings"), displayMode: .inline)
        }
        .listStyle(GroupedListStyle())
    }
}

//MARK:- UserSettings

final class UserSettings: ObservableObject {
    
    let objectWillChange = PassthroughSubject<Void, Never>()
    
    @UserDefault(key: "alertSoundIsOn", value: true) // Defining firstly
    var alertSoundIsOn: Bool {
        willSet {
            objectWillChange.send() // Save value FOREVER
        }
    }
    
    @UserDefault(key: "soundIndex", value: 0) // Defining firstly
    var soundIndex: Int {
        willSet {
            objectWillChange.send() // Save value FOREVER
        }
    }
    
    @Published var imageBool: Bool
    
    init() {
        self.imageBool = UserDefaults.standard.bool(forKey: "alertSoundIsOn")
    }
}

//MARK:- SettingPageView_Previews

struct SettingPageView_Previews: PreviewProvider {
    static var previews: some View {
        SettingPageView()
    }
}
