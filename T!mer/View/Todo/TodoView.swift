import SwiftUI
import CoreData

import CommonT_mer

struct TodoView: View {
    
    /// @ObservedObject variables
    @ObservedObject var mainController = CTMainController()
    @ObservedObject var userSettings = CTUserSettings()
    /// @END
    
    /// @CoreData related variables
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(fetchRequest: TimerEntities.getAllTimerEntities())
    var timerEntities: FetchedResults<TimerEntities>
    /// @END
    
    /// @TextField related variables
    @State var title: String = ""
    /// @END
    
    var body: some View {
        ZStack {
            
            VStack {
                
                HStack {
                    
                    TextField(self.mainController.isTimerRunning() ? "Set your todo's title!" : "Start T!mer first!", text: self.$title)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.leading)
                    
                    Button(action: {
                        
                        if self.mainController.isTimerRunning() {
                            
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
                        } else {
                            
                            /// @When T!mer is not running
                            let gen = UINotificationFeedbackGenerator()
                            gen.prepare()
                            gen.notificationOccurred(.error)
                            /// @END
                        }
                    }) {
                        
                        /// @Add button image
                        Image(systemName: self.mainController.isTimerRunning() ? "plus.circle.fill" : "xmark.circle.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(self.mainController.isTimerRunning() ? Color.green : Color.red)
                        /// @END
                        
                    }.padding(.trailing)
                } // TextField and Button
                
                if timerEntities.count > 0 {
                    
                    List {
                        
                        ForEach(timerEntities, id: \.self) { entity in
                            
                            NavigationLink(destination: TodoContentView(entity: entity)) {
                                
                                TodoCell(entity: entity)
                            }
                        }
                        .onDelete { indexSet in
                            
                            for index in indexSet {
                                
                                self.managedObjectContext.delete(self.timerEntities[index])
                                TimerEntities.saveContext()
                            }
                        }
                        
                        Button(action: {
                            
                            let length: Int = self.timerEntities.count
                            
                            for index in 0 ..< length {
                                
                                self.managedObjectContext.delete(self.timerEntities[index])
                            }
                            
                            TimerEntities.saveContext()
                            
                            /// @When T!mer is added successfully
                            let gen = UINotificationFeedbackGenerator()
                            gen.prepare()
                            gen.notificationOccurred(.success)
                            /// @END
                        }) {
                            
                            Text("Delete Everything").foregroundColor(.blue)
                        }
                    }
                } else {
                    
                    TodoEmptyView()
                }
            }
        }
        .navigationBarTitle(Text("To-do"), displayMode: .large)
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
