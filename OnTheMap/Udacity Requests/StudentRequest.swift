//
//  StudentRequest.swift
//  OnTheMap
//
//  Created by Wolfgang Sigel on 13.04.20.
//  Copyright © 2020 Wolfgang Sigel. All rights reserved.
//

import Foundation

struct StudentRequest: Codable {
    let results: [Student]
}

struct Student: Codable {
    let createdAt: String
    let firstName: String
    let lastName: String
    let latitude: Double
    let longitude: Double
    let mapString: String
    let mediaURL: String
    let objectId: String
    let uniqueKey: String
    let updatedAt: String
}
