import UIKit
import CoreData

@objc(TimerEntities)
class TimerEntities: NSManagedObject {

    /// Functions which returns fetch request.
    /// - Returns: NSFetchRequest<TimerEntities>
    static func getAllTimerEntities() -> NSFetchRequest<TimerEntities> {
        
        let request: NSFetchRequest<TimerEntities> = TimerEntities.fetchRequest()
        let sorts = [
            NSSortDescriptor(key: "notificationTime", ascending: true)
        ]
        
        request.sortDescriptors = sorts
        
        return request
    }
    
    /// Save CoreData datas through AppDelegate's viewContext
    static func saveContext() {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do {
            
            try context.save()
            
        } catch let error {
            
            print(error)
        }
    }
}

//
//  TimerEntities.swift
//  T!mer
//
//  Created by Aksidion Kreimben on 7/15/20.
//  Copyright © 2020 Aksidion Kreimben. All rights reserved.
//
