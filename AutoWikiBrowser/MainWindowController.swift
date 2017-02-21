//
//  MainWindowController.swift
//  AutoWikiBrowser
//
//  Created by Daniel Price on 20/02/2017.
//  Copyright © 2017 Daniel Price. All rights reserved.
//

import Foundation
import AppKit

class MainWindowController : NSWindowController, NSToolbarDelegate {
    @IBOutlet var toolbar : NSToolbar!
    
    weak var toolbarGroup : NSToolbarItemGroup?
    weak var leftPanelToggle : NSToolbarItem?
    weak var toolbarPrint : NSToolbarItem?
    
    override func windowDidLoad() {
        super.windowDidLoad()
        
        window!.toolbar = toolbar
        window!.titleVisibility = .hidden
    }
    
}
