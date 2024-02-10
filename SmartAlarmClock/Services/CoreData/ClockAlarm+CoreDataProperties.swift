//
//  ClockAlarm+CoreDataProperties.swift
//  SmartAlarmClock
//
//  Created by Урутян Левон on 10.02.2024.
//
//

import Foundation
import CoreData


extension ClockAlarm {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ClockAlarm> {
        return NSFetchRequest<ClockAlarm>(entityName: "ClockAlarm")
    }

    @NSManaged public var listName: String?
    @NSManaged public var emoji: String?

}
