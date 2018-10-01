//
//  Route.swift
//  CheckPlease
//
//  Created by Erik Perez on 9/10/18.
//  Copyright © 2018 Tony Cioara. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case post = "POST"
    case get = "GET"
    case patch = "PATCH"
    case delete = "DELETE"
}

enum Route {
    case login(email: String, password: String)
    case signUp(userObject: [String: String])
    
    var httpMethod: String {
        switch self {
        case .signUp:
            return HTTPMethod.post.rawValue
        case .login:
            return HTTPMethod.get.rawValue
        }
    }
    
    var header: [String: String] {
        switch self {
        default:
            return ["Content-Type": "application/json"]
        }
    }
    
    var path: String {
        switch self {
        case .signUp:
            return "/signup"
        case .login:
            return "/login"
        }
    }
    
    var parameters: [String: Any] {
        switch self {
        case let .login(email, password):
            return ["email": email, "password": password]
        default:
            return [:]
        }
    }
    
    var body: Data? {
        let serialize: ([String: String]) -> Data? = { object in
            return try? JSONSerialization.data(withJSONObject: object, options: [])
        }
        switch self {
        case let .signUp(userObject):
            let json: [String: String] = [
                "firstName": userObject["firstName"]!,
                "lastName": userObject["lastName"]!,
                "phoneNumber": userObject["phoneNumber"]!,
                "email": userObject["email"]!,
                "password": userObject["password"]!
                // TODO: Remove payment_method key-value pair & User
//                "payment_method": "card",
                ]
            return serialize(json)
        default:
            return nil
        }
    }
}
