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
            print("Error fetching watchlist from CoreData")
        }
        return nil
    }
    
    public class func fetch(withName: String) -> MWList? {
        
        if(withName == "watchlist") {
            return MWList.watchlist
        }
        
        let req = MWList.newFetchRequest()
        
        req.predicate = NSPredicate(format: "name == %@", withName)
        
        do {
            let fetched = try MWDataController.defaultController?.managedObjectContext.fetch(req)
            if(fetched?.count == 1) {
                return fetched![0]
            }
        } catch {
            print("Error fetching MWlist with name: \(withName)")
        }
        
        return nil
    }
    
    public func updateFromWiki(callback : (() -> Void)?) {
        if (name != "watchlist") {
            print("Can only update watchlist from Wiki")
            return
        }
        
        let query = MWWatchlistRawQuery()
        
        query.callback = {(ret: MWWRReturn) in
            for title in ret.titles {
                let fetch = MWPage.newFetchRequest()
                fetch.predicate = NSPredicate(format: "title == %@", title)
                do {
                    let fetched = try MWDataController.defaultController?.managedObjectContext.fetch(fetch)
                    if(fetched?.count == 0) {
                        let new = NSEntityDescription.insertNewObject(forEntityName: "MWPage", into: (MWDataController.defaultController?.managedObjectContext)!) as! MWPage
                        //new.pageid = Int32(obj.pageid!)
                        new.title = title
                        
                        MWList.watchlist?.addToPages(new)
                        
                        try! MWDataController.defaultController?.managedObjectContext.save()
                        
                        callback?()
                    }
                    else {
                        print("Item should be updated here")
                    }
                } catch {
                    print("Error")
                }
                
            }
            
            let array = MWList.watchlist?.pages?.allObjects as? [MWPage]
            
            for obj in array! {
                print(obj.title)
            }
        }
        
        query.performIn(MWInstance.defaultInstance)
        
        
    }
    
    
}
