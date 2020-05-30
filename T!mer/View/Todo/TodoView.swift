import SwiftUI
import CoreData

struct TodoView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(
        entity: TimerEntities.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \TimerEntities.notificationTime, ascending: true)]
    )
    var results: FetchedResults<TimerEntities>
    
    var body: some View {
        
        VStack {
            
            Text("To-do list")
                .font(.system(size: 32, design: .rounded))
                .padding()
            
            List {
                
                ForEach(results, id: \.self) { data in
                    
                    Text("\(data.text!): \(data.memo ?? ""), date: \(data.notificationTime!)")
                }
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
