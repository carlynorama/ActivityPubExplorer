//
//  APPerson.swift
//  ActivityPubExplorer
//
//  Created by Labtanza on 10/29/22.
//

import Foundation



struct APPerson: Codable {
    let context: [ContextElement]
    let type: String
    let id: String
    let following, followers, liked, inbox: String
    let outbox: String
    let preferredUsername, name, summary: String
    let icon: [String]

    enum CodingKeys: String, CodingKey {
        case context = "@context"
        case type, id, following, followers, liked, inbox, outbox, preferredUsername, name, summary, icon
    }
}

enum ContextElement: Codable {
    case contextClass(ContextClass)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        if let x = try? container.decode(ContextClass.self) {
            self = .contextClass(x)
            return
        }
        throw DecodingError.typeMismatch(ContextElement.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for ContextElement"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .contextClass(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

// MARK: - ContextClass
struct ContextClass: Codable {
    let language: String

    enum CodingKeys: String, CodingKey {
        case language = "@language"
    }
}
