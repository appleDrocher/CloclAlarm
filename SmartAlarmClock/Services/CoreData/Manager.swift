import Foundation
import CoreData

protocol ManagerServiceProtocol {
    var clockAlarm: [ClockAlarm] { get }
    var didUpdate: () -> Void { get set }
    func saveContext()
    func fetchAllNotes()
    func addNewNote()
}

final class CoreManager: ManagerServiceProtocol {
  
    static let shared = CoreManager()
    
    lazy var clockAlarm = [ClockAlarm]() {
        didSet {
            didUpdate()
        }
    }
    
    var didUpdate: () -> Void = {}
    
    private init() {
        fetchAllNotes()
    }
    
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "_5minApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func fetchAllNotes(){
        let req = ClockAlarm.fetchRequest()
        if let notes = try? persistentContainer.viewContext.fetch(req) {
            self.clockAlarm = notes
        }
    }
    
    func addNewNote(){
        let note = ClockAlarm(context: persistentContainer.viewContext)
        
        saveContext()
        fetchAllNotes()
    }
}
