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
    
    var mainSplitController : NSSplitViewController? {
        get {
            return childViewControllers[0] as? NSSplitViewController
        }
    }
    
    var childSplitController : [NSSplitViewController] {
        get {
                var array = [NSSplitViewController]()
        
            if let ctrl = mainSplitController?.splitViewItems[0].viewController as? NSSplitViewController {
                array.append(ctrl)
            }
            if let ctrl = mainSplitController?.splitViewItems[1].viewController as? NSSplitViewController {
                array.append(ctrl)
            }
            
        return array
        }
    }
    
    var snippetControllers : [SnippetController] {
        get {
            var array = [SnippetController]()
            
            for i1 in 0...1 {
                
                for i2 in 0...1 {
            
            if let ctrl = mainSplitController?.childViewControllers[i1].childViewControllers[i2] as? SnippetController {
                array.append(ctrl)
            }
                }
            }
            
            return array
        }
    }
    
    func splitItem(_ forSnippet: SnippetController) -> NSSplitViewItem? {
        for i in 0...1 {
        if let item = (mainSplitController?.childViewControllers[i] as? NSSplitViewController)?.splitViewItem(for: forSnippet) {
            return item
        }
        }
        
        return nil
    }
    
    var splitItem : [NSView?] {
        get {
            var array = [NSView?]()
            
            /*array.append(((childViewControllers[0] as! NSSplitViewController).splitViewItems[0].viewController.view as! NSSplitView).subviews[0])
            array.append(((childViewControllers[0] as! NSSplitViewController).splitViewItems[0].viewController.view as! NSSplitView).subviews[1])
            array.append(((childViewControllers[0] as! NSSplitViewController).splitViewItems[1].viewController.view as! NSSplitView).subviews[0])
            array.append(((childViewControllers[0] as! NSSplitViewController).splitViewItems[1].viewController.view as! NSSplitView).subviews[1])*/
            
            return array
        }
    }
    
    override func viewDidLoad() {
        mainSplitController?.view.translatesAutoresizingMaskIntoConstraints = true
        for index in 0...1 {
            var new = NSSplitViewController()
            new.view.translatesAutoresizingMaskIntoConstraints = true
            mainSplitController!.addChildViewController(new)
        
            for _ in 0...1 {
                var new2 = storyboard!.instantiateController(withIdentifier: "BasicSnippet") as! NSViewController
                new2.view.translatesAutoresizingMaskIntoConstraints = true
                mainSplitController!.childViewControllers[index].addChildViewController( new2 ) }
        
        }
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        
        mainSplitController?.splitViewItems[1].isCollapsed = true
        (mainSplitController?.childViewControllers[0] as? NSSplitViewController)?.splitViewItems[1].animator().isCollapsed = true
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        
        (snippetControllers[0].view as! WebView).mainFrame.load(URLRequest(url: URL(string: "http://en.wikipedia.org")!))
    }

}

class SnippetController : NSViewController {
    
}

