//
//  Player+CoreDataProperties.swift
//

import Foundation
import CoreData

extension Player {

    @NSManaged var name: String?
    @NSManaged var age: NSNumber?
    @NSManaged var adult: NSNumber?

}
