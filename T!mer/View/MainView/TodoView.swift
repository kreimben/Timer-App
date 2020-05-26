import SwiftUI

struct TodoView: View {
    
    @ObservedObject var userSettings = UserSettings()
    
    var body: some View {
        
        VStack {
            Group {
                
                if Date().distance(to: UserDefaults(suiteName: "group.com.KreimbenPro.Timer")?.value(forKey: "notificationTime") as? Date ?? Date()) > 0.1 {
                    
                    Text("You are running T!mer")
                } else {
                    
                    Text("There is no T!mer")
                }
            }
            .onAppear {
                
                print("notificationTime is grater than now: \(Date().distance(to: UserDefaults(suiteName: "group.com.KreimbenPro.Timer")?.value(forKey: "notificationTime") as? Date ?? Date()))")
            }
            
            Text("\(Date().distance(to: UserDefaults(suiteName: "group.com.KreimbenPro.Timer")?.value(forKey: "notificationTime") as? Date ?? Date()))")
        } // VStack
        .navigationBarTitle(Text("To-do list"))
    }
}

// let checkNil = UserDefaults(suiteName: "group.com.KreimbenPro.Timer")?.value(forKey: "notificationTime")

struct TodoView_Previews: PreviewProvider {
    static var previews: some View {
        TodoView()
    }
}

//
//  TodoView.swift
//  T!mer
//
//  Created by Aksidion Kreimben on 5/26/20.
//  Copyright © 2020 Aksidion Kreimben. All rights reserved.
//
