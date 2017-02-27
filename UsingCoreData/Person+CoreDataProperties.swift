//
//  Person+CoreDataProperties.swift
//  UsingCoreData
//
//  Created by Appinventiv on 27/02/17.
//  Copyright © 2017 Appinventiv. All rights reserved.
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person");
    }

    @NSManaged public var address: String?
    @NSManaged public var gender: String?
    @NSManaged public var name: String?

}
