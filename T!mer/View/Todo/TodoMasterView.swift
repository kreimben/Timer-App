import SwiftUI
import CoreData

import CommonT_mer

struct TodoMasterView: View {
    
    @ObservedObject var userSettings = CTUserSettings()
    
    var body: some View {
        
        VStack {
            Group {
                
                TodoView()
            }
        }
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
