import SwiftUI
import Combine
import Foundation

struct PickerView: View {
    
    @ObservedObject var userSettings = UserSettings()
    
    var soundsArray: [SoundsArray] = [
        SoundsArray(soundName: "Default Notification Sound"),
        SoundsArray(soundName: "Bicycle Bell"),
        SoundsArray(soundName: "Bell - Store door"),
        SoundsArray(soundName: "Cookoo"),
        SoundsArray(soundName: "Tower bell")
    ]
    
    var body: some View {
        Section {
            Picker("Notification sound", selection: $userSettings.soundIndex) {
                ForEach(0 ..< self.soundsArray.count, id: \.self) { index in
                    selectSoundView(array: self.soundsArray, index: index)
                }
            }
        }
    }
}

struct selectSoundView: View {
    
    var array: [SoundsArray]
    var index: Int
    
    init(array: [SoundsArray], index: Int) {
        self.array = array
        self.index = index
    }
    
    var body: some View {
        Text(self.array[index].soundName).tag(index)
        
    }
}

struct PickerView_Previews: PreviewProvider {
    static var previews: some View {
        PickerView()
    }
}