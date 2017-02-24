//
//  MWInstance+CoreDataClass.swift
//  iWiki
//
//  Created by Daniel Price on 24/02/2017.
//  Copyright © 2017 Daniel Price. All rights reserved.
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


public class MWInstance: NSManagedObject {

    public var session = URLSession(configuration: URLSessionConfiguration.default)
    public static var enWiki : MWInstance = MWInstance.updateOrCreate(forName: "enWiki", withURL: "https://en.wikipedia.org/w/api.php")
    public var rootURL : NSURL? { return NSURL(string: apiURL!) }
    public var urlHost : String? { return "https://" + (URLComponents(string: rootURL!.absoluteString!)?.host)! }
    
    public class func updateOrCreate(forName: String, withURL: String) -> MWInstance {
        var instance = MWInstance.fetch(forName: forName)
        
        if (instance == nil) {
            instance = NSEntityDescription.insertNewObject(forEntityName: "MWInstance", into: (MWDataController.defaultController?.managedObjectContext)!) as? MWInstance
            instance!.name = forName
        }
        
        instance!.apiURL = withURL
        
        /*do {
            try MWDataController.defaultController?.managedObjectContext.save() } catch { print("Problem") }*/
        
        return instance!
        
        
    }
    
    public class func fetch(forName: String) -> MWInstance? {
        
        let fetch = MWInstance.newFetchRequest()
        fetch.predicate = NSPredicate(format: "name == %@", forName)
        
        let fetched = try! MWDataController.defaultController?.managedObjectContext.fetch(fetch)
        
        if let _ = fetched {
            if (fetched!.count > 0 ) { return fetched![0] }
        }
        
        return nil
        
    }
    
    public class func newFetchRequest() -> NSFetchRequest<MWInstance> {
        return NSFetchRequest<MWInstance>(entityName: "MWInstance");
    }

}
