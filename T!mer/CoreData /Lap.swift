//
//  Lap.swift
//  T!mer
//
//  Created by Aksidion Kreimben on 10/6/20.
//  Copyright © 2020 Aksidion Kreimben. All rights reserved.
//

import UIKit
import CoreData

@objcMembers
class Lap: NSManagedObject {
    
    private static let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    static func getAllLaps() -> NSFetchRequest<Lap> {
        
        let requests: NSFetchRequest<Lap> = Lap.fetchRequest()
        let sort = [
            NSSortDescriptor(key: "index", ascending: false)
        ]
        
        requests.sortDescriptors = sort
        
        return requests
    }
    
    static func saveContext() {
        
        if self.context.hasChanges {
            
            do {
                
                try self.context.save()
            } catch {
                
                print(error)
            }
        }
    }
}
