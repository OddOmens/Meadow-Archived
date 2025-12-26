//
//  Provider+CoreDataProperties.swift
//  Meadow
//
//  Created by Kadyn Wishcop on 5/6/25.
//
//

import Foundation
import CoreData


extension Provider {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Provider> {
        return NSFetchRequest<Provider>(entityName: "Provider")
    }

    @NSManaged public var email: String?
    @NSManaged public var firstName: String?
    @NSManaged public var id: UUID?
    @NSManaged public var isActive: Bool
    @NSManaged public var lastName: String?
    @NSManaged public var notes: String?
    @NSManaged public var phoneNumber: String?
    @NSManaged public var profileImage: Data?
    @NSManaged public var type: String?
    @NSManaged public var website: String?
    @NSManaged public var title: String?

}

extension Provider : Identifiable {

}
