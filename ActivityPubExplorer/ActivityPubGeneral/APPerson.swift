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



// MARK: - ContextClass
// See main ContextClass file
//struct ContextClass: Codable {
//    let language: String
//
//    enum CodingKeys: String, CodingKey {
//        case language = "@language"
//    }
//}
