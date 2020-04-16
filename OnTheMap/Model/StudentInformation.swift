//
//  StudentInformation.swift
//  OnTheMap
//
//  Created by Wolfgang Sigel on 16.04.20.
//  Copyright © 2020 Wolfgang Sigel. All rights reserved.
//

import Foundation

struct StudentInformation: Codable {
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
