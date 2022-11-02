//
//  MSTDNStatusItem+HTML.swift
//  ActivityPubExplorer
//
//  Created by Labtanza on 11/2/22.
//

import Foundation


extension MastodonStatusItem {
    var contentText:AttributedString {
        self.content?.parseAsHTML() ?? "Could not render content."
    }
}
