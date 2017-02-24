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

class SourceViewController : NSViewController, NSOutlineViewDelegate {
    
    @IBOutlet var outlineView : NSOutlineView?
    
    @IBOutlet var outlineTree : NSTreeController?
    
    public weak var uberViewController : UberViewController?
    
    override func viewDidLoad() {
        
        
        //if let count = (outlineTree?.arrangedObjects as? [Node])?.count { if(count > 0) { return } }
        
        let watchlist = MWList.watchlist
        
        watchlist?.updateFromWiki(callback: {() in
            for page in (watchlist?.pages?.allObjects as? [MWPage])! {
                let n = Node(data: page.title! )
                n.instance = page.inWiki
                self.outlineTree?.addObject(n)
            }
            
        })
        
        
        
       
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
