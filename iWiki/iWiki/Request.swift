//
//  Request.swift
//  iWiki
//
//  Created by Daniel Price on 02/03/2017.
//  Copyright © 2017 Daniel Price. All rights reserved.
//

import Foundation
import Alamofire

class Request {
    public var parameters : Dictionary<String, String> {
            return extraParams
    }
    public var extraParams = Dictionary<String, String>()
    public var method : HTTPMethod = .get
}


