//
//  UdacityResponse.swift
//  OnTheMap
//
//  Created by Wolfgang Sigel on 12.04.20.
//  Copyright © 2020 Wolfgang Sigel. All rights reserved.
//

import Foundation

struct UdacityResponse: Codable {
    let status: Int
    let error: String
}

extension UdacityResponse: LocalizedError {
    var errorDescription: String? {
        
        switch status {
        case 401, 403:
            return "Authentication failed because of incorrect credentials"
        default:
            return "Failure when connecting to the server"
        }
    }
}
