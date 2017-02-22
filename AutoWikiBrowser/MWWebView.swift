//
//  MWWebView.swift
//  AutoWikiBrowser
//
//  Created by Daniel Price on 20/02/2017.
//  Copyright © 2017 Daniel Price. All rights reserved.
//

import Foundation
import WebKit

class MWWebView : WebView, WebFrameLoadDelegate {
    
    @IBInspectable var hidesidebar : Bool = false
    
    var sidebarHidden : Bool {
        set(new) {
            var css = String()
            var css2 = String()
            if(new) { css = "0em"; css2="none"} else { css = "11em"; css2="block"}
            windowScriptObject.evaluateWebScript("$('.mw-body').css('margin-left', '\(css)');$('#mw-navigation').css('display','\(css2)');$('#mw-page-base').css('display','\(css2)');")
        }
        get {
            return false
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        frameLoadDelegate = self
    }
    
    func webView(_ sender: WebView!, didFinishLoadFor frame: WebFrame!) {
        if(hidesidebar) {
            sidebarHidden = true
        }
    }
}
