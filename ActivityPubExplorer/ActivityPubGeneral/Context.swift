//
//  ContextClass.swift
//  ActivityPubExplorer
//
//  Created by Labtanza on 11/2/22.
//

import Foundation

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
    let manuallyApprovesFollowers: String
    let toot: String
    let featured, featuredTags, alsoKnownAs, movedTo: AlsoKnownAs
    let schema: String
    let propertyValue, value, discoverable, device: String
    let ed25519Signature, ed25519Key, curve25519Key, encryptedMessage: String
    let publicKeyBase64, deviceID: String
    let claim, fingerprintKey, identityKey, devices: AlsoKnownAs
    let messageFranking, messageType, cipherText, suspended: String
    let language:String

    enum CodingKeys: String, CodingKey {
        case manuallyApprovesFollowers, toot, featured, featuredTags, alsoKnownAs, movedTo, schema
        case propertyValue = "PropertyValue"
        case value, discoverable
        case device = "Device"
        case ed25519Signature = "Ed25519Signature"
        case ed25519Key = "Ed25519Key"
        case curve25519Key = "Curve25519Key"
        case encryptedMessage = "EncryptedMessage"
        case publicKeyBase64
        case deviceID = "deviceId"
        case claim, fingerprintKey, identityKey, devices, messageFranking, messageType, cipherText, suspended
        case language = "@language"
    }
}



// MARK: - AlsoKnownAs
struct AlsoKnownAs: Codable {
    let id, type: String

    enum CodingKeys: String, CodingKey {
        case id = "@id"
        case type = "@type"
    }
}
