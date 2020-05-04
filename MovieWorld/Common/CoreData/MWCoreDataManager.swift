//
//  MWCoreData.swift
//  MovieWorld
//
//  Created by Admin on 19/03/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class MWCoreDataManager {
    
    // MARK: - Variables
    
    static let sh: MWCoreDataManager = MWCoreDataManager()
    
    let documentsDirectory: URL
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Unable to load persistent stores: \(error)")
            }
        }
        return container
    }()
    
    // MARK: - Initialization
    
    private init() {
        let docUrls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        if docUrls.count > 0 {
            self.documentsDirectory = docUrls[0]
        } else {
            fatalError("documentDirectory not found")
        }
    }
    
    // MARK: - Core Data Saving support
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error\(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func saveGenre(name: String, id: Int16) -> GenreModel? {
        let managedContext = persistentContainer.viewContext
        guard let entity = NSEntityDescription.entity(forEntityName: "GenreModel", in: managedContext) else { return nil }
        let genre = NSManagedObject(entity: entity, insertInto: managedContext)
        genre.setValue(name, forKey: "name")
        genre.setValue(id, forKey: "id")
        
        do {
            try managedContext.save()
            return genre as? GenreModel
        } catch let error as NSError {
            fatalError("Could not save. \(error), \(error.userInfo)")
            return nil
        }
    }
    
    func update(name: String, id: Int16, genre: GenreModel) {
        let context = persistentContainer.viewContext
        genre.setValue(name, forKey: "name")
        genre.setValue(id, forKey: "id")
        do {
            try context.save()
            print("saved!")
        } catch let error as NSError {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
    func fetchAllGenres() -> [GenreModel]? {
      let managedContext = persistentContainer.viewContext

      let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "GenreModel")

      do {
        let genres = try managedContext.fetch(fetchRequest)
        return genres as? [GenreModel]
      } catch let error as NSError {
        print("Could not fetch. \(error), \(error.userInfo)")
        return nil
      }
    }
    
    func isEntityAttributeExist(id: Int, entityName: String) -> Bool {
        let managedContext = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        
        let res = try? managedContext.fetch(fetchRequest)
        return (res?.count ?? 0) > 0
    }
    
    func deleteAllData(_ entity: String) {
        let managedContext = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let results = try managedContext.fetch(fetchRequest)
            for object in results {
                guard let objectData = object as? NSManagedObject else {continue}
                managedContext.delete(objectData)
            }
            try managedContext.save()
        } catch let error {
            print("Detele all data in \(entity) error :", error)
        }
    }
    
    func entityIsEmpty(entity: String) -> Bool {
        let managedContext = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entity)
        var results: [NSManagedObject] = []
        fetchRequest.returnsObjectsAsFaults = false
        do {
            results = try managedContext.fetch(fetchRequest)
        } catch {
            print("error executing fetch request \(error.localizedDescription)")
        }
        return results.count == 0
    }
}
