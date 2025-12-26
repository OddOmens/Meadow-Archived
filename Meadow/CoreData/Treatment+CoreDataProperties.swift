//
//  Treatment+CoreDataProperties.swift
//  Meadow
//
//  Created by Kadyn Wishcop on 2/20/24.
//
//

import Foundation
import CoreData


extension Treatment {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Treatment> {
        return NSFetchRequest<Treatment>(entityName: "Treatment")
    }

    @NSManaged public var diagnosis: String?
    @NSManaged public var desc: String?
    @NSManaged public var goal: String?

}

extension Treatment : Identifiable {

}
