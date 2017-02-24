//
//  MWPage+CoreDataClass.swift
//  iWiki
//
//  Created by Daniel Price on 23/02/2017.
//  Copyright © 2017 Daniel Price. All rights reserved.
//

import Foundation
import CoreData


public class MWPage: NSManagedObject {
    public class func newFetchRequest() -> NSFetchRequest<MWPage> {
        return NSFetchRequest<MWPage>(entityName: "MWPage");
    }
    
    public func isLeaf() -> Bool { return true }
}
