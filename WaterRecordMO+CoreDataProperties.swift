//
//  WaterRecordMO+CoreDataProperties.swift
//  403Industries_Milestone2
//
//  Created by  on 2022-04-16.
//
//

import Foundation
import CoreData


extension WaterRecordMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WaterRecordMO> {
        return NSFetchRequest<WaterRecordMO>(entityName: "WaterRecord")
    }

    @NSManaged public var date: Date?
    @NSManaged public var currentWater: Int32
    @NSManaged public var recordToUser: UserMO?

}

extension WaterRecordMO : Identifiable {

}
