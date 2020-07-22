import SwiftUI

import CommonT_mer

struct TodoContentView: View {
    
    @ObservedObject var userSettings = CTUserSettings()
    
    @State var entity: FetchedResults<TimerEntities>.Element
    
    @State private var isEditing: Bool = false
    @State private var tfValue: String = ""
    
    var convertedDate: String {
        
        let format = DateFormatter()
        format.timeStyle = .short
        format.dateStyle = .medium
        
        return format.string(from: self.entity.notificationTime!)
    }
    
    var body: some View {
        
        VStack {
            
            HStack {
                
                Text("It ends:")
                
                Spacer()
                
                if self.entity.notificationTime!.distance(to: Date()) > 0 {
                    
                    Text(String(describing: self.convertedDate))
                        .foregroundColor(.red)
                } else {
                    
                    Text(String(describing: self.convertedDate))
                }
            }.padding([.leading, .trailing])
            
            Toggle("Done:", isOn: self.$entity.isChecked).padding([.leading, .trailing])
            
            HStack {
                
                Text("Memo:")
                
                Spacer()
                
                if self.isEditing {
                    
                    TextField("memo", text: self.$tfValue, onCommit: {
                        
                        self.entity.memo = self.tfValue
                        
                        TimerEntities.saveContext()
                        
                        self.isEditing.toggle()
                    })
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                } else {
                    
                    Button(action: {
                        
                        self.isEditing.toggle()
                        
                        guard let memo = self.entity.memo else { return }
                        
                        self.tfValue = memo
                    }) {
                        
                        if !(self.entity.memo?.isEmpty ?? true) {
                            
                            Text(self.entity.memo!).foregroundColor(.black)
                        } else {
                            
                            Text("There is no memo.\nYou can set memo to this task :)")
                        }
                    }
                }
            } // HStack
                .padding([.leading, .trailing])
        }
        .navigationBarTitle(Text(String(describing: self.entity.title!)), displayMode: .large)
    }
}

//struct TodoContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        TodoContentView()
//    }
//}

//
//  TodoContentView.swift
//  T!mer
//
//  Created by Aksidion Kreimben on 7/16/20.
//  Copyright © 2020 Aksidion Kreimben. All rights reserved.
//
