//
//  MWPage+CoreDataProperties.swift
//  iWiki
//
//  Created by Daniel Price on 24/02/2017.
//  Copyright © 2017 Daniel Price. All rights reserved.
//

import Foundation
import CoreData


extension MWPage {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MWPage> {
        return NSFetchRequest<MWPage>(entityName: "MWPage");
    }

    @NSManaged public var pageid: Int32
    @NSManaged public var title: String?
    @NSManaged public var categoryChildren: NSSet?
    @NSManaged public var inCategory: NSSet?
    @NSManaged public var inWiki: MWInstance?

}

// MARK: Generated accessors for categoryChildren
extension MWPage {

    @objc(addCategoryChildrenObject:)
    @NSManaged public func addToCategoryChildren(_ value: MWPage)

    @objc(removeCategoryChildrenObject:)
    @NSManaged public func removeFromCategoryChildren(_ value: MWPage)

    @objc(addCategoryChildren:)
    @NSManaged public func addToCategoryChildren(_ values: NSSet)

    @objc(removeCategoryChildren:)
    @NSManaged public func removeFromCategoryChildren(_ values: NSSet)

}

// MARK: Generated accessors for inCategory
extension MWPage {

    @objc(addInCategoryObject:)
    @NSManaged public func addToInCategory(_ value: MWPage)

    @objc(removeInCategoryObject:)
    @NSManaged public func removeFromInCategory(_ value: MWPage)

    @objc(addInCategory:)
    @NSManaged public func addToInCategory(_ values: NSSet)

    @objc(removeInCategory:)
    @NSManaged public func removeFromInCategory(_ values: NSSet)

}
