//
//  DisplayOptionsAvaialbleView.swift
//  ActivityPubExplorer
//
//  Created by Labtanza on 11/2/22.
//

import SwiftUI

struct DisplayOptionsAvailableView: View {
    let array:[String]
    
    var displayText:String {
        "Display Check: \(array.joined(separator: ", "))"
    }
    
    var body: some View {
        if array.count > 0 {
            Text("\(displayText)").font(.caption).padding(.vertical)
        }
    }
}

//struct DisplayOptionsAvailableView_Previews: PreviewProvider {
//    static var previews: some View {
//        DisplayOptionsAvailableView()
//    }
//}
