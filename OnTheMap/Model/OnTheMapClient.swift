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
    
    class func login(body: SessionRequest, completion: @escaping (SessionResponse?, Error?)->Void){
        var request = URLRequest(url: Endpoints.getSessionId.url)
        request.httpMethod = "POST"
        request.httpBody = try! JSONEncoder().encode(body)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            let decoder = JSONDecoder()
            let range = 5..<data.count
            let newData = data.subdata(in: range)
            
            do {
                let responseObject = try decoder.decode(SessionResponse.self, from: newData)
                DispatchQueue.main.async {
                    completion(responseObject, nil)
                }
            } catch {
                do {
                    let errorResponse = try decoder.decode(UdacityResponse.self, from: newData) as Error
                    DispatchQueue.main.async {
                        completion(nil, errorResponse)
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(nil, error)
                    }
                }
            }
        }
        task.resume()
    }
}
