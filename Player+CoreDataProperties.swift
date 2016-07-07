//
//  Player+CoreDataProperties.swift
//

import Foundation
import CoreData

extension Player {

    @NSManaged var testInteger16: NSNumber?
    @NSManaged var testInteger32: NSNumber?
    @NSManaged var testInteger64: NSNumber?
    @NSManaged var testDecimal: NSDecimalNumber?
    @NSManaged var testDouble: NSNumber?
    @NSManaged var testFloat: NSNumber?
    @NSManaged var testString: String?
    @NSManaged var testBoolean: NSNumber?
    @NSManaged var testDate: NSDate?
    @NSManaged var testBynaryData: NSData?
    @NSManaged var testTransformable: NSObject?

}
