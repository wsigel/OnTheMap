//
//  OnTheMapClient.swift
//  OnTheMap
//
//  Created by Wolfgang Sigel on 07.04.20.
//  Copyright © 2020 Wolfgang Sigel. All rights reserved.
//

import Foundation

class OnTheMapClient {
    
    struct Auth {
        static var sessionId = ""
        static var username = ""
        static var password = ""
    }
    
    enum Endpoints {
        static let base = "https://onthemap-api.udacity.com/v1"
        
        case getSessionId
        
        var stringValue: String {
            switch self {
            case .getSessionId: return Endpoints.base + "/session"
            }
        }
        
        var url: URL {
            return URL(string: stringValue)!
        }
    }
    
    
}
