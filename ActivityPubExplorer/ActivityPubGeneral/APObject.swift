//
//  APObject.swift
//  ActivityPubExplorer
//
//  Created by Labtanza on 10/29/22.
//

import Foundation

enum APObjectType {
    case like
    case collection
    case person
}

struct APObject {
    let context: String
    let type: String
    let to: [String]
    let attributedTo: String
    let content: String

    enum CodingKeys: String, CodingKey {
        case context = "@context"
        case type, to, attributedTo, content
    }
}
