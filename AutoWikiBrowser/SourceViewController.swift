//
//  SourceViewController.swift
//  AutoWikiBrowser
//
//  Created by Daniel Price on 23/02/2017.
//  Copyright © 2017 Daniel Price. All rights reserved.
//

import Foundation
import AppKit
import iWiki
import CoreData

class SourceViewController : NSViewController, NSOutlineViewDelegate {
    
    @IBOutlet var outlineView : NSOutlineView?
    
    @IBOutlet var outlineTree : NSTreeController?
    
    public weak var uberViewController : UberViewController?
    
    override func viewDidLoad() {
        
        self.outlineTree?.managedObjectContext = MWDataController.defaultController?.tempObjectContext
        
        NotificationCenter.default.addObserver(self, selector: #selector(doThing(notification:)), name: NSNotification.Name.NSManagedObjectContextObjectsDidChange  , object: nil)
        
        let watchlist = MWList.watchlist
        
        watchlist?.updateFromWiki(callback: nil)
       
    }
    
    private func addRoot(root: MWPage) {
        /*let n = Node(data: root.title! )
        n.instance = root.inWiki
        self.outlineTree?.addObject(n)*/
        
    }
    
    
    
    public func doThing(notification: Notification) {
        
        DispatchQueue.main.async {
            //try! MWDataController.defaultController?.managedObjectContext.save()
            //try! MWDataController.defaultController?.managedObjectContext.fetch(MWPage.newFetchRequest())
            //try! MWDataController.defaultController?.managedObjectContext.save()
            //self.outlineTree?.managedObjectContext = nil
            //self.outlineTree?.managedObjectContext = MWDataController.defaultController?.managedObjectContext
            self.outlineTree?.fetch(nil)
            //print(try! MWDataController.defaultController?.managedObjectContext.fetch(MWPage.newFetchRequest()))

                //try! self.outlineTree?.fetch(with: MWPage.fetchRequest(), merge: true)

            
            //print((try! MWDataController.defaultController?.managedObjectContext.fetch(MWPage.newFetchRequest())).debugDescription)
            //print((self.outlineTree?.content as? [MWPage] )?.debugDescription)
            //self.outlineView.
        }
    }
    
}
