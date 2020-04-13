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
        static var expiration  = ""
        static var registered = false
        static var key = ""
    }
    
    enum Endpoints {
        static let base = "https://onthemap-api.udacity.com/v1"
        
        case getSessionId
        case signUpUdacity
        case getStudentLocations
        
        var stringValue: String {
            switch self {
            case .getSessionId: return Endpoints.base + "/session"
            case .signUpUdacity: return "https://auth.udacity.com/sign-up?next=https://classroom.udacity.com/authenticated"
            case .getStudentLocations: return Endpoints.base + "/StudentLocation?limit=100&order=-updatedAt"
            }
        }
        
        var url: URL {
            return URL(string: stringValue)!
        }
    }
    
    class func getStudentLocations(completion: @escaping(StudentRequest?, Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: Endpoints.getStudentLocations.url) { (data, response, error) in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            let decoder = JSONDecoder()
            do {
                print(String(data: data, encoding: .utf8))
                let responseObject = try decoder.decode(StudentRequest.self, from: data)
                print(responseObject)
                DispatchQueue.main.async {
                    completion(responseObject, nil)
                }
            } catch {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
            }
        }
        task.resume()
    }
    
    class func login(body: SessionRequest, completion: @escaping (Bool, Error?)->Void){
        var request = URLRequest(url: Endpoints.getSessionId.url)
        request.httpMethod = "POST"
        request.httpBody = try! JSONEncoder().encode(body)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(false, error)
                }
                return
            }
            let decoder = JSONDecoder()
            let range = 5..<data.count
            let newData = data.subdata(in: range)
            
            do {
                let responseObject = try decoder.decode(SessionResponse.self, from: newData)
                DispatchQueue.main.async {
                    Auth.sessionId = responseObject.session.id
                    Auth.expiration = responseObject.session.expiration
                    Auth.registered = responseObject.account.registered
                    Auth.key = responseObject.account.key
                    completion(true, nil)
                }
            } catch {
                do {
                    let errorResponse = try decoder.decode(UdacityResponse.self, from: newData) as Error
                    DispatchQueue.main.async {
                        completion(false, errorResponse)
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(false, error)
                    }
                }
            }
        }
        task.resume()
    }
}
