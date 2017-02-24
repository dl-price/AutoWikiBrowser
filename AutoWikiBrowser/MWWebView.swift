//
//  MWWebView.swift
//  AutoWikiBrowser
//
//  Created by Daniel Price on 20/02/2017.
//  Copyright © 2017 Daniel Price. All rights reserved.
//

import Foundation
import WebKit

class MWWebView : WebView, WebResourceLoadDelegate {
    
    @IBInspectable var alwaysHideSidebar : Bool = false
    
    var sidebarHidden : Bool {
        set(new) {
            var css = String()
            var css2 = String()
            if(new) { css = "0em"; css2="none"} else { css = "11em"; css2="block"}
            windowScriptObject.evaluateWebScript("$('.mw-body').css('margin-left', '\(css)');$('#mw-navigation').css('display','\(css2)');$('#mw-page-base').css('display','\(css2)');")
        }
        get {
            if(windowScriptObject.evaluateWebScript("$('#mw-navigation').css('display');") as! String == "none") {
                return true
                }
            return false
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        resourceLoadDelegate = self
    }
    
    func webView(_: WebView!, resource: Any!, didReceive: URLResponse!, from: WebDataSource!) {
        if(alwaysHideSidebar) {
            if let httpResponse = didReceive as? HTTPURLResponse { if let content = httpResponse.allHeaderFields["Content-Type"] as? String {
                NSLog(content)
                if(!content.hasPrefix("application/json")) {
                        sidebarHidden = true
                }
                
                }}}
    }
}
