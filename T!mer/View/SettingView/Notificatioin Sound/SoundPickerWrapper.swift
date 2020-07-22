import SwiftUI

struct SoundPickerWrapper: View {
    var body: some View {
        SoundPicker()
        .navigationBarTitle(Text("Notification Sound"))
    }
}

struct SoundPickerWrapper_Previews: PreviewProvider {
    static var previews: some View {
        SoundPickerWrapper()
    }
}

//
//  SoundPickerWrapper.swift
//  T!mer
//
//  Created by Aksidion Kreimben on 7/22/20.
//  Copyright © 2020 Aksidion Kreimben. All rights reserved.
//
