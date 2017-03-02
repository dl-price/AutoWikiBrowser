//
//  MWContext.swift
//  AutoWikiBrowser
//
//  Created by Daniel Price on 02/03/2017.
//  Copyright © 2017 Daniel Price. All rights reserved.
//

import Foundation
import iWiki

struct MWContext {
    public enum Mode {
        case Browse
        case Edit
        case BatchEdit
        case Translate
    }
    public let page : MWPage?
    public let mode : Mode
    
    init() {
        self.mode = .Browse
        self.page = nil
    }
    
    init(withMode mode:Mode, andPage page:MWPage?) {
        self.mode = mode
        self.page = page
    }
}
