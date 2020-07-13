import SwiftUI
import CoreData

struct TodoMasterView: View {
    
    @ObservedObject var userSettings = UserSettings()
    
    /// @CoreData related
    @FetchRequest(
        entity: TimerEntities.entity(),
        sortDescriptors: [NSSortDescriptor(key: "notificationTime", ascending: true)]
    ) var timerEntities: FetchedResults<TimerEntities>
    /// @END
    
    var body: some View {
        
        VStack {
            Group {
                
                if true { //TimerSession.shared.timers.count > 0 {
                    
                    TodoView()
                } else {
                    
                    TodoEmptyView()
                }
            }.onAppear {
                
//                NSLog("FetchedResults count: \(self.timerEntities.count)")
            }
        } // VStack
        .navigationBarTitle(Text("To-do list"))
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
