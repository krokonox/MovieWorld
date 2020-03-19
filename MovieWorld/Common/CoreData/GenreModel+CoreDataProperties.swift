//
//  GenreModel+CoreDataProperties.swift
//  
//
//  Created by Admin on 19/03/2020.
//
//

import Foundation
import CoreData


extension GenreModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GenreModel> {
        return NSFetchRequest<GenreModel>(entityName: "GenreModel")
    }

    @NSManaged public var id: Int16
    @NSManaged public var name: String?

}
