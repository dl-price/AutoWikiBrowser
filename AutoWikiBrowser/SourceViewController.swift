//
//  SourceViewController.swift
//  AutoWikiBrowser
//
//  Created by Daniel Price on 23/02/2017.
//  Copyright © 2017 Daniel Price. All rights reserved.
//

import Foundation
import AppKit

class SourceViewController : NSViewController {
    
    @IBOutlet var outlineView : NSOutlineView?
    
    @IBOutlet var outlineTree : NSTreeController?
    
    override func awakeFromNib() {
        let n = Node(data: "yes")
        //n.children.append(Node(data: "yes1"))
        //n.children.append(Node(data: "yes2"))
        
        outlineTree?.addObject(n)
        
        print(outlineTree?.countKeyPath)
    }
    
}

public class Node : NSObject {
    public var data : String?
    public var children : [Node] = []
    func isLeaf() -> Bool {
        if (children.isEmpty) { return true }
        return false
    }
    public init(data: String) {
        self.data = data
    }
}
