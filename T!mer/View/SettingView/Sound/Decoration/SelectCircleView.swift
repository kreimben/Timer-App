import SwiftUI

struct SelectCircleView: View {
    
    @Binding var selected: Bool
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        
        GeometryReader { geo in
            
            ZStack {
                
                Circle()
                    .fill(Color.yellow)
                    .frame(width: geo.size.width * 1)
                
                Circle()
                    .fill(self.colorScheme == .dark ? Color.black : Color.white)
                    .frame(width: geo.size.width * 0.75)
                
                Circle()
                    .fill(self.selected ? Color.yellow : Color.white.opacity(0))
                    .frame(width: geo.size.width * 0.5)
            }
        }
    }
}

struct SelectCircleView_Previews: PreviewProvider {
    
    static var previews: some View {
        SelectCircleView(selected: .constant(true))
    }
}

//
//  SelectCircleView.swift
//  T!mer
//
//  Created by Aksidion Kreimben on 5/4/20.
//  Copyright © 2020 Aksidion Kreimben. All rights reserved.
//
