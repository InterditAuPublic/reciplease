//
//  CoreDataStack.swift
//  Reciplease
//
//  Created by Melvin Poutrel on 01/11/2023.
//

import CoreData
import Foundation

open class CoreDataStack {
    // MARK: Public
    // MARK: Properties
    public static let persistentContainerName = "Reciplease"
    public static var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: persistentContainerName)
        container.loadPersistentStores { description, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    public static var mainContext: NSManagedObjectContext = {
        return persistentContainer.viewContext
    }()
    
    // MARK: Methods
    /// Save the context
    func saveContext() -> Bool{
        var isSaved = false
        guard CoreDataStack.mainContext.hasChanges else { return isSaved }
        do {
            try CoreDataStack.mainContext.save()
            isSaved = true
        } catch let error as NSError {
            print("Unable to save context! \(error), \(error.userInfo)")
        }
        return isSaved
    }
    
    public init() {}
}
