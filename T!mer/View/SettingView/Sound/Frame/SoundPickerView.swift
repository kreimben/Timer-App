import SwiftUI
import Combine

struct SoundPickerView: View {
    
    @ObservedObject var userSettings = UserSettings()
    
    var soundsArray: [SoundsArray] = [
        SoundsArray(soundName: "Default Sound"),
        SoundsArray(soundName: "Bicycle"),
        SoundsArray(soundName: "Store"),
        SoundsArray(soundName: "Cookoo"),
        SoundsArray(soundName: "Tower"),
        
        SoundsArray(soundName: "Bicycle 2"),
        SoundsArray(soundName: "Ghost"),
        SoundsArray(soundName: "House"),
        SoundsArray(soundName: "Elevator"),
        SoundsArray(soundName: "Single"),
        SoundsArray(soundName: "Zen")
    ]
    
    var body: some View {
        Section {
            Picker("Sound", selection: $userSettings.soundIndex) {
                ForEach(0 ..< self.soundsArray.count, id: \.self) { index in
                    SelectSoundView(array: self.soundsArray, index: index)
                }
            }
        }
    }
}



struct PickerView_Previews: PreviewProvider {
    static var previews: some View {
        SoundPickerView()
    }
}
