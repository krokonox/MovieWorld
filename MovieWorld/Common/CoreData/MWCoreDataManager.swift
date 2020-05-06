//
//  MWCoreData.swift
//  MovieWorld
//
//  Created by Admin on 19/03/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation
import CoreData

enum Entity: String {
    case GenreModel, Configuration
}

class MWCoreDataManager {
    
    // MARK: - Variables
    
    static let sh = MWCoreDataManager()

    lazy var applicationDocumentsDirectory: URL = {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[urls.count-1]
    }()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores { _, error in
            if let error = error {
                print("Unable to load persistent stores: \(error)")
            }
        }
        return container
    }()
    
    // MARK: - Initialization
    
    private init() {}
  
    // MARK: - CoreData Genre support
    
    func saveGenre(genre: Genre) {
        let managedContext = persistentContainer.viewContext
        let genreEntity = GenreModel(context: managedContext)
        genreEntity.id = genre.id
        genreEntity.name = genre.name
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func update(genre: Genre) {
        let managedContext = persistentContainer.viewContext
        let genreEntity = GenreModel(context: managedContext)
        genreEntity.id = genre.id
        genreEntity.name = genre.name
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
    func fetchAllGenres() {
        let managedContext = self.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<GenreModel> = GenreModel.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        do {
            let genres = try managedContext.fetch(fetchRequest)
            MWSys.sh.setGenres(genres)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    // MARK: - CoreData support
    
    func isEntityAttributeExist(id: Int, entityName: String) -> Bool {
        let managedContext = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        
        let res = try? managedContext.fetch(fetchRequest)
        return (res?.count ?? 0) > 0
    }
    
    func deleteEntity(entity: Entity) {
        let managedContext = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity.rawValue)
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
    
    func entityIsEmpty(entity: Entity) -> Bool {
        let managedContext = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entity.rawValue)
        var results: [NSManagedObject] = []
        fetchRequest.returnsObjectsAsFaults = false
        do {
            results = try managedContext.fetch(fetchRequest)
        } catch {
            print("error executing fetch request \(error.localizedDescription)")
        }
        return results.isEmpty
    }
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                print("Unresolved error\(nserror), \(nserror.userInfo)")
            }
        }
    }
}
