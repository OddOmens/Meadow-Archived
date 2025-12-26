//
//  Client+CoreDataProperties.swift
//  Meadow
//
//  Created by Kadyn Wishcop on 2/9/24.
//
//

import Foundation
import CoreData


extension Client {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Client> {
        return NSFetchRequest<Client>(entityName: "Client")
    }

    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?
    @NSManaged public var image: String?
    @NSManaged public var disorders: NSSet?

}

// MARK: Generated accessors for disorders
extension Client {

    @objc(addDisordersObject:)
    @NSManaged public func addToDisorders(_ value: Disorder)

    @objc(removeDisordersObject:)
    @NSManaged public func removeFromDisorders(_ value: Disorder)

    @objc(addDisorders:)
    @NSManaged public func addToDisorders(_ values: NSSet)

    @objc(removeDisorders:)
    @NSManaged public func removeFromDisorders(_ values: NSSet)

}

extension Client : Identifiable {

}
