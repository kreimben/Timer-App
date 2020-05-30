import Foundation
import CoreData

class TimerElement {
    
    /// @Variables
    var title:String
    var memo: String?
    var notificationTime: Date
    var context: NSManagedObjectContext
    /// @END
    
    init(title:String, memo: String? = nil, with notificationTime: Date, context: NSManagedObjectContext) {
        
        self.title = title
        self.memo = memo
        self.notificationTime = notificationTime
        self.context = context
    }
    
    func save() {
        
        if self.context.hasChanged {
            
            do {
                
                try self.context.save()
            } catch let error {
                
                fatalError("Error while save CoreData Object: \(error)")
            }
        }
    }
}

//
//  TimerElement.swift
//  T!mer
//
//  Created by Aksidion Kreimben on 5/28/20.
//  Copyright © 2020 Aksidion Kreimben. All rights reserved.
//
