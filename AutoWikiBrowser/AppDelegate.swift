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



    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        
        
        
        let thing = MWCategoryMembers()
        
        thing.title = "Category:Medical_terminology"
        thing.limit = 400
        MWInstance.defaultInstance.doQuery(thing)

    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true;
    }
    
    @IBAction func newTab(_ sender: Any) {
            let a = NSApplication.shared().mainWindow?.contentViewController?.storyboard?.instantiateController(withIdentifier: "MainWindowController") as! MainWindowController
            
            NSApplication.shared().mainWindow?.addTabbedWindow(a.window!, ordered: .below)
        
    }


}

