//
//  MWList+CoreDataClass.swift
//  iWiki
//
//  Created by Daniel Price on 23/02/2017.
//  Copyright © 2017 Daniel Price. All rights reserved.
//

import Foundation
import CoreData


public class MWList: NSManagedObject {
    public class var watchlist : MWList? {
        let req = MWList.newFetchRequest()
        
        req.predicate = NSPredicate(format: "name == %@", "watchlist")
        
        do {
            let fetched = try MWDataController.defaultController?.managedObjectContext.fetch(req)
            if(fetched?.count == 0) {
                let new = NSEntityDescription.insertNewObject(forEntityName: "MWList", into: (MWDataController.defaultController?.managedObjectContext)!) as! MWList
                new.name = "watchlist"
                
                try! MWDataController.defaultController?.managedObjectContext.save()
                
                return new
            }
            else {
                
                return fetched![0]
            }
        } catch {
            print("Error")
        }
        return nil
    }
}
