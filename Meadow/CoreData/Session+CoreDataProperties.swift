//
//  Session+CoreDataProperties.swift
//  Meadow
//
//  Created by Kadyn Wishcop on 2/9/24.
//
//

import Foundation
import CoreData


extension Session {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Session> {
        return NSFetchRequest<Session>(entityName: "Session")
    }

    @NSManaged public var therapist: String?
    @NSManaged public var preMood: String?
    @NSManaged public var postMood: String?
    @NSManaged public var purpose: String?
    @NSManaged public var advice: String?
    @NSManaged public var date: Date?
    @NSManaged public var time: String?
    @NSManaged public var id: UUID?
    @NSManaged public var notes: String?
    @NSManaged public var count: Double
    @NSManaged public var title: String?

}

extension Session : Identifiable {

}
