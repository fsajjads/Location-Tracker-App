//
//  GPXTrack+CoreDataProperties.swift
//  assign4
//
//  Created by Fahim Sajjad on 11/5/21.
//
//

import Foundation
import CoreData


extension GPXTrack {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GPXTrack> {
        return NSFetchRequest<GPXTrack>(entityName: "GPXTrack")
    }

    @NSManaged public var date: Date?
    @NSManaged public var name: String?
    @NSManaged public var coord: NSSet?

}

// MARK: Generated accessors for coord
extension GPXTrack {

    @objc(addCoordObject:)
    @NSManaged public func addToCoord(_ value: GPXPoint)

    @objc(removeCoordObject:)
    @NSManaged public func removeFromCoord(_ value: GPXPoint)

    @objc(addCoord:)
    @NSManaged public func addToCoord(_ values: NSSet)

    @objc(removeCoord:)
    @NSManaged public func removeFromCoord(_ values: NSSet)

}

extension GPXTrack : Identifiable {

}
