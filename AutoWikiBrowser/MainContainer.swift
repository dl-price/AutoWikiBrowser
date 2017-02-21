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

class MainContainer : NSView {
    
    let mainContainerController : MainContainerController
    
    required init?(coder: NSCoder) {
        mainContainerController = MainContainerController(coder: coder)!
        super.init(coder: coder)
        
        addSubview(mainContainerController.splitView)
        
        mainContainerController.splitView.addSubview(WebView())
        mainContainerController.splitView.addSubview(WebView())
    }

}

class MainContainerController : NSSplitViewController {
    

    

    

}

