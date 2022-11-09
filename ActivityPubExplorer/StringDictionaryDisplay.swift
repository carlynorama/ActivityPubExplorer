//
//  DictionaryDisplay.swift
//  ActivityPubExplorer
//
//  Created by Labtanza on 11/9/22.
//

import SwiftUI

fileprivate extension Dictionary {
    var keyArray: [Dictionary.Key] {
        return self.keys.map { $0 }
    }
}

struct StringDictionaryDisplay: View {
    let dictionary:Dictionary<String, String>
    let keys:[String]
    
    init(_ dictionary: Dictionary<String, String>) {
        self.dictionary = dictionary
        self.keys = dictionary.keyArray
    }
    
    var body: some View {
        ForEach(keys, id:\.self) { key in
            LabeledContent(key, value: dictionary[key] ?? "-")
        }
    }
}

struct StringDictionaryDisplay_Previews: PreviewProvider {
    static var previews: some View {
        StringDictionaryDisplay(["hello":"world"])
    }
}
