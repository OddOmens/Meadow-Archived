//
//  Disorder+CoreDataProperties.swift
//  Meadow
//
//  Created by Kadyn Wishcop on 2/9/24.
//
//

import Foundation
import CoreData


extension Disorder {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Disorder> {
        return NSFetchRequest<Disorder>(entityName: "Disorder")
    }

    @NSManaged public var name: String?
    @NSManaged public var desc: String?
    @NSManaged public var disorders: NSSet?

}

// MARK: Generated accessors for disorders
extension Disorder {

    @objc(addDisordersObject:)
    @NSManaged public func addToDisorders(_ value: Client)

    @objc(removeDisordersObject:)
    @NSManaged public func removeFromDisorders(_ value: Client)

    @objc(addDisorders:)
    @NSManaged public func addToDisorders(_ values: NSSet)

    @objc(removeDisorders:)
    @NSManaged public func removeFromDisorders(_ values: NSSet)

}

extension Disorder : Identifiable {

}
