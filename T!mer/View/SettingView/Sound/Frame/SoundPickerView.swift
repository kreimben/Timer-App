import SwiftUI
import Combine
import AVFoundation

import CommonT_mer

struct SoundPickerView: View {
    
    @ObservedObject var userSettings = CTUserSettings()
    
    @State var soundsArray: [NotificationSound] = [
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
            Picker("Sound", selection: $userSettings.soundIndex.onChange(makeSound)) {
                ForEach(0 ..< self.soundsArray.count, id: \.self) { index in
                    SelectSoundView(array: self.soundsArray, index: index)
                }
            
            }
        }
    }
    
    func makeSound(_ number: Int) {
        
        print("Selected: \(number)")
        
        var path: String?
        
        switch number {
        case 0:
            AudioServicesPlaySystemSound(1050)
            return
            
        case 1:
            path = Bundle.main.path(forResource: "Default Bell", ofType: nil)
            
        case 2:
            path = Bundle.main.path(forResource: "Bell store door", ofType: nil)
            
        case 3:
            path = Bundle.main.path(forResource: "Cookoo", ofType: nil)
            
        case 4:
            path = Bundle.main.path(forResource: "Tower bell", ofType: nil)
            
        case 5:
            path = Bundle.main.path(forResource: "bicycle", ofType: nil)
            
        case 6:
            path = Bundle.main.path(forResource: "ghost", ofType: nil)
            
        case 7:
            path = Bundle.main.path(forResource: "home-bell", ofType: nil)
            
        case 8:
            path = Bundle.main.path(forResource: "elevator", ofType: nil)
            
        case 9:
            path = Bundle.main.path(forResource: "single", ofType: nil)
            
        case 10:
            path = Bundle.main.path(forResource: "zen", ofType: nil)
            
        default:
            NSLog("Error occured in fixing UNNotificationSound.")
            
        }
        
        guard let comfirmedPath = path else { return }
        
        let url = URL(fileURLWithPath: comfirmedPath)
        
        DispatchQueue.main.async {
            
            do {
                
                let player = try AVAudioPlayer(contentsOf: url)
                
                if player.prepareToPlay() {
                    
                    print("Prepared to play!")
                    
                    player.play()
                    print("Played!")
                }
                
            } catch let error {
                
                NSLog("Error while playing notification sound: \(error.localizedDescription)")
            }
        }
    }
}

struct PickerView_Previews: PreviewProvider {
    static var previews: some View {
        SoundPickerView()
    }
}
