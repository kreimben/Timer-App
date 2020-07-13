//
//  TimerEntities+CoreDataProperties.swift
//  
//
//  Created by Aksidion Kreimben on 7/13/20.
//
//

import Foundation
import CoreData


extension TimerEntities {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TimerEntities> {
        return NSFetchRequest<TimerEntities>(entityName: "TimerEntities")
    }

    @NSManaged public var memo: String?
    @NSManaged public var notificationTime: Date?
    @NSManaged public var title: String?

}
