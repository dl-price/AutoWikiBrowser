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
    public static var watchlist : MWList? = {
        let req = MWList.newFetchRequest()
        
        req.predicate = NSPredicate(format: "name == %@", "watchlist")
        
        do {
            let fetched = try MWDataController.defaultController?.tempObjectContext.fetch(req)
            if(fetched?.count == 0) {
                let new = NSEntityDescription.insertNewObject(forEntityName: "MWList", into: (MWDataController.defaultController?.tempObjectContext)!) as! MWList
                new.name = "watchlist"
                
                try! MWDataController.defaultController?.tempObjectContext.save()
                
                return new
            }
            else {
                return fetched![0]
            }
        } catch {
            print("Error fetching watchlist from CoreData")
        }
        return nil
    }()
    
    public class func fetch(withName: String) -> MWList? {
        
        if(withName == "watchlist") {
            return MWList.watchlist
        }
        
        let req = MWList.newFetchRequest()
        
        req.predicate = NSPredicate(format: "name == %@", withName)
        
        do {
            let fetched = try MWDataController.defaultController?.tempObjectContext.fetch(req)
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
            DispatchQueue.main.sync {
                var inserted = [MWPage]()
            for title in ret.titles {
                let fetch = MWPage.newFetchRequest()
                fetch.predicate = NSPredicate(format: "title == %@", title)
                do {
                    let fetched = try MWDataController.defaultController?.tempObjectContext.fetch(fetch)
                    if(fetched?.count == 0) {
                        let new = NSEntityDescription.insertNewObject(forEntityName: "MWPage", into: (MWDataController.defaultController?.tempObjectContext)!) as! MWPage
                        
                        //new.pageid = Int32(obj.pageid!)
                        new.title = title
                        new.inWiki = MWInstance.enWiki
                        
                        MWList.watchlist?.addToPages(new)
                        
                        inserted.append(new)
                        
                        
                        
                        
                        
                    }
                    else {
                        print("Item should be updated here")
                    }
                } catch {
                    print("Error")
                }
                }
                
                
                callback?()
                
                try! MWDataController.defaultController?.tempObjectContext.save()
            }
            
            
            
        }
        
        query.performIn(MWInstance.enWiki)
    }
}
