import SwiftUI

struct SelectSoundView: View {
    
//    @Binding var selectedBool: Bool
    
    var array: [SoundsArray]
    var index: Int
    
    init(array: [SoundsArray], index: Int) {
        self.array = array
        self.index = index
    }
    
    var body: some View {
        HStack {
            
            Text(self.array[index].soundName).tag(index)
            
//            Spacer()
            
//            EditButton()
            
//            SelectCircleView(selected: self.$selectedBool)
//                .onTapGesture(count: 1) {
//
//                    self.selectedBool.toggle()
//
//                    print("Button tapped in SelectSoundView.swift: \(self.selectedBool)")
//                    print("Index: \(self.index)")
//            }
//                .frame(width: 32)
            
        }
    }
}

//struct SelectSoundView_Previews: PreviewProvider {
//    static var previews: some View {
//        SelectSoundView(array: [
//            SoundsArray(soundName: "Default Sound"),
//            SoundsArray(soundName: "Bicycle Bell"),
//            SoundsArray(soundName: "Bell - Store door"),
//            SoundsArray(soundName: "Cookoo"),
//            SoundsArray(soundName: "Tower bell"),
//
//            SoundsArray(soundName: "Bicycle Bell 2"),
//            SoundsArray(soundName: "Ghost"),
//            SoundsArray(soundName: "House Bell"),
//            SoundsArray(soundName: "Elevator"),
//            SoundsArray(soundName: "Single"),
//            SoundsArray(soundName: "Zen")
//        ], index: 0, selectedBool: .constant(true))
//    }
//}

//
//  SelectSoundView.swift
//  T!mer
//
//  Created by Aksidion Kreimben on 5/4/20.
//  Copyright © 2020 Aksidion Kreimben. All rights reserved.
//
