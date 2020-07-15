import SwiftUI
import CoreData

struct TodoMasterView: View {
    
    @ObservedObject var userSettings = UserSettings()
    
    var body: some View {
        
        VStack {
            Group {
                
                TodoView()
            }.onAppear {
                
            }
        } // VStack
    }
}

struct TodoMasterView_Previews: PreviewProvider {
    static var previews: some View {
        TodoMasterView()
    }
}

//
//  TodoMasterView.swift
//  T!mer
//
//  Created by Aksidion Kreimben on 5/26/20.
//  Copyright © 2020 Aksidion Kreimben. All rights reserved.
//
