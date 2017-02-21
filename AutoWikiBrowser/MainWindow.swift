//
//  MainWindow.swift
//  AutoWikiBrowser
//
//  Created by Daniel Price on 20/02/2017.
//  Copyright © 2017 Daniel Price. All rights reserved.
//

import Foundation
import AppKit

class MainWindow : NSWindowController, NSToolbarDelegate {
    @IBOutlet var toolbar : NSToolbar!
    
    weak var toolbarGroup : NSToolbarItemGroup?
    weak var leftPanelToggle : NSToolbarItem?
    weak var toolbarPrint : NSToolbarItem?
    
    override func windowDidLoad() {
        super.windowDidLoad()
        
        toolbar = NSToolbar()
    }
    
    func toolbar(_ toolbar: NSToolbar, itemForItemIdentifier itemIdentifier: String, willBeInsertedIntoToolbar flag: Bool) -> NSToolbarItem? {
        return nil
    }
    
    func toolbarAllowedItemIdentifiers(_ toolbar: NSToolbar) -> [String] {
        return [NSToolbarPrintItemIdentifier]
    }
    
    func toolbarDefaultItemIdentifiers(_ toolbar: NSToolbar) -> [String] {
        return [NSToolbarPrintItemIdentifier]
    }
    
}
