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
    
    static let sh: MWCoreDataManager = MWCoreDataManager()
    
    let documentsDirectory: URL
    
    private init() {
        let docUrls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        if docUrls.count > 0 {
            self.documentsDirectory = docUrls[0]
        } else {
            fatalError("documentDirectory not found")
        }
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Unable to load persistent stores: \(error)")
            }
        }
        return container
    }()
    
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
        let entity = NSEntityDescription.entity(forEntityName: "GenreModel", in: managedContext)!
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
        
        do {
            genre.setValue(name, forKey: "name")
            genre.setValue(id, forKey: "id")
            do {
                try context.save()
                print("saved!")
            } catch let error as NSError  {
                print("Could not save \(error), \(error.userInfo)")
            } catch {
                
            }
        } catch {
            print("Error with request: \(error)")
        }
    }
    
    func delete(genre: GenreModel) {
        let managedContext = persistentContainer.viewContext
        
        do {
            managedContext.delete(genre)
        } catch {
            print(error)
        }
        
        do {
            try managedContext.save()
        } catch {
            print(error)
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
}
