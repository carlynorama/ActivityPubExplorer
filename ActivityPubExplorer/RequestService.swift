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
    private let decoder = JSONDecoder()
    private let session = URLSession.shared
    
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
    
    func fetchDictionary(from url:URL) async throws -> [String: Any]? {
        let (data, response) = try await session.data(from: url)  //TODO: catch the error here
//        print(response)
        guard checkForValidHTTP(response).isValid else {
            throw RequestServiceError("Not valid HTTP")
        }
        do {
            let result = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
            print(result)
            return result as? [String:AnyObject]
        } catch {
            print(error)
            return nil
        }
        
    }
    
    func fetchValue<SomeDecodable: Decodable>(ofType:SomeDecodable.Type, from url:URL) async throws -> SomeDecodable {
        let (data, response) = try await session.data(from: url)  //TODO: catch the error here
       //print(response)
        guard checkForValidHTTP(response).isValid else {
            throw RequestServiceError("Not valid HTTP")
        }
        //let string = String(decoding: data, as: UTF8.self)
        //print(string)
        
        let decoded = try decoder.decode(SomeDecodable.self, from: data)
        return decoded
    }
    
    func fetchTransformedValue<SomeDecodable: Decodable, Transformed>(
        ofType: SomeDecodable.Type,
        from url:URL,
        transform: @escaping (SomeDecodable) throws -> Transformed
    ) async throws -> Transformed {
        let decoded = try await fetchValue(ofType: ofType, from: url)
        return try transform(decoded)
    }
    
    func checkForValidHTTP(_ response:URLResponse) -> (isValid:Bool, mimeType:String?) {
        guard let httpResponse = response as? HTTPURLResponse,
                    (200...299).contains(httpResponse.statusCode) else {
                    self.handleServerError(response)
                    return (false, nil)
        }

        return (true, httpResponse.mimeType)
    }
    
    func handleServerError(_ response:URLResponse) {
        print(response)
    }
    
}
