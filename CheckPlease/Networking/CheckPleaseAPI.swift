//
//  CheckPleaseAPI.swift
//  CheckPlease
//
//  Created by Erik Perez on 9/10/18.
//  Copyright © 2018 Tony Cioara. All rights reserved.
//

import Foundation

enum CheckPleaseAPIError: Error {
    case invalidURL(String), invalidParameter(String, Any), invalidJSON(String)
}

class CheckPleaseAPI {
    
    typealias JSONDictionary = [String: Any]
    typealias CompletionHandler = (JSONDictionary?, URLResponse?, Error?) -> Void
    
    static func login(withEmail email: String, password: String, completionHandler handler: @escaping CompletionHandler) {
        
        request(withRoute: .login(email: email, password: password),
                baseStringURL: coreServerStringURL,
                completionHandler: handler)
    }
    
    static func signUp(withUserObject object: [String: String], completionHandler handler: @escaping CompletionHandler) {
        
        request(withRoute: .signUp(userObject: object),
                baseStringURL: coreServerStringURL,
                completionHandler: handler)
    }
    
    static func uploadReceiptImage(withImageInfo imageInfo: PaysplitImageInfo, userID: Int, completionHandler handler: @escaping CompletionHandler) {
        
        request(withRoute: .postImage(imageInfo: imageInfo, userID: userID),
                baseStringURL: photoHandlerServerStringURL,
                completionHandler: handler)
    }
    
    static func sendRequest(userId: String, receiptId: String, receipient: String, amount: String, message: String, completionHandler handler: @escaping CompletionHandler) {
        
        request(withRoute: .sendRequest(userId: userId, receiptId: receiptId, receipient: receipient, amount: amount, message: message), baseStringURL: coreServerStringURL, completionHandler: handler)
    }
    
    // MARK: - Private
    
    // TODO: Add URL
    private static let coreServerStringURL = "https://5a546e2d.ngrok.io"
    private static let photoHandlerServerStringURL = "https://paysplit-photo-handler-api.herokuapp.com"
    
    private static func request(withRoute route: Route, baseStringURL: String, completionHandler handler: @escaping CompletionHandler) {
        
        do {
            let url = try buildURL(withBaseURLString: baseStringURL, route: route)
            var request = URLRequest(url: url)
            request.httpMethod = route.httpMethod
            request.allHTTPHeaderFields = route.header
            request.httpBody = route.body
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    handler(nil, response, error)
                    return
                }
                guard let data = data,
                    let json = try? JSONSerialization.jsonObject(with: data, options: []),
                    let result = json as? JSONDictionary else {
                        handler(nil, response, CheckPleaseAPIError.invalidJSON(route.path))
                        return
                }
                handler(result, response, nil)
                }.resume()
            
        } catch {
            handler(nil, nil, error)
        }
    }
    
    private static func buildURL(withBaseURLString baseURLString: String, route: Route) throws -> URL {
        guard let url = URL(string: baseURLString)?.appendingPathComponent(route.path),
            var components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
                throw CheckPleaseAPIError.invalidURL(route.path)
        }
        components.queryItems = try? route.parameters.map { key, value in
            guard let v = value as? CustomStringConvertible else {
                throw CheckPleaseAPIError.invalidParameter(key, value)
            }
            return URLQueryItem(name: key, value: v.description)
        }
        
        guard let finalURL = components.url else {
            throw CheckPleaseAPIError.invalidURL(route.path)
        }
        return finalURL
    }
}
