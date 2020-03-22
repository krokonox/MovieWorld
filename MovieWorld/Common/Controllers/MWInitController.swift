//
//  MWInitController.swift
//  MovieWorld
//
//  Created by Admin on 06/03/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class MWInitController: UIViewController {
    
    let dispatchGroup = DispatchGroup()
    
    var container: NSPersistentContainer!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard container != nil else {
            fatalError("This view needs a persistent container")
        }
        
        self.view.backgroundColor = .white
    
        self.loadGenres()
        self.loadConfiguration()
        
        dispatchGroup.notify(queue: .main) { [weak self] in
            self?.fetchAllGenres()
            MWI.sh.setupTabBarController()
        }
    }
    
    // MARK: - Functions
    
    func loadGenres() {
        dispatchGroup.enter()
        MWNet.sh.request(urlPath: "genre/movie/list",
                         successHandler: { (_ response: GenreResults) in
                            response.genres.forEach { genre in
                                if (MWSys.sh.genres.count) == 0 {
                                    MWCoreDataManager.sh.saveGenre(name: genre.name, id: genre.id)
                                }
                        }
        },
                         errorHandler: { ( MWError ) in
                            print(MWError.localizedDescription)})
        dispatchGroup.leave()
    }
    
    func loadConfiguration() {
        dispatchGroup.enter()
        MWNet.sh.request(urlPath: "configuration",
                         successHandler: { (_ response: MWConfiguration) in
                            MWSys.sh.setConfiguration(response.images)
            },
                         errorHandler: {  ( MWError ) in
                            print(MWError.localizedDescription)})
        dispatchGroup.leave()
    }
    
    func fetchAllGenres() {
        let managedContext = MWCoreDataManager.sh.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<GenreModel> = GenreModel.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        do {
            let genres = try managedContext.fetch(fetchRequest)
            MWSys.sh.setGenres(genres)
        } catch let error as NSError {
            fatalError("Could not fetch. \(error), \(error.userInfo)")
        }
    }
}
