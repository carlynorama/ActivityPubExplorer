// This file was generated from JSON Schema using quicktype, do not modify it directly.

//TO AUDIENCE: This was modified to make more things optional and remove JSONNULL references for now

// To parse the JSON, add this file to your project and do:
//
//   let mastodonStatusItem = try? newJSONDecoder().decode(MastodonStatusItem.self, from: jsonData)

import Foundation

// MARK: - MastodonStatusItem
struct MastodonStatusItem: Codable, Identifiable {
    //Appears to be always
    let id, createdAt: String
    let account: Account
    let content: String
    let sensitive: Bool
    let spoilerText, visibility, language: String
    let repliesCount, reblogsCount, favouritesCount: Int
    let uri, url: String
    
    //Appears to be optional
    let inReplyToID, inReplyToAccountID: String?
    let favourited, reblogged, muted, bookmarked: Bool?
    let reblog: String?
    let application: Application?
    let mediaAttachments: [MediaAttachment]?
    let mentions, tags, emojis: [JSONAny]?
    let card: Card?
    let poll: Poll?

    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case inReplyToID = "in_reply_to_id"
        case inReplyToAccountID = "in_reply_to_account_id"
        case sensitive
        case spoilerText = "spoiler_text"
        case visibility, language, uri, url
        case repliesCount = "replies_count"
        case reblogsCount = "reblogs_count"
        case favouritesCount = "favourites_count"
        case favourited, reblogged, muted, bookmarked, content, reblog, application, account
        case mediaAttachments = "media_attachments"
        case mentions, tags, emojis, card
        case poll
    }
}

// MARK: - Account
struct Account: Codable, Identifiable {
    let id, username, acct, displayName: String
    let locked, bot, discoverable, group: Bool
    let createdAt, note: String
    let url: String
    let avatar, avatarStatic: String
    let header, headerStatic: String
    let followersCount, followingCount, statusesCount: Int
    let lastStatusAt: String
    let emojis: [JSONAny]
    let fields: [Field]

    enum CodingKeys: String, CodingKey {
        case id, username, acct
        case displayName = "display_name"
        case locked, bot, discoverable, group
        case createdAt = "created_at"
        case note, url, avatar
        case avatarStatic = "avatar_static"
        case header
        case headerStatic = "header_static"
        case followersCount = "followers_count"
        case followingCount = "following_count"
        case statusesCount = "statuses_count"
        case lastStatusAt = "last_status_at"
        case emojis, fields
    }
}

// MARK: - Field
struct Field: Codable {
    let name, value: String
    let verifiedAt: String?

    enum CodingKeys: String, CodingKey {
        case name, value
        case verifiedAt = "verified_at"
    }
}

// MARK: - Application
struct Application: Codable {
    let name: String
    let website: String?
}

// MARK: - Card
struct Card: Codable {
    let url: String
    let title, cardDescription, type, authorName: String
    let authorURL, providerName, providerURL, html: String
    let width, height: Int
    let image: String?
    let embedURL: String

    enum CodingKeys: String, CodingKey {
        case url, title
        case cardDescription = "description"
        case type
        case authorName = "author_name"
        case authorURL = "author_url"
        case providerName = "provider_name"
        case providerURL = "provider_url"
        case html, width, height, image
        case embedURL = "embed_url"
    }
}

// MARK: - MediaAttachments
typealias AttachmentArray = [MediaAttachment]
struct MediaAttachments: Codable {
    let attachments: AttachmentArray

    enum CodingKeys: String, CodingKey {
        case attachments = "media_attachments"
    }
}

// MARK: - MediaAttachment
struct MediaAttachment: Codable,Identifiable {
    let id, type: String
    let url, previewURL, remoteURL: String
    let previewRemoteURL, textURL: JSONNull?
    let meta: MediaMeta?
    let mediaAttachmentDescription, blurhash: String?

    enum CodingKeys: String, CodingKey {
        case id, type, url
        case previewURL = "preview_url"
        case remoteURL = "remote_url"
        case previewRemoteURL = "preview_remote_url"
        case textURL = "text_url"
        case meta
        case mediaAttachmentDescription = "description"
        case blurhash
    }
}

// MARK: - MediaMeta
struct MediaMeta: Codable {
    let original, small: MediaDimensions?
    let focus:MediaFocus?
}

// MARK: - Dimensions
struct MediaDimensions: Codable {
    let width, height: Int?
    let size: String?
    let aspect: Double?
}

struct MediaFocus: Codable {
    let x:Double
    let y:Double
}

// MARK: - Poll
struct Poll: Codable {
    let id, expiresAt: String
    let expired, multiple: Bool
    let votesCount, votersCount: Int
    let options: [PollOption]

    enum CodingKeys: String, CodingKey {
        case id
        case expiresAt = "expires_at"
        case expired, multiple
        case votesCount = "votes_count"
        case votersCount = "voters_count"
        case options
    }
}

// MARK: - PollOption
struct PollOption: Codable {
    let title: String
    let votesCount: Int

    enum CodingKeys: String, CodingKey {
        case title
        case votesCount = "votes_count"
    }
}


// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    //https://stackoverflow.com/questions/55395207/swift-hashable-hashvalue-is-deprecated-as-a-protocol-requirement
    public func hash(into hasher: inout Hasher) {
        hasher.combine(0)
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

class JSONCodingKey: CodingKey {
    let key: String

    required init?(intValue: Int) {
        return nil
    }

    required init?(stringValue: String) {
        key = stringValue
    }

    var intValue: Int? {
        return nil
    }

    var stringValue: String {
        return key
    }
}

class JSONAny: Codable {

    let value: Any

    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
        return DecodingError.typeMismatch(JSONAny.self, context)
    }

    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
        let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
        return EncodingError.invalidValue(value, context)
    }

    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if container.decodeNil() {
            return JSONNull()
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if let value = try? container.decodeNil() {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer() {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
        if let value = try? container.decode(Bool.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Int64.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Double.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(String.self, forKey: key) {
            return value
        }
        if let value = try? container.decodeNil(forKey: key) {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer(forKey: key) {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
        var arr: [Any] = []
        while !container.isAtEnd {
            let value = try decode(from: &container)
            arr.append(value)
        }
        return arr
    }

    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
        var dict = [String: Any]()
        for key in container.allKeys {
            let value = try decode(from: &container, forKey: key)
            dict[key.stringValue] = value
        }
        return dict
    }

    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
        for value in array {
            if let value = value as? Bool {
                try container.encode(value)
            } else if let value = value as? Int64 {
                try container.encode(value)
            } else if let value = value as? Double {
                try container.encode(value)
            } else if let value = value as? String {
                try container.encode(value)
            } else if value is JSONNull {
                try container.encodeNil()
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer()
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
        for (key, value) in dictionary {
            let key = JSONCodingKey(stringValue: key)!
            if let value = value as? Bool {
                try container.encode(value, forKey: key)
            } else if let value = value as? Int64 {
                try container.encode(value, forKey: key)
            } else if let value = value as? Double {
                try container.encode(value, forKey: key)
            } else if let value = value as? String {
                try container.encode(value, forKey: key)
            } else if value is JSONNull {
                try container.encodeNil(forKey: key)
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer(forKey: key)
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
        if let value = value as? Bool {
            try container.encode(value)
        } else if let value = value as? Int64 {
            try container.encode(value)
        } else if let value = value as? Double {
            try container.encode(value)
        } else if let value = value as? String {
            try container.encode(value)
        } else if value is JSONNull {
            try container.encodeNil()
        } else {
            throw encodingError(forValue: value, codingPath: container.codingPath)
        }
    }

    public required init(from decoder: Decoder) throws {
        if var arrayContainer = try? decoder.unkeyedContainer() {
            self.value = try JSONAny.decodeArray(from: &arrayContainer)
        } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
            self.value = try JSONAny.decodeDictionary(from: &container)
        } else {
            let container = try decoder.singleValueContainer()
            self.value = try JSONAny.decode(from: container)
        }
    }

    public func encode(to encoder: Encoder) throws {
        if let arr = self.value as? [Any] {
            var container = encoder.unkeyedContainer()
            try JSONAny.encode(to: &container, array: arr)
        } else if let dict = self.value as? [String: Any] {
            var container = encoder.container(keyedBy: JSONCodingKey.self)
            try JSONAny.encode(to: &container, dictionary: dict)
        } else {
            var container = encoder.singleValueContainer()
            try JSONAny.encode(to: &container, value: self.value)
        }
    }
}

























////
////  MNStatusItem.swift
////  ActivityPubExplorer
////
////  Created by Labtanza on 10/30/22.
////
//
//import Foundation
//
//struct MNStatusItem {
//    //    Description: ID of the status in the database.
//    //    Type: String (cast from an integer but not guaranteed to be a number)
//    //    Version history: Added in 0.1.0
//    let id:String
//
//    //    Description: URI of the status used for federation.
//    //    Type: String
//    //    Version history: Added in 0.1.0
//    let uri:String
//
//    //    Description: The date when this status was created.
//    //    Type: String (ISO 8601 Datetime)
//    //    Version history: Added in 0.1.0
//    let created_at:String
//
//    //    Description: The account that authored this status.
//    //    Type: Account
//    //    Version history: Added in 0.1.0
//    let account:String
//
//    //Description: HTML-encoded status content.
//    //Type: String (HTML)
//    //Version history: Added in 0.1.0
//    let content:String
//
//    //Description: Visibility of this status.
//    //Type: String (Enumerable oneOf)
//    //public = Visible to everyone, shown in public timelines.
//    //unlisted = Visible to public, but not included in public timelines.
//    //private = Visible to followers only, and to any mentioned users.
//    //direct = Visible only to mentioned users.
//    //Version history: Added in 0.9.9
//    let visibility:String
//
//    //Description: Is this status marked as sensitive content?
//    //Type: Boolean
//    //Version history: Added in 0.9.9
//    let sensitive:Bool
//
//    //Description: Subject or summary line, below which status content is collapsed until expanded.
//    //Type: String
//    //Version history: Added in 1.0.0
//    let spoiler_text:String
//
//    //Description: Media that is attached to this status.
//    //Type: Array of Attachment
//    //Version history: Added in 0.6.0
//    let media_attachments:String
//
//    //Description: The application used to post this status.
//    //Type: Application
//    //Version history: Added in 0.9.9
//    let application:String
//}
