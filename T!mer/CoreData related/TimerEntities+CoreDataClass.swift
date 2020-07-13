import Foundation
import CoreData


public class TimerEntities: NSManagedObject {

    static func getFetchRequest() -> NSFetchRequest<TimerEntities> {
        
        let request: NSFetchRequest<TimerEntities> = TimerEntities.fetchRequest()
        let sortDescriptors = [
            NSSortDescriptor(key: "notificationTime", ascending: true)
        ]
        
        request.sortDescriptors = sortDescriptors
        
        return request
    }
}

//
//  TimerEntities+CoreDataClass.swift
//
//
//  Created by Aksidion Kreimben on 5/29/20.
//
//
