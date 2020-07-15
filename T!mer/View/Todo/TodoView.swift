import SwiftUI
import CoreData

struct TodoView: View {
    
    /// @CoreData related variables
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(fetchRequest: TimerEntities.getAllTimerEntities())
    var timerEntities: FetchedResults<TimerEntities>
    /// @END
    
    /// @TextField related variables
    @State var title: String = ""
    /// @END
    
    var body: some View {
        
        VStack {
            
            Text("To-do list")
                .font(.system(size: 32, design: .rounded))
                .padding()
            
            TextField("Set your todo's title!", text: self.$title)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            HStack {
                
                Spacer()
                
                Button(action: {
                    
                    let newItem = TimerEntities(context: self.managedObjectContext)
                    let date = UserDefaults(suiteName: "group.com.KreimbenPro.Timer")?.value(forKey: "notificationTime") as! Date
                    
                    newItem.notificationTime = date
                    newItem.title = self.title
                    
                    TimerEntities.saveContext()
                    
                    self.title = ""
                }) {
                    
                    Text("Add todo")
                }.padding()
            }
            
            List {
                
                ForEach(timerEntities, id: \.self) { data in
                    
                    Text("\(data.title!) \(data.memo ?? ""), date: \(data.notificationTime!)")
                }
                .onDelete { indexSet in
                    
                    for index in indexSet {
                        
                        self.managedObjectContext.delete(self.timerEntities[index])
                        TimerEntities.saveContext()
                    }
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
