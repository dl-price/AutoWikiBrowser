//
//  MWPage+CoreDataProperties.swift
//  iWiki
//
//  Created by Daniel Price on 27/02/2017.
//  Copyright © 2017 Daniel Price. All rights reserved.
//

import Foundation
import CoreData


extension MWPage {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MWPage> {
        return NSFetchRequest<MWPage>(entityName: "MWPage");
    }

    @NSManaged public var pageid: Int64
    @NSManaged public var title: String?
    @NSManaged public var inCategories: NSSet?
    @NSManaged public var inWiki: MWInstance?
    @NSManaged public var lists: MWList?
    @NSManaged public var revisions: NSSet?

}

// MARK: Generated accessors for inCategories
extension MWPage {

    @objc(addInCategoriesObject:)
    @NSManaged public func addToInCategories(_ value: MWCategory)

    @objc(removeInCategoriesObject:)
    @NSManaged public func removeFromInCategories(_ value: MWCategory)

    @objc(addInCategories:)
    @NSManaged public func addToInCategories(_ values: NSSet)

    @objc(removeInCategories:)
    @NSManaged public func removeFromInCategories(_ values: NSSet)

}

// MARK: Generated accessors for revisions
extension MWPage {

    @objc(addRevisionsObject:)
    @NSManaged public func addToRevisions(_ value: MWRevision)

    @objc(removeRevisionsObject:)
    @NSManaged public func removeFromRevisions(_ value: MWRevision)

    @objc(addRevisions:)
    @NSManaged public func addToRevisions(_ values: NSSet)

    @objc(removeRevisions:)
    @NSManaged public func removeFromRevisions(_ values: NSSet)

}
