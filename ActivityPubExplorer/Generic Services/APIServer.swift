//
//  MastodonAPI.swift
//  ActivityPubExplorer
//
//  Created by Labtanza on 10/30/22.
//

import Foundation

enum APIError: Error, CustomStringConvertible {
    case message(String)
    var description: String {
        switch self {
        case let .message(message): return message
        }
    }
    init(_ message: String) {
        self = .message(message)
    }
}


struct APIServer {
    
    //TODO: Sanitize Paths. Look for // and whether con cat strings have /
    
    struct Location {
        let scheme:String
        let host:URL
        let apiBase:String?
    }
    
    struct Endpoint {
        let path: String
        let queryItems: [URLQueryItem]
    }
    
    static func urlFrom(server:Location, path:String, usingAPIBase:Bool = false) throws -> URL {
        var components = URLComponents()
        components.scheme = server.scheme
        components.host = server.host.absoluteString
        if server.apiBase != nil && usingAPIBase {
            components.path = server.apiBase! + path
        } else {
            components.path = path
        }
        
        guard let url = components.url else {
            throw APIError("Invalid url for path")
        }
        print(url)
        return url
    }
    
    static func urlFrom(server: Location, endpoint:Endpoint, usingAPIBase:Bool = true) throws -> URL {
        var components = URLComponents()
        components.scheme = server.scheme
        components.host = server.host.absoluteString
        print("host:\(components.host)")
        
        //print("apiBase:\(components.host)")
        
        if server.apiBase != nil && usingAPIBase {
            components.path = server.apiBase! + endpoint.path
        } else {
            components.path = endpoint.path
        }
        
        if !endpoint.queryItems.isEmpty {
            components.queryItems = endpoint.queryItems
        }
        
        guard let url = components.url else {
            print("components:\(components)")
            throw APIError("Invalid url for endpoint")
        }
        print(url)
        return url
    }
    
}


extension APIServer.Location {
    
    init?(host:String, apiBase:String?) {
        guard let url = URL(string: host) else {
            return nil
        }
        self.host = url
        self.scheme = "https"
        self.apiBase = apiBase
    }
    
    var name:String {
        self.host.absoluteString
    }
}
