//
//  AccountHeaderForRowView.swift
//  ActivityPubExplorer
//
//  Created by Labtanza on 11/2/22.
//

import SwiftUI


struct AccountHeaderForRowView:View {
    let account:Account
    var body: some View {
        HStack {
            Rectangle().frame(width: 20, height: 20)
            VStack(alignment: .leading) {
                Text("\(account.displayName)")
                    .font(.headline)
                Text("\(account.url)")
                    .font(.caption)
            }
        }
    }
}

//struct AccountHeaderForRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        AccountHeaderForRowView()
//    }
//}
