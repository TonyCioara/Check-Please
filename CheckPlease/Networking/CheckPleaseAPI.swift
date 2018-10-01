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
    typealias CompletionHandler = (JSONDictionary?, Error?) -> Void
    
    static func login(withEmail email: String, password: String, completionHandler handler: @escaping CompletionHandler) {
        
        request(withRoute: .login(email: email, password: password), completionHandler: handler)
    }
    
    static func signUp(withUserObject object: [String: String], completionHandler handler: @escaping CompletionHandler) {
        
        request(withRoute: .signUp(userObject: object), completionHandler: handler)
    }
    
    // MARK: - Private
    
    // TODO: Add URL
    private static let baseStringURL = "https://133780a0.ngrok.io"
    
    private static func request(withRoute route: Route, completionHandler handler: @escaping CompletionHandler) {
        
        do {
            let url = try buildURL(withBaseURLString: baseStringURL, route: route)
            var request = URLRequest(url: url)
            request.httpMethod = route.httpMethod
            request.allHTTPHeaderFields = route.header
            request.httpBody = route.body
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    handler(nil, error)
                    return
                }
                guard let data = data,
                    let json = try? JSONSerialization.jsonObject(with: data, options: []),
                    let result = json as? JSONDictionary else {
                        handler(nil, CheckPleaseAPIError.invalidJSON(route.path))
                        return
                }
                handler(result, nil)
                }.resume()
            
        } catch {
            handler(nil, error)
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
