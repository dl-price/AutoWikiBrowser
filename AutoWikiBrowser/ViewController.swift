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


    override func viewDidLoad() {
        super.viewDidLoad()
        
        panelSplit?.delegate = self
        // Do any additional setup after loading the view.

    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    func splitView(_ splitView: NSSplitView, constrainSplitPosition proposedPosition: CGFloat, ofSubviewAt dividerIndex: Int) -> CGFloat {
        if(splitView === panelSplit) {
        switch(dividerIndex) {
        case 0:
            if(proposedPosition < 100) {
                return 0
            } else if(proposedPosition < 200) {
                return 200
            }
            break
        case 1:
            if(proposedPosition > (panelSplit?.frame.width)! - 100) {
                return (panelSplit?.frame.width)!
            } else if(proposedPosition > (panelSplit?.frame.width)! - 200) {
                return (panelSplit?.frame.width)! - 200
            }
        default:
            break

        }
        return proposedPosition
    }
        
        return proposedPosition
    }
    


}

extension NSToolbarItem {
    
}

