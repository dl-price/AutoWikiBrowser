//
//  MediaWiki.swift
//  AutoWikiBrowser
//
//  Created by Daniel Price on 20/02/2017.
//  Copyright © 2017 Daniel Price. All rights reserved.
//

import Foundation
import CoreData

public class MWBaseQuery<ReturnSub:MWReturn> {
    public var utf8 = true
    public var format = "json"
    public var action = ""
    public var meta : String?
    public var callback : ((ReturnSub) -> Void)?
    internal func onReceived(ret: ReturnSub) {}
    internal var continueToken : String?
    internal var postBody : String? { get { return nil } }
    
    
    internal var queryItems : [URLQueryItem] {
        get {
            var queryItems = [URLQueryItem]()
            
            if(utf8) {
                queryItems.append(URLQueryItem(name: "utf8", value: nil))
            }
            queryItems.append(URLQueryItem(name: "format", value: format))
            queryItems.append(URLQueryItem(name: "action", value: action))
            
            if let _ = meta {
                queryItems.append(URLQueryItem(name: "meta", value: meta))
            }
            
            return queryItems
        }
    }
    
    public func performIn(_ instance: MWInstance) {
        performDataTask(instance)
    }
    
    private func performDataTask(_ instance: MWInstance) {
        var partUrl = URLComponents(url: (instance.rootURL?.absoluteURL!)!, resolvingAgainstBaseURL: false)!
        partUrl.queryItems = queryItems
        
        var request : URLRequest = URLRequest(url: partUrl.url!)
        
        if let _ = postBody {
            request.httpMethod = "POST"
            request.httpBody = postBody?.data(using: String.Encoding.utf8)
            print(String.init(data: request.httpBody!, encoding: String.Encoding.utf8))
        }
        
        let task = instance.session.dataTask (with: request, completionHandler: {(data, response, error) in
            if let _ = error {
                NSLog(error.debugDescription)
            }
            else {
                    let ret = ReturnSub(data)
                    self.continueToken = ret.getContinue()
                    self.onReceived(ret: ret)
                    if let _ = self.callback { self.callback!(ret) }
                
            }
        })
        
        task.resume()
    }
    public var moreAvailable : Bool {
        get {
            return continueToken != nil
        }
    }
}

public class MWPageQuery : MWBaseQuery<MWReturn> {
    public var pageIds = [Int]()
    public var pageTitles = [String]()
    public override init() {
        super.init()
        
        action = "query"
    }
    
    override internal var queryItems: [URLQueryItem] {
        var queryItems = super.queryItems
        
        var ids : String?
        var titles : String?
        
        if(pageIds.count > 0) {
            ids = String()
            for id in pageIds {
                ids?.append(id.description + "|")
            }
        } else if (pageTitles.count > 0) {
            titles = String()
            for title in pageTitles {
                titles?.append(title.description + "|")
            }
        }
        
        if let _ = ids { queryItems.append(URLQueryItem(name: "pageids", value: ids))
            } else if let _ = titles { queryItems.append(URLQueryItem(name: "titles", value: titles)) }
        
        return queryItems
    }
}

public class MWListQuery<T:MWReturn> : MWBaseQuery<T> {
    public var title : String?
    public var limit : Int?
    public var list : String?
    
    public override init() {
        super.init()
        action = "query"
    }
    
    override internal var queryItems: [URLQueryItem] {
        var queryItems = super.queryItems
        
        if let _ = title { queryItems.append(URLQueryItem(name: "title", value: title)) }
        if let _ = list { queryItems.append(URLQueryItem(name: "list", value: list)) }
        
        return queryItems
    }
}



public class MWLogin : MWBaseQuery<MWReturn> {
 public let username : String
 public let password : String
 var token : String?
 
    public init(_ username: String, _ password: String) {
        self.username = username
        self.password = password
        
        super.init()
        
        self.action = "login"
    }
    
    override public var queryItems : [URLQueryItem] {
        get {
            var queryItems = super.queryItems
            
            queryItems.append(URLQueryItem(name: "lgname", value: username))
            
            return queryItems
        }
    }
    
    override public var postBody: String? {
        get {
            var postBody = super.postBody
            
            if let _ = postBody {
                postBody! += "&"
                postBody! += "lgpassword=\(self.password)"
            }
            else {
                postBody = "lgpassword=\(self.password)"
            }
            
            if let _ = token {
                postBody! += "&lgtoken=\(self.token!)"
            }
            postBody?.characters.removeLast(2)
            postBody? += "%2B%5C"
            return postBody
        }
    }
    
    override internal func performDataTask(_ instance: MWInstance) {
        var task = MWToken("login")
        
        task.callback = {(data: MWReturn) in
            
            print(data.description)
            
            let json = try? JSONSerialization.jsonObject(with: data.data!, options: [])
            
            self.token = (((json as? [String:Any])?["query"] as? [String:Any])?["tokens"] as? [String:String])?["logintoken"]
            
            super.performDataTask(instance)
        }
    }
 }

public class MWToken : MWBaseQuery<MWReturn> {
    public let type : String
    
    public init(_ type: String) {
        self.type = type
        
        super.init()
        
        self.action = "query"
        self.meta = "tokens"
        
    }
    
    override public var queryItems : [URLQueryItem] {
        var queryItems = super.queryItems
        
        queryItems.append(URLQueryItem(name: "type", value: type))
            
        return queryItems
    }
}

public class MWReturn {
    public let data : Data?
    public let json : JSON?
    public var description : String {
        get {
            if let _ = data {
                return String.init(data: data!, encoding: String.Encoding.utf8)!
            }
            return String()
        }
    }
    
    required public init(_ data: Data?) {
        self.data = data
        if let _ = data {
            self.json = JSON(data: data!)
        } else { self.json = nil }
    }
    
    internal func getContinue() -> String? {
        return nil
    }
}



public class MWParseQuery : MWBaseQuery<MWReturn> {
    public var page : String?
    public var prop = "text|headhtml"
    
    public override init() {super.init();action="parse"}
    
    override public var queryItems : [URLQueryItem] {
        var queryItems = super.queryItems
        
        if let _ = page {
            queryItems.append(URLQueryItem(name: "page", value: page))
        }
        queryItems.append(URLQueryItem(name: "prop", value: prop))
        
        return queryItems
    }
}

public class MWRevisionsQuery : MWBaseQuery<MWReturn> {
    public var prop = "revisions"
    public var titles : String?
    public var limit = 1
    override public init() {
        super.init()
        action = "query"
    }
    
    override public var queryItems: [URLQueryItem] {
        var queryItems = super.queryItems
        
        queryItems.append(URLQueryItem(name: "prop", value: prop))
        if let _ = titles {
            queryItems.append(URLQueryItem(name: "titles", value: titles))
        }
        queryItems.append(URLQueryItem(name: "rvlimit", value: limit.description))
        
        return queryItems
    }
}

public class MWWatchlistRawQuery : MWListQuery<MWWRReturn> {
    override public init() {
        super.init()
        list = "watchlistraw"
        limit = 500
    }
    override public var queryItems: [URLQueryItem] {
        var queryItems = super.queryItems
        
        queryItems.append(URLQueryItem(name: "wrlimit", value: limit?.description))
        
        return queryItems
    }
}

public class MWWRReturn : MWReturn {
    override internal func getContinue() -> String? {
        return "wrcontinue"
    }
    
    public var titles : [String] {
        let list : JSON? = json?["watchlistraw"]
        
        var ret = [String]()
        
        for el in (list?.array)! {
            ret.append(el["title"].stringValue)
        }
        
        return ret
    }
}


