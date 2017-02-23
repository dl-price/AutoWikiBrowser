//
//  MWPage+CoreDataProperties.swift
//  iWiki
//
//  Created by Daniel Price on 23/02/2017.
//  Copyright © 2017 Daniel Price. All rights reserved.
//

import Foundation
import CoreData


extension MWPage {

    @nonobjc public class func newFetchRequest() -> NSFetchRequest<MWPage> {
        return NSFetchRequest<MWPage>(entityName: "MWPage");
    }

    @NSManaged public var pageid: Int32
    @NSManaged public var title: String?

}
