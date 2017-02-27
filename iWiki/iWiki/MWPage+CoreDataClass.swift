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
    
    public func hasChildren() -> [Any] { return [] }
    
    public static func fetchOrCreate(withPageId id: Int, onWiki wiki: MWInstance, inContext context: NSManagedObjectContext) -> MWPage {
        let request = newFetchRequest()
        
        let predicate = NSPredicate(format: "pageid == %d", id)
        
        request.predicate = predicate
        
        var result = [MWPage]()
        
        do {
            try result = context.fetch(request)
        } catch {
            print("Error in MWPage.fetchOrCreate(withPageId, inContext)")
        }
        
        assert(result.count <= 1, "Error")
        
        if(result.count == 1) {
            return result[0]
        }
        
        let newPage = NSEntityDescription.insertNewObject(forEntityName: "MWPage", into: context) as! MWPage
        newPage.pageid = Int64(id)
        newPage.inWiki = wiki
        
        return newPage    
    }
    
    public func updateFromWiki(callback: () -> Void) {
        let query = MWPageQuery()
        
        query.pageIds.append(Int(pageid))
        if let _ = title {
            query.pageTitles.append(title!)
        }
        
        query.callback = {(ret: MWReturn) in
            callback()
        }
        
        query.performIn(inWiki!)
        
    
        
        
    }
    
    
}
