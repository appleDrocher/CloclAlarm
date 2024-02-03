import Foundation
import CoreData


extension ClockAlarm {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ClockAlarm> {
        return NSFetchRequest<ClockAlarm>(entityName: "ClockAlarm")
    }
}

extension ClockAlarm : Identifiable {

}
