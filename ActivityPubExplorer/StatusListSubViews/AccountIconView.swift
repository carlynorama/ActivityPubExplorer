//
//  AccountIconView.swift
//  ActivityPubExplorer
//
//  Created by Labtanza on 11/3/22.
//

import SwiftUI

struct AccountIconView: View {
    let account:Account
    let url:URL?
    
    init(account: Account) {
        self.account = account
        self.url = URL(string: account.avatarStatic)
    }
    
    var body: some View {
        if let url {
            AsyncImage(url: url) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                        //.frame(maxWidth: 100, maxHeight: 100)
                        .border(.orange)
                case .failure(let error):
                    let _ = print(url)
                    let _ = print(error)
                    Image(systemName: "person.circle.fill")
                @unknown default:
                    // Since the AsyncImagePhase enum isn't frozen,
                    // we need to add this currently unused fallback
                    // to handle any new cases that might be added
                    // in the future:
                    EmptyView()
                }
                
            }
        } else {
            Image(systemName: "slash.circle.fill")
            //Image(systemName: "rectangle.fill.on.rectangle.fill.slash.fill")
        }
            
        
    }
}

//struct AccountIconView_Previews: PreviewProvider {
//    static var previews: some View {
//        AccountIconView()
//    }
//}
