//
//  Networking.swift
//  CheckPlease
//
//  Created by Tony Cioara on 9/9/18.
//  Copyright © 2018 Tony Cioara. All rights reserved.
//

import Foundation

enum Route {
    
    case signUp
    case login
    
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
}

struct Networking {
    
    static let baseURL = ""
    static let session = URLSession.shared
    
    static func fetch(route: Route, completion: @escaping (Data) -> Void) {
        let fullPath = baseURL + route.path()
        guard let pathURL = URL(string: fullPath) else {return}
        
        var request = URLRequest(url: pathURL)
        request.httpMethod = route.method()
        
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
