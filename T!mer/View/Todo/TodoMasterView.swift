import SwiftUI

struct TodoMasterView: View {
    
    @ObservedObject var userSettings = UserSettings()
    
    var body: some View {
        
        VStack {
            Group {
                
                // TODO: Fix this to CoreData related
                if TimerSession.shared.timers.count > 0 {
                    
                    TodoView()
                } else {
                    
                    TodoEmptyView()
                }
            }.onAppear {
                
                print("timer session count: \(TimerSession.shared.timers.count)")
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
