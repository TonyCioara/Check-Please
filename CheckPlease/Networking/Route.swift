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
    case postImage(imageInfo: PaysplitImageInfo, userID: Int)
    
    var httpMethod: String {
        switch self {
        case .signUp, .postImage, .sendRequest:
            return HTTPMethod.post.rawValue
        case .login:
            return HTTPMethod.get.rawValue
        }
    }
    
    var header: [String: String] {
        // TODO: Update for secured routes
        switch self {
        case let .postImage(imageInfo, _):
            return ["Content-Type": "multipart/form-data; boundary=Boundary-\(imageInfo.uuid)"]
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
        case .postImage:
            return "/receipt_photos"
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
        case let .postImage(imageInfo, userID):
            // Huge thanks to NewFiveFour on GitHub
            // LINK: https://github.com/newfivefour/BlogPosts/blob/master/swift-form-data-multipart-upload-URLRequest.md
            var body = Data()
            let boundary = "Boundary-\(imageInfo.uuid)"
            let boundaryPrefix = "--\(boundary)\r\n"
            // Add userID to body
            body.append(boundaryPrefix)
            body.append("Content-Disposition: form-data; name=\"user_id\"\r\n\r\n")
            body.append("\(userID)\r\n")
            
            // Add image data to body
            body.append(boundaryPrefix)
            body.append("Content-Disposition: form-data; name=\"image_file\"; filename=\"\(imageInfo.filename)\"\r\n")
            body.append("Content-type: image/png\r\n\r\n")
            body.append(imageInfo.imageData)
            body.append("\r\n")
            body.append("--\(boundary)--")
            return body
        default:
            return nil
        }
    }
}
