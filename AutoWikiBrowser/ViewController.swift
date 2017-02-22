//
//  ViewController.swift
//  AutoWikiBrowser
//
//  Created by Daniel Price on 20/02/2017.
//  Copyright © 2017 Daniel Price. All rights reserved.
//

import Cocoa
import WebKit

class ViewController: NSViewController, NSSplitViewDelegate {
    
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
        
        let a = storyboard?.instantiateController(withIdentifier: "LeftPanelController") as! NSViewController
        leftPanel?.addSubview(a.view)

        a.view.layer?.backgroundColor = NSColor.green.cgColor
        panelSplit?.delegate = self

    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    func splitViewDidResizeSubviews(_ notification: Notification) {
        leftPanel?.subviews[0].setFrameSize((leftPanel?.frame.size)!)
    }

}

extension NSToolbarItem {
    
}

