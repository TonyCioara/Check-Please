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
    
    case signUp(email: String, password: String, firstName: String, lastName: String, phoneNumber: String)
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
            return "/create"
        case .login:
            return "/login"
        }
    }
    
    func body() -> Data? {
        switch self {
        case let .signUp(email, password, firstName, lastName, phoneNumber):
            let signUpDict = ["email": email,
                              "password": password,
                              "first_name": firstName,
                              "last_name": lastName,
                              "phone_number": phoneNumber,
                              "payment_method": "Card"]
            let json = JSON(signUpDict)
            do {
                let result = try json.rawData()
                return result
            }
            catch {
                print("Json object did not convert to data")
            }
            return nil
        default:
            return nil
        }
    }
    
    func headers(authorization: String) -> [String: String] {
        return ["Accept": "application/json",
                "Content-Type": "application/json"]
    }
}

struct Networking {
    
    static let baseURL = "https://71b6952c.ngrok.io"
    static let session = URLSession.shared
    
    static func fetch(route: Route, completion: @escaping (Data) -> Void) {
        let fullPath = baseURL + route.path()
        guard let pathURL = URL(string: fullPath) else {return}
        
        var request = URLRequest(url: pathURL)
        request.httpMethod = route.method()
        // request.allHTTPHeaderFields = route.headers(authorization: token)
        request.httpBody = route.body()
        request.allHTTPHeaderFields = route.headers(authorization: "abc")
        
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
