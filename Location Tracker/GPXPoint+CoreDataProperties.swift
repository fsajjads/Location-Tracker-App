//
//  GPXPoint+CoreDataProperties.swift
//  assign4
//
//  Created by Fahim Sajjad on 11/5/21.
//
//

import Foundation
import CoreData


extension GPXPoint {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GPXPoint> {
        return NSFetchRequest<GPXPoint>(entityName: "GPXPoint")
    }

    @NSManaged public var latitude: Double
    @NSManaged public var longtitude: Double

}

extension GPXPoint : Identifiable {

}
