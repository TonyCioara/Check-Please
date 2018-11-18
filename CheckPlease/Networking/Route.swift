//
//  Route.swift
//  CheckPlease
//
//  Created by Erik Perez on 9/10/18.
//  Copyright © 2018 Tony Cioara. All rights reserved.
//

import Foundation
import KeychainSwift

enum HTTPMethod: String {
    case post = "POST"
    case get = "GET"
    case patch = "PATCH"
    case delete = "DELETE"
}

enum Route {
    case login(email: String, password: String)
    case signUp(userObject: [String: String])
    case sendRequest(userId: String, receiptId: String, receipient: String, amount: String, message: String)
    
    var httpMethod: String {
        switch self {
        case .signUp, .sendRequest:
            return HTTPMethod.post.rawValue
        case .login:
            return HTTPMethod.get.rawValue
        }
    }
    
    var header: [String: String] {
        switch self {
        case .signUp, .login:
            return ["Content-Type": "application/json"]
        default:
            let keychain = KeychainSwift()
            let token = keychain.get("userToken") ?? ""
            return ["Content-Type": "application/json",
                    "Authorization": "Bearer \(token)"]
        }
    }
    
    var path: String {
        switch self {
        case .signUp:
            return "/auth/signup"
        case .login:
            return "/auth/login"
        case .sendRequest:
            return "/invoice/smsconvert"
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
                ]
            return serialize(json)
        case let .sendRequest(userId, receiptId, receipient, amount, message):
            let json: [String: String] = [
                "user_id": userId,
                "receipt_id": receiptId,
                "recipient": receipient,
                "amount": amount,
                "msg": message
            ]
            return serialize(json)
        default:
            return nil
        }
    }
}
