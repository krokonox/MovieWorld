//
//  MWSystem.swift
//  MovieWorld
//
//  Created by Admin on 06/03/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation
import CoreData

typealias MWSys = MWSystem

class MWSystem {
    
    static let sh = MWSystem()
    
    var genres: [GenreModel] = []
    var image: Image?
    
    private init() {}
    
    func setGenres(_ genres: [GenreModel]) {
        self.genres = genres
    }
    
    func setConfiguration(_ image: Image) {
        self.image = image
    }
    
    func getGenreName(for genreId: Int) -> String? {
        let ids = genres.map({ return $0.id })
        guard let genre = ids.filter({ $0 == genreId }).first else { return nil }
        return genre.name
    }
//    $0.id == genreId }).first
    
    func fetchAllGenres() {
        func fetchGenres() {
            let managedContext = MWCoreDataManager.sh.persistentContainer.viewContext
            let fetchRequest: NSFetchRequest<GenreModel> = GenreModel.fetchRequest()
            let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
            fetchRequest.sortDescriptors = [sortDescriptor]
            do {
                let genres = try managedContext.fetch(fetchRequest)
                self.genres = genres
            } catch let error as NSError {
                fatalError("Could not fetch. \(error), \(error.userInfo)")
            }
        }
    }
}

