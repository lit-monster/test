//
//  Data.swift
//  test
//
//  Created by Youmi Nagase on 2021/01/20.
//
// 09eda2a6dbac578eb1ec34c2a8536d1b46f6a993

import CoreData

class DataManager {

    static let shared: DataManager = DataManager()
    
    private var persistentContainer: NSPersistentContainer!

    init() {

        persistentContainer = NSPersistentContainer(name: "Data")
        persistentContainer.loadPersistentStores { (description, error) in

            if let error = error {
                fatalError("Failed to load Core Data stack: \(error)")
            }

            print(description)
        }
    }

    func create<T: NSManagedObject>() -> T {

        let context = persistentContainer.viewContext
        let object = NSEntityDescription.insertNewObject(forEntityName: String(describing: T.self), into: context) as! T
        return object
    }

    func saveContext() {

        let context = persistentContainer.viewContext

        do {

            try context.save()
        } catch {

            print("Failed save context: \(error)")
        }
    }

    func getFetchedResultController<T: NSManagedObject>(with descriptor: [String] = []) -> NSFetchedResultsController<T> {

        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<T>(entityName: String(describing: T.self))
        fetchRequest.sortDescriptors = descriptor.map { NSSortDescriptor(key: $0, ascending: true) }
        return NSFetchedResultsController<T>(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
    }
    
}
