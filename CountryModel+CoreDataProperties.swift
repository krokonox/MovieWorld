//
//  CountryModel+CoreDataProperties.swift
//  
//
//  Created by Admin on 11/05/2020.
//
//

import Foundation
import CoreData


extension CountryModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CountryModel> {
        return NSFetchRequest<CountryModel>(entityName: "CountryModel")
    }

    @NSManaged public var code: String?
    @NSManaged public var name: String?

}
