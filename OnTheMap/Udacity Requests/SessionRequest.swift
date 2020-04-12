//
//  SessionRequest.swift
//  OnTheMap
//
//  Created by Wolfgang Sigel on 10.04.20.
//  Copyright © 2020 Wolfgang Sigel. All rights reserved.
//

import Foundation

struct SessionRequest: Codable {
    let udacity: Credentials
}

struct Credentials: Codable {
    let username: String
    let password: String
}
