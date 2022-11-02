//
//  MSTDNStatusItem+HTML.swift
//  ActivityPubExplorer
//
//  Created by Labtanza on 11/2/22.
//

import Foundation


extension MastodonStatusItem {
    var contentText:AttributedString {
        if var attributedTest = self.content.parseAsHTML() {
            attributedTest.font = .body
            return attributedTest
        }
        return "Could not render content."
    }
    
//    func isOptionalNil(_ instance: Any) -> Bool {
//        let mirror = Mirror(reflecting: instance)
//        let style = mirror.displayStyle
//        if style == .optional {
//            mirror.
//        }
//
//    }
    
    var whatDoIHave:String {
        let mirror = Mirror(reflecting: self)
        var itemsToDisplay:[String] = []
        
        for child in mirror.children  {
            //print("key: \(child.label), value: \(child.value)")
            if child.value is ExpressibleByNilLiteral  {
                let typeDescription = object_getClass(child.value)?.description() ?? ""
                if !typeDescription.contains("Null") && !typeDescription.contains("Empty") {
                    itemsToDisplay.append(child.label ?? "no_key")
                }
            }
        }
        
        let returnString = itemsToDisplay.count > 0 ? "Optionals Available: \(itemsToDisplay.joined(separator: ", "))" : ""
        return returnString
    }
}
