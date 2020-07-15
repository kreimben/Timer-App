import UIKit
import CoreData

@objc(TimerEntities)
class TimerEntities: NSManagedObject {

    private static let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

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

        if self.context.hasChanges {

            do {

                try self.context.save()

            } catch let error {

                print(error)
            }
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
