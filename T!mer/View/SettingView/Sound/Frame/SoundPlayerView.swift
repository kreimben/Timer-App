import SwiftUI
import AVFoundation

struct SoundPlayerView: View {
    
    @State var soundsArray: [SoundsArray] = [
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
        
        List {
            
            ForEach(0 ..< soundsArray.count, id: \.self) { index in
                
                SelectSoundView(array: self.soundsArray, index: index)
                    .onTapGesture {
                        
                        print("+=========================+")
                        print("Play sound at: \(index)")
                        
                        var name = ""
                        var player = AVAudioPlayer()
                        
                        switch index {
                            
                        case 0:
                            name = "Default Bell"
                        case 1:
                            name = "Bell store door"
                        case 2:
                            name = "Cookoo"
                        case 3:
                            name = "Tower bell"
                        case 4:
                            name = "bicycle"
                        case 5:
                            name = "ghost"
                        case 6:
                            name = "home-bell"
                        case 7:
                            name = "elevator"
                        case 8:
                            name = "single"
                        case 9:
                            name = "zen"
                            
                        default:
                            break
                        } // Set sound's path using index.
                        
                        let pathURL = Bundle.main.url(forResource: name, withExtension: nil)
                        
                        if let url = pathURL {
                            
                            print("Sound Name: \(name)")
                            print("Sound URL: \(url)")

                            do {

                                player = try AVAudioPlayer(contentsOf: url)
                                player.play()

                            } catch let error {

                                print("Can't load sound file: \(error.localizedDescription)")
                            }
                        }
                }
            }
        }
        .listStyle(GroupedListStyle())
    }
}

struct SoundPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        SoundPlayerView()
    }
}

//
//  SoundPlayerView.swift
//  T!mer
//
//  Created by Aksidion Kreimben on 5/4/20.
//  Copyright © 2020 Aksidion Kreimben. All rights reserved.
//
