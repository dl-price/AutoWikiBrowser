//
//  DataController.swift
//  iWiki
//
//  Created by Daniel Price on 23/02/2017.
//  Copyright © 2017 Daniel Price. All rights reserved.
//

import Foundation
import CoreData

public class MWDataController: NSObject {
    
    public var managedObjectContext : NSManagedObjectContext
    
    public static var defaultController : MWDataController?
    
    public override init() {
        
        guard let modelUrl = Bundle.init(for: MWDataController.classForCoder()).url(forResource: "MWDataModel", withExtension: "momd") else {
            fatalError("Error loading model from bundle")
        }
        
        guard let mom = NSManagedObjectModel(contentsOf: modelUrl) else {
            fatalError("Error initializing mom from:\(modelUrl)")
        }
        
        let psc = NSPersistentStoreCoordinator(managedObjectModel: mom)
        
        managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        
        managedObjectContext.persistentStoreCoordinator = psc
        
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        let docURL = urls[urls.endIndex-1]
        
        let storeURL = docURL.appendingPathComponent("MWDataModel.sqlite")
        
        do {
            try psc.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeURL, options: nil)
        } catch {
            fatalError("Error migrating store \(error)")
        }
        
        super.init()
        
        if (MWDataController.defaultController == nil) {
            MWDataController.defaultController = self
        }
        
        
        
    }
    
}
