//
//  MWCategoryMembers.swift
//  iWiki
//
//  Created by Daniel Price on 23/02/2017.
//  Copyright © 2017 Daniel Price. All rights reserved.
//

import Foundation
import CoreData

public class MWCategoryMembers : MWListQuery<MWCMReturn> {
    public override init() {
        super.init()
        list = "categorymembers"
    }
    
    override public var queryItems : [URLQueryItem] {
        get {
            var queryItems = super.queryItems
            
            if let _ = title {
                queryItems.append(URLQueryItem(name: "cmtitle", value: title))
            }
            if let _ = limit {
                queryItems.append(URLQueryItem(name: "cmlimit", value: "\(limit!)"))
            }
            queryItems.append(URLQueryItem(name: "list", value: list))
            if let _ = continueToken {
                queryItems.append(URLQueryItem(name: "cmcontinue", value: continueToken))
            }
            
            return queryItems
        }
    }
    
    override internal func onReceived(ret: MWCMReturn) {
        if let ctrl = MWDataController.defaultController {
            for obj in ret.members {
                let fetch = MWPage.newFetchRequest()
                fetch.predicate = NSPredicate(format: "pageid == %d", obj.pageid!)
                    do {
                        let fetched = try ctrl.managedObjectContext.fetch(fetch)
                        if(fetched.count == 0) {
                         let new = NSEntityDescription.insertNewObject(forEntityName: "MWPage", into: ctrl.managedObjectContext) as! MWPage
                            new.pageid = Int32(obj.pageid!)
                            new.title = obj.title
                            
                            try! ctrl.managedObjectContext.save()
                    }
                    else {
                        print("Item should be updated here")
                    }
                } catch {
                        print("Error")
                }
                
            }
            //try! ctrl.managedObjectContext.save()
            
        }
    }
}

public class MWCMReturn : MWReturn {
    
    public struct MWCategoryMember {
        public let title : String?
        public let pageid : Int?
        internal init(json: JSON) {
            title = json["title"].string
            pageid = json["pageid"].int
        }
    }
    
    lazy public var members : [MWCategoryMember] = {
        var ret = [MWCategoryMember]()
        let json2 = self.json?["query", "categorymembers"]
        for(key, sub):(String, JSON) in json2! {
            ret.append(MWCategoryMember(json: sub))
        }
        
        return ret
    }()
    
    internal override func getContinue() -> String? {
        return json!["continue"]["cmcontinue"].string
    }
}
