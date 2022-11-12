//
//  JSONChecker.swift
//  ActivityPubExplorer
//
//  Created by Labtanza on 11/5/22.
//

import Foundation

fileprivate struct NullableObject<Base: Decodable>: Decodable {
    public let value: Base?

    public init(from decoder: Decoder) throws {
        do {
            let container = try decoder.singleValueContainer()
            self.value = try container.decode(Base.self)
        } catch {
            self.value = nil
        }
    }
}

extension RequestService {
    
    func fetchDictionary(from url:URL) async throws -> [String: Any]? {
        let data = try await httpFetch(from: url)
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
        let data = try await httpFetch(from: url, debugLog: false)
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
    
    func fetchOptional<SomeDecodable: Decodable>(ofType:SomeDecodable.Type, from url:URL) async throws -> SomeDecodable? {
        let data = try await httpFetch(from: url)
        let result = try JSONDecoder().decode(NullableObject<SomeDecodable>.self, from: data)
        return result.value
    }
    
    func fetchCollection<SomeDecodable: Decodable>(ofType:SomeDecodable.Type, from url:URL) async throws -> [SomeDecodable?] {
        let data = try await httpFetch(from: url)
        let results = try JSONDecoder().decode([NullableObject<SomeDecodable>].self, from: data)
        return results.compactMap { $0.value }
    }
    
    func fetchCollectionOfOptionals<SomeDecodable: Decodable>(ofType:SomeDecodable.Type, from url:URL) async throws -> [SomeDecodable?] {
        let data = try await httpFetch(from: url, debugLog: false)
        let results = try JSONDecoder().decode([NullableObject<SomeDecodable>].self, from: data)
        return results.map { $0.value }
    }
    
    //from Ed
    func verboseDecode<T:Decodable>(data:Data) -> T? {
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
