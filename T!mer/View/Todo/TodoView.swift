import SwiftUI

struct TodoView: View {
    var body: some View {
        
        VStack {
            
            Text("To-do list")
                .font(.system(size: 32, design: .rounded))
            
            List {
                
                Text("Todo View Test")
            }
        }
    }
}

struct TodoView_Previews: PreviewProvider {
    static var previews: some View {
        TodoView()
    }
}

//
//  TodoView.swift
//  T!mer
//
//  Created by Aksidion Kreimben on 5/28/20.
//  Copyright © 2020 Aksidion Kreimben. All rights reserved.
//
