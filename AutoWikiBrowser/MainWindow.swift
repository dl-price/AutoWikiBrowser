//
//  MainWindow.swift
//  AutoWikiBrowser
//
//  Created by Daniel Price on 20/02/2017.
//  Copyright © 2017 Daniel Price. All rights reserved.
//

import Foundation
import AppKit

class MainWindow : NSWindowController {
    @IBOutlet var toolbar : NSToolbar?
    
    override func windowDidLoad() {
        window!.toolbar = toolbar
    }
}
