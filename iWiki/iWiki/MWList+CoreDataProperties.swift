//
//  MWList+CoreDataProperties.swift
//  iWiki
//
//  Created by Daniel Price on 23/02/2017.
//  Copyright © 2017 Daniel Price. All rights reserved.
//

import Foundation
import CoreData


extension MWList {

    @nonobjc public class func newFetchRequest() -> NSFetchRequest<MWList> {
        return NSFetchRequest<MWList>(entityName: "MWList");
    }

    @NSManaged public var name: String?
    @NSManaged public var pages: NSSet?

}

// MARK: Generated accessors for pages
extension MWList {

    @objc(addPagesObject:)
    @NSManaged public func addToPages(_ value: MWPage)

    @objc(removePagesObject:)
    @NSManaged public func removeFromPages(_ value: MWPage)

    @objc(addPages:)
    @NSManaged public func addToPages(_ values: NSSet)

    @objc(removePages:)
    @NSManaged public func removeFromPages(_ values: NSSet)

}
