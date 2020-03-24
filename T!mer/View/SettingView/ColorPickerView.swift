import SwiftUI

struct ColorPickerView: View {
    
    @ObservedObject var userSettings = UserSettings()
    
    var body: some View {
        Picker(selection: self.userSettings.colorIndex, label: Text("Color")) {
            ForEach(0 ..< Colors.allCases.count, id: \.self) { index in
                ColorPickerCellView(index: index)
            }
        }
    }
}

fileprivate struct ColorPickerCellView: View {
    
    @State var index: Int
    
    var body: some View {
        HStack {
            Text(String(ColorScheme().scheme[index]))//.tag($0)
            Spacer()
            ColorScheme.getColor(index).opacity(0.8)
                .frame(width: 17, height: 17)
                .cornerRadius(4)
                .shadow(radius: 10)
                .border(ColorScheme.getColor(index).opacity(0.55), width: 5)
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
