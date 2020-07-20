import SwiftUI
import Combine

import CommonT_mer

struct SoundPickerView: View {
    
    @ObservedObject var userSettings = CTUserSettings()
    
    var soundsArray: [NotificationSound] = [
        NotificationSound(soundName: "Default Sound"),
        NotificationSound(soundName: "Bicycle"),
        NotificationSound(soundName: "Store"),
        NotificationSound(soundName: "Cookoo"),
        NotificationSound(soundName: "Tower"),
        
        NotificationSound(soundName: "Bicycle 2"),
        NotificationSound(soundName: "Ghost"),
        NotificationSound(soundName: "House"),
        NotificationSound(soundName: "Elevator"),
        NotificationSound(soundName: "Single"),
        NotificationSound(soundName: "Zen")
    ]
    
    var body: some View {
        Section {
            Picker("Sound", selection: $userSettings.soundIndex) {
                ForEach(0 ..< self.soundsArray.count, id: \.self) { index in
                    SelectSoundView(array: self.soundsArray, index: index)
                }
                .onReceive([self.userSettings.soundIndex].publisher.first()) { (value) in

                    print("\n\nvalue in picker view: \(value)")
                    print("type of: \(type(of: value))\n\n")
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
