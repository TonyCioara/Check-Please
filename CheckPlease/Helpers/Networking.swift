//
//  Networking.swift
//  CheckPlease
//
//  Created by Tony Cioara on 9/9/18.
//  Copyright © 2018 Tony Cioara. All rights reserved.
//

import Foundation
import SwiftyJSON

enum Route {
    
    case signUp(userDict: [String: String])
    case login(email: String, password: String)
    
    func method() -> String {
        switch self {
        case .signUp:
            return "POST"
        case .login:
            return "POST"
            
        }
    }
    
    func path() -> String {
        switch self {
        case .signUp:
            return "/signup"
        case .login:
            return "/login"
        }
    }
    
    func body() -> Data? {
        switch self {
        case let .signUp(userDict):
            let json = JSON(userDict)
            do {
                let result = try json.rawData()
                return result
            }
            catch {
                print("Json object did not convert to data")
                return nil
            }
            
        default:
            return nil
        }
    }
    
    func headers() -> [String: String] {
        return  ["Content-Type": "application/json"]
//        "Accept": "application/json",
    }
}

struct Networking {
    
    static let baseURL = "https://9de255f4.ngrok.io"
    static let session = URLSession.shared
    
    static func fetch(route: Route, completion: @escaping (Data) -> Void) {
        let fullPath = baseURL + route.path()
        guard let pathURL = URL(string: fullPath) else {return}
        
        var request = URLRequest(url: pathURL)
        request.httpMethod = route.method()
        // request.allHTTPHeaderFields = route.headers(authorization: token)
        request.httpBody = route.body()
        request.allHTTPHeaderFields = route.headers()
        
        session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error)
                return
            }
            if let data = data {
                completion(data)
            }
        }.resume()
    }
}
