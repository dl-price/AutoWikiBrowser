//
//  MediaWiki.swift
//  AutoWikiBrowser
//
//  Created by Daniel Price on 20/02/2017.
//  Copyright © 2017 Daniel Price. All rights reserved.
//

import Foundation

public class MWInstance {
    public let sessionConfig = URLSessionConfiguration.default
    public let session : URLSession
    public static var defaultInstance = MWInstance()
    public let rootURL : NSURL
    
    public init() {
        session = URLSession(configuration: sessionConfig)
        rootURL = NSURL(string: "https://en.wikipedia.org/w/api.php")!
    }
    
    public func doQuery(_ query:MWQuery) {
        
        var partUrl = URLComponents(url: rootURL.absoluteURL!, resolvingAgainstBaseURL: false)
        partUrl?.queryItems = query.toPartUrl()
        
        let task = session.dataTask(with: partUrl!.url!, completionHandler: {(data,response,error) in
            if let _ = error {
                NSLog(error.debugDescription)
            }
            else {
                let y = String.init(data: data!, encoding: String.Encoding.utf8)!
                print(y)
            }
        })
        task.resume()
    }
}

public protocol MWQuery {
    func toPartUrl() -> [URLQueryItem]
}

public class MWBaseQuery {
    public var utf8 = true
    public var format = "json"
    public var action = ""
}

public class MWListQuery : MWBaseQuery {
    public var title : String?
    public var limit : Int?
    public var list : String = ""
    
    public override init() {
        super.init()
        action = "query"
    }
}

public class MWCategoryMembers : MWListQuery, MWQuery {
    public override init() {
        super.init()
        list = "categorymembers"
    }
    
    public func toPartUrl() -> [URLQueryItem] {
        var queryItems = [URLQueryItem]()
        
        if let _ = title {
            queryItems.append(URLQueryItem(name: "cmtitle", value: title))
        }
        if let _ = limit {
            queryItems.append(URLQueryItem(name: "cmlimit", value: "\(limit!)"))
        }
        if(utf8) {
            queryItems.append(URLQueryItem(name: "utf8", value: nil))
        }
        queryItems.append(URLQueryItem(name: "format", value: format))
        queryItems.append(URLQueryItem(name: "action", value: action))
        queryItems.append(URLQueryItem(name: "list", value: list))
        return queryItems
    }
}

/*class MWLogin : MWBaseQuery, MWQuery {
 var username : String?
 var password : String?
 var token : String?
 
 override init() {
 super.init()
 action = "login"
 }
 
 func toPartUrl() -> [URLQueryItem] {
 
 }
 }*/

