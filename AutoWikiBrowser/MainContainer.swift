//
//  MainContainer.swift
//  AutoWikiBrowser
//
//  Created by Daniel Price on 21/02/2017.
//  Copyright © 2017 Daniel Price. All rights reserved.
//

import Foundation
import AppKit
import WebKit

class MainContainerController : NSViewController {
    
    @IBOutlet var web : WebView?
    var splitItem : [NSView?] {
        get {
            var array = [NSView?]()
            
            array.append(((childViewControllers[0] as! NSSplitViewController).splitViewItems[0].viewController.view as! NSSplitView).subviews[0])
            array.append(((childViewControllers[0] as! NSSplitViewController).splitViewItems[0].viewController.view as! NSSplitView).subviews[1])
            array.append(((childViewControllers[0] as! NSSplitViewController).splitViewItems[1].viewController.view as! NSSplitView).subviews[0])
            array.append(((childViewControllers[0] as! NSSplitViewController).splitViewItems[1].viewController.view as! NSSplitView).subviews[1])
            
            return array
        }
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        
        (splitItem[2] as! WebView).mainFrame.load(URLRequest(url: URL(string: "http://en.wikipedia.org")!))
    }

}

