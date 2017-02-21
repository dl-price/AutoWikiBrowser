//
//  MediaWiki.swift
//  AutoWikiBrowser
//
//  Created by Daniel Price on 20/02/2017.
//  Copyright © 2017 Daniel Price. All rights reserved.
//

import Foundation

class MWInstance {
    static var defaultInstance = MWInstance()
    let rootURL = NSURL(string: "https://en.wikipedia.org/w/api.php")!
    func doQuery(_ query:MWQuery) {
        var partUrl = URLComponents(url: rootURL.absoluteURL!, resolvingAgainstBaseURL: false)
        partUrl?.queryItems = query.toPartUrl()
        NSLog((partUrl?.url?.absoluteString)!)
        
        let task = URLSession.shared.dataTask(with: (partUrl?.url!)!) {(data,response,error) in
            if let _ = error {
                NSLog(error.debugDescription)
            }
            else {
                let yes = String.init(data: data!, encoding: String.Encoding.utf8)!
                
                NSLog(yes)
                
                var hello : Int
                
            }
        }
        task.resume()
    }
}

protocol MWQuery {
    func toPartUrl() -> [URLQueryItem]
}

class MWListQuery {
    var title : String?
    var limit : Int?
}

class MWCategoryMembers : MWListQuery, MWQuery {
    func toPartUrl() -> [URLQueryItem] {
        var queryItems = [URLQueryItem]()
        
        if let _ = title {
            queryItems.append(URLQueryItem(name: "cmtitle", value: title))
        }
        if let _ = limit {
            queryItems.append(URLQueryItem(name: "cmlimit", value: "\(limit!)"))
        }
        queryItems.append(URLQueryItem(name: "utf8", value: nil))
        queryItems.append(URLQueryItem(name: "format", value: "json"))
        queryItems.append(URLQueryItem(name: "action", value: "query"))
        queryItems.append(URLQueryItem(name: "list", value: "categorymembers"))
        return queryItems
    }
}

