//
//  MainWindowController.swift
//  AutoWikiBrowser
//
//  Created by Daniel Price on 20/02/2017.
//  Copyright © 2017 Daniel Price. All rights reserved.
//

import Foundation
import AppKit
import WebKit

class MainWindowController : NSWindowController, NSToolbarDelegate {
    @IBOutlet var toolbar : NSToolbar?
    
    func toolbarAllowedItemIdentifiers(_ toolbar: NSToolbar) -> [String] {
        return ["yes"]
    }
    
    func toolbarDefaultItemIdentifiers(_ toolbar: NSToolbar) -> [String] {
        return ["yes"]
    }
    
    func toolbar(_ toolbar: NSToolbar, itemForItemIdentifier itemIdentifier: String, willBeInsertedIntoToolbar flag: Bool) -> NSToolbarItem? {
        if(itemIdentifier == "yes") {
            let item = NSToolbarItemGroup.init(itemIdentifier: itemIdentifier)
            let left = NSToolbarItem(itemIdentifier: "leftNav")
            let center = NSToolbarItem(itemIdentifier: "centerNav")
            let right = NSToolbarItem(itemIdentifier: "rightNav")
            
            left.image = #imageLiteral(resourceName: "LeftNavFill")
            
            item.subitems.append(left)
            item.subitems.append(center)
            item.subitems.append(right)
            
            return item
        }
        return nil
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()
        
        window?.titlebarAppearsTransparent = true
        window?.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        
        //window!.toolbar = toolbar
        //window!.titleVisibility = .hidden
    }
    
}

class PanelToolbarGroup : NSToolbarItemGroup {
    
    override init(itemIdentifier: String) {
        super.init(itemIdentifier: itemIdentifier)
        
        let left = NSToolbarItem(itemIdentifier: "left")
        let center = NSToolbarItem(itemIdentifier: "center")
        let right = NSToolbarItem(itemIdentifier: "right")
        
        left.label = "Left"
        center.label = "Center"
        right.label = "Right"
        
        subitems.append(left)
        subitems.append(center)
        subitems.append(right)
        
        label = ""
    }
    
}
