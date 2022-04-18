//
//  UserMO+CoreDataProperties.swift
//  403Industries_Milestone2
//
//  Created by  on 2022-04-16.
//
//

import Foundation
import CoreData


extension UserMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserMO> {
        return NSFetchRequest<UserMO>(entityName: "User")
    }

    @NSManaged public var weight: Float
    @NSManaged public var height: Float
    @NSManaged public var weightUnit: String?
    @NSManaged public var user: String?
    @NSManaged public var waterGoal: Decimal
    @NSManaged public var userToRecord: NSSet?

}

// MARK: Generated accessors for userToRecord
extension UserMO {

    @objc(addUserToRecordObject:)
    @NSManaged public func addToUserToRecord(_ value: WaterRecordMO)

    @objc(removeUserToRecordObject:)
    @NSManaged public func removeFromUserToRecord(_ value: WaterRecordMO)

    @objc(addUserToRecord:)
    @NSManaged public func addToUserToRecord(_ values: NSSet)

    @objc(removeUserToRecord:)
    @NSManaged public func removeFromUserToRecord(_ values: NSSet)

}

extension UserMO : Identifiable {

}