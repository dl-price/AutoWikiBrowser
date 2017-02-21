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
    
    @IBOutlet weak var leftPanel : NSView?
    @IBOutlet weak var centerPanel : NSView?
    @IBOutlet weak var rightPanel : NSView?
    @IBOutlet weak var webView : WebView?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        webView?.mainFrame.load(URLRequest(url: URL(string: "http://en.wikipedia.org")!))
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
}

extension NSToolbarItem {
    
}

