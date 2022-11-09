//
//  ResponseService.swift
//  NetworkingExample
//
//  Created by Carlyn Maw on 10/29/22.
//

import Foundation

enum RequestServiceError:Error, CustomStringConvertible {
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

actor RequestService {
    internal let decoder = JSONDecoder()
    internal let session = URLSession.shared
    
    //MARK: - Level One Fetch Requests (Hello World)
    
    func serverHello(from url:URL) async throws -> String {
        let (_, response) = try await session.data(from: url)  //TODO: catch the error here
        //print(response)
        let (isValid, mimeType) = checkForValidHTTP(response)
        return "The url returns a \(isValid ? "valid":"invalid") HTTP response\(isValid ? " of type \(mimeType ?? "unknown")":".")"
    }
    
    func fetchRawString(from:URL, encoding:String.Encoding = .utf8) async throws -> String {
        let (data, _) = try await session.data(from: from)
        guard let string = String(data: data, encoding: encoding) else {
            throw RequestServiceError("Got data, couldn't make a string with \(encoding)")
        }
        return string
    }
    
    
    //MARK: - Generic HTTP Handling
    internal func httpFetch(from url:URL, debugLog:Bool = false) async throws -> Data {
        let (data, response) = try await session.data(from: url)  //TODO: catch the error here
       //print(response)
        guard checkForValidHTTP(response).isValid else {
            throw RequestServiceError("Not valid HTTP")
        }
        
        if debugLog {
            let string = String(decoding: data, as: UTF8.self)
            print(string)
        }
        return data
    }
    
    internal func checkForValidHTTP(_ response:URLResponse) -> (isValid:Bool, mimeType:String?) {
        guard let httpResponse = response as? HTTPURLResponse,
                    (200...299).contains(httpResponse.statusCode) else {
                    self.handleServerError(response)
                    return (false, nil)
        }

        return (true, httpResponse.mimeType)
    }
    
    internal func handleServerError(_ response:URLResponse) {
        print(response)
    }
    
}
