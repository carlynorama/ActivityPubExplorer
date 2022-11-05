//
//  JSONChecker.swift
//  ActivityPubExplorer
//
//  Created by Labtanza on 11/5/22.
//

import Foundation

//https://github.com/twostraws/HackingWithSwift/blob/cedfe0f41560ea0a68623b18346b53844cb75542/Classic/Project38/Project38/SwiftyJSON.swift

private extension RequestService {
    
    func fetchOptional<SomeDecodable: Decodable>(ofType:SomeDecodable.Type, from url:URL) async throws -> SomeDecodable? {
        let (data, response) = try await session.data(from: url)  //TODO: catch the error here
       //print(response)
        guard checkForValidHTTP(response).isValid else {
            throw RequestServiceError("Not valid HTTP")
        }
        //let string = String(decoding: data, as: UTF8.self)
        //print(string)
        
        return decodeResult(data: data)
    }
    
    //Ed
    func decodeResult<T:Decodable>(data:Data) -> T? {
    //    decoder.keyDecodingStrategy = .convertFromSnakeCase
      do {
        let object = try decoder.decode(T.self, from: data)
        
        print(object)
        
        return object

      } catch DecodingError.dataCorrupted(let context) {
          print(context)
      } catch DecodingError.keyNotFound(let key, let context) {
          print("Key '\(key)' not found:", context.debugDescription)
          print("codingPath:", context.codingPath)
      } catch DecodingError.valueNotFound(let value, let context) {
          print("Value '\(value)' not found:", context.debugDescription)
          print("codingPath:", context.codingPath)
      } catch DecodingError.typeMismatch(let type, let context) {
          print("Type '\(type)' mismatch:", context.debugDescription)
          print("codingPath:", context.codingPath)
      } catch {
        print(error.localizedDescription)
      }

      return nil
    }

    
}
