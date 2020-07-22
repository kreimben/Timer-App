import SwiftUI

import CommonT_mer

struct TodoCell: View {
    
    @ObservedObject var userSettings = CTUserSettings()
    
//    @State var title: String
//    @State var date: Date
//    @State var memo: String?
//    @State var isChecked: Bool
    
    @State var entity: FetchedResults<TimerEntities>.Element
    
    var convertedDate: String {
        
        let format = DateFormatter()
        format.timeStyle = .short
        format.dateStyle = .medium
        
        return format.string(from: self.entity.notificationTime!)
    }
    
    var body: some View {
        
        HStack {
            
            VStack(alignment: .leading) {
                
                if self.entity.notificationTime! == UserDefaults(suiteName: "group.com.KreimbenPro.Timer")?.value(forKey: "notificationTime") {
                
                    Text(self.entity.title!).font(.system(size: 24)).foregroundColor(.black)
                } else {
                    
                    Text(self.entity.title!).font(.system(size: 24)).foregroundColor(.red)
                        .onAppear {
                            
                            print("Entity time: \(self.entity.notificationTime!)")
                            print("UserDefaults time: \(self.userSettings.notificationTime)")
                    }
                }
                
                if self.entity.notificationTime!.distance(to: Date()) > 0 { // When date is over now.
                
                    Text(convertedDate).foregroundColor(.red)
                } else { // When date is valid
                    
                    Text(convertedDate).foregroundColor(.gray)
                }
                
                Text(self.entity.memo ?? "").foregroundColor(.gray)
            }
            
            Spacer()
            
            if self.entity.isChecked {
                
                Image(systemName: "checkmark.circle").foregroundColor(CTColorScheme.getColor(self.userSettings.colorIndex))
            } else {
                
                Image(systemName: "circle").foregroundColor(CTColorScheme.getColor(self.userSettings.colorIndex))
            }
        }
    }
}


//struct TodoCell_Previews: PreviewProvider {
//    static var previews: some View {
//        TodoCell()
//    }
//}

//
//  TodoCell.swift
//  T!mer
//
//  Created by Aksidion Kreimben on 7/22/20.
//  Copyright © 2020 Aksidion Kreimben. All rights reserved.
//
