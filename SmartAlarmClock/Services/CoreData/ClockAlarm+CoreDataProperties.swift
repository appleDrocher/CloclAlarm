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
    @NSManaged public var scanData: String?
}

extension ClockAlarm : Identifiable {
    
    func updateNote(listName: String, Emoji: String, scanData: String) {
       
        self.emoji = Emoji
        self.listName = listName
        self.scanData = scanData
        
        try? managedObjectContext?.save()
    }
    
    func deleteNote(){
        managedObjectContext?.delete(self)
        try? managedObjectContext?.save()
    }
}
