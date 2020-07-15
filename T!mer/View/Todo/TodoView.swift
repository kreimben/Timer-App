import SwiftUI
import CoreData

struct TodoView: View {
    
    /// @CoreData related
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(fetchRequest: TimerEntities.getAllTimerEntities())
    var timerEntities: FetchedResults<TimerEntities>
    /// @END
    
    var body: some View {
        
        VStack {
            
            Text("To-do list")
                .font(.system(size: 32, design: .rounded))
                .padding()
            
            HStack {
                
                Spacer()
                
                Button(action: {
                    
                    let newItem = TimerEntities(context: self.managedObjectContext)
                    let date = UserDefaults(suiteName: "group.com.KreimbenPro.Timer")?.value(forKey: "notificationTime")
                    
                    NSLog(date as! String)
                    
                    newItem.notificationTime = date as! Date
                    newItem.title = "New Todo"
                    
                    do {
                    
                        try self.managedObjectContext.save()
                        
                    } catch let error {
                        
                        NSLog(error.localizedDescription)
                    }
                    
                }) {
                    
                    Text("Add todo")
                }
            }
            
            List {
                
                ForEach(timerEntities, id: \.self) { data in
                    
                    Text("\(data.title!): \(data.memo ?? ""), date: \(data.notificationTime!)")
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
