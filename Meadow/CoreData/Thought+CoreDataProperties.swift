//
//  Thought+CoreDataProperties.swift
//  Meadow
//
//  Created by Kadyn Wishcop on 3/5/24.
//
//

import Foundation
import CoreData


extension Thought {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Thought> {
        return NSFetchRequest<Thought>(entityName: "Thought")
    }

    @NSManaged public var content: String?
    @NSManaged public var diagnosis: String?

}

extension Thought : Identifiable {

}
