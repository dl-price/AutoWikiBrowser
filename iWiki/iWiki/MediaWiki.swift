//
//  MediaWiki.swift
//  iWiki
//
//  Created by Daniel Price on 02/03/2017.
//  Copyright © 2017 Daniel Price. All rights reserved.
//

import Foundation
import Alamofire

class MediaWiki {
    public let url: String
    
    init(withUrl url: String) {
        self.url = url
    }
    
    public func performRequest(req: Request) -> DataRequest {
        return Alamofire.request(url, method: req.method, parameters: req.parameters, encoding: URLEncoding.default, headers: nil)
    }
}
