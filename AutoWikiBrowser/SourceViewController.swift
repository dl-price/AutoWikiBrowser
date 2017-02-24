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
        
        
        //if let count = (outlineTree?.arrangedObjects as? [Node])?.count { if(count > 0) { return } }
        
        let watchlist = MWList.watchlist
        
        watchlist?.updateFromWiki(callback: { 
            for page in (watchlist?.pages as! Set<MWPage>) {
                self.addRoot(root: page)
                
            }
        })
       
    }
    
    private func addRoot(root: MWPage) {
        let n = Node(data: root.title! )
        n.instance = root.inWiki
        self.outlineTree?.addObject(n)
    }
    
    
    
    public func doThing(notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        
        
        if let inserts = userInfo[NSUpdatedObjectsKey] as? Set<MWPage>, inserts.count > 0 {
            for page in inserts {
                addRoot(root: page)

            }
        }
        
        /*let talk = Node(data: "talk")
        self.outlineTree?.addObject(talk)
        for page in (watchlist?.pages?.allObjects as? [MWPage])! {
            let n = Node(data: page.title! )
            n.instance = page.inWiki
            if(page.title?.hasPrefix("Talk:"))! {
                talk.children.append(n)
            } else {
                self.outlineTree?.addObject(n)
            }
        }*/
    }
    
    func outlineViewSelectionDidChange(_ notification: Notification) {

        
        if let node = (self.outlineView?.item(atRow: self.outlineView!.selectedRow) as? NSTreeNode)?.representedObject as? Node {
            print(node.data)
            print(node.instance?.apiURL)
        }
        
    }
    
}

public class Node : NSObject {
    public var data : String?
    public var instance : MWInstance?
    public var children : [Node] = []
    func isLeaf() -> Bool {
        if (children.isEmpty) { return true }
        return false
    }
    public init(data: String) {
        self.data = data
    }
    func countKeyPath() -> Int {
        return children.count
    }
}
