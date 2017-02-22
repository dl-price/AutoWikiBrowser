//
//  ViewController.swift
//  AutoWikiBrowser
//
//  Created by Daniel Price on 20/02/2017.
//  Copyright © 2017 Daniel Price. All rights reserved.
//

import Cocoa
import WebKit

class ViewController: NSViewController {
    
    @IBOutlet weak var panelSplit : NSSplitView?
    @IBOutlet weak var leftPanel : NSView?
    @IBOutlet weak var centerPanel : NSView?
    @IBOutlet weak var rightPanel : NSView?
    @IBOutlet weak var webA : WikiWebView?
    @IBOutlet weak var webB : WikiWebView?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        webA?.mainFrame.load(URLRequest(url: URL(string: "http://en.wikipedia.org")!))
        webB?.mainFrame.load(URLRequest(url: URL(string: "http://en.wikipedia.org")!))

    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    


}

extension NSToolbarItem {
    
}

