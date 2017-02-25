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
            self.outlineTree?.fetch(nil)
            print((self.outlineTree?.content as? [MWPage] )?.debugDescription)
            //self.outlineView.
        }
    }
    
}
