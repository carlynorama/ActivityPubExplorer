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


struct API {
    
    //TODO: Sanitize Paths. Look for // and whether con cat strings have /
    
    struct Server {
        let scheme:String
        let host:String
        let apiBase:String?
    }
        
    struct Endpoint {
        let path: String
        let queryItems: [URLQueryItem]
    }
    
    static func urlFrom(server: Server, endpoint:Endpoint) throws -> URL {
        var components = URLComponents()
        components.scheme = server.scheme
        components.host = server.host
        if let base = server.apiBase {
            components.path = base + endpoint.path
        } else {
            components.path = endpoint.path
        }
        
        components.queryItems = endpoint.queryItems
        guard let url = components.url else {
            throw APIError("Invalid url for endpoint")
        }
        print(url)
        return url
    }
    
}
