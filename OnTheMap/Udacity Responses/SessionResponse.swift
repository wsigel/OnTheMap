//
//  SessionResponse.swift
//  OnTheMap
//
//  Created by Wolfgang Sigel on 10.04.20.
//  Copyright © 2020 Wolfgang Sigel. All rights reserved.
//

import Foundation

struct SessionResponse: Codable {
    let account: Account
    let session: Session
}

struct Account: Codable {
    let registered: Bool
    let key: String
}

struct Session: Codable {
    let id: String
    let expiration: String
}
