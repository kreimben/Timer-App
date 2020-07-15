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
            
            HStack {
                
                TextField("Set your todo's title!", text: self.$title)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.leading)
                
                Button(action: {
                    
                    let newItem = TimerEntities(context: self.managedObjectContext)
                    let date = UserDefaults(suiteName: "group.com.KreimbenPro.Timer")?.value(forKey: "notificationTime") as! Date
                    
                    newItem.notificationTime = date
                    newItem.title = self.title
                    
                    TimerEntities.saveContext()
                    
                    /// @Reset textfield's string value
                    self.title = ""
                    /// @END
                    
                    /// @When T!mer is added successfully
                    let gen = UINotificationFeedbackGenerator()
                    gen.prepare()
                    gen.notificationOccurred(.success)
                    /// @END
                }) {
                    
                    /// @Add button image
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(Color.green.opacity(1))
                    /// @END
                    
                }.padding(.trailing)
            }
            
            if timerEntities.count > 0 {
                
                List {
                    
                    ForEach(timerEntities, id: \.self) { data in
                        
                        TodoContentView(
                            title: data.title!,
                            date: data.notificationTime!,
                            memo: data.memo
                        )
                    }
                    .onDelete { indexSet in
                        
                        for index in indexSet {
                            
                            self.managedObjectContext.delete(self.timerEntities[index])
                            TimerEntities.saveContext()
                        }
                    }
                    
//                    Button(action: {
//
//                        let length: Int = self.timerEntities.count
//                        
//                        for index in 0 ..< length {
//
//                            self.managedObjectContext.delete(self.timerEntities[index])
//                        }
//
//                        TimerEntities.saveContext()
//                    }) {
//
//                        Text("Delete Everythings").foregroundColor(.blue)
//                    }
                }
            } else {
                
                TodoEmptyView()
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
