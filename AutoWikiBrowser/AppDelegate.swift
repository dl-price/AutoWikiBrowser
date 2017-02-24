//
//  AppDelegate.swift
//  AutoWikiBrowser
//
//  Created by Daniel Price on 20/02/2017.
//  Copyright © 2017 Daniel Price. All rights reserved.
//

import Cocoa
import iWiki

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    let dataController = MWDataController()
    
    @IBOutlet var mainWindow : MainWindowController?

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        
        //MWInstance.defaultInstance.doQuery(thing)
        
        let req = MWPage.newFetchRequest()
        
        //mainWindow = (NSApplication.shared().mainWindow?.contentViewController as? UberViewController)?.primaryContainer?.snippetControllers[0].webView?.sidebarHidden

    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return false
    }
    
    @IBAction func newTab(_ sender: Any) {
            let a = NSApplication.shared().mainWindow?.contentViewController?.storyboard?.instantiateController(withIdentifier: "MainWindowController") as! MainWindowController
            
            NSApplication.shared().mainWindow?.addTabbedWindow(a.window!, ordered: .below)
        
    }


}

