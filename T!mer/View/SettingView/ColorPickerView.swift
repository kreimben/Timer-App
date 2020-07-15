import SwiftUI

import CommonT_mer

struct ColorPickerView: View {
    
    @ObservedObject var userSettings = CTUserSettings()
    
    var body: some View {
        Picker(selection: self.$userSettings.colorIndex, label: Text("Color")) {
            ForEach(0 ..< CTColors.allCases.count, id: \.self) { index in
                ColorPickerCellView(index: index)
            }
        }
    }
}

private struct ColorPickerCellView: View {
    
    @State var index: Int
    
    var body: some View {
        HStack {
            Text(String(CTColorScheme().scheme[index]))
            CTColorScheme.getColor(index).opacity(0.8)
                .frame(width: 17, height: 17)
                .cornerRadius(4)
                .shadow(radius: 10)
                .border(CTColorScheme.getColor(index).opacity(0.55), width: 5)
                .cornerRadius(4)
        }
    }
}

struct ColorPickerView_Previews: PreviewProvider {
    static var previews: some View {
        ColorPickerView()
    }
}

//
//  ColorPickerView.swift
//  T!mer
//
//  Created by Aksidion Kreimben on 3/24/20.
//  Copyright © 2020 Aksidion Kreimben. All rights reserved.
//
