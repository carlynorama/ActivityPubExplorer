//
//  CardView.swift
//  ActivityPubExplorer
//
//  Created by Labtanza on 11/2/22.
//

import SwiftUI

struct CardView: View {
    let card:Card
    var body: some View {
        HStack(alignment: .top) {
            Image(systemName: "globe")
            VStack(alignment: .leading) {
                Text(card.title)
                linkDisplay
            }
        }.onAppear() {
            print(card.type)
        }

    }
    
    @ViewBuilder var linkDisplay: some View {
        if let activeLink = URL(string: card.url) {
            Text("\(card.url.linkedText(url:activeLink))").font(.caption)
        } else {
            Text("\(card.url)").font(.caption)
        }
    }
}



struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card:Card.example)
    }
}

extension Card {
    static var example:Card {
        Card(
            url: "https://wordpress.org/plugins/host-meta/",
            title: "host-meta",
            cardDescription: "host-meta for WordPress!",
            type: "link",
            authorName: "",
            authorURL: "",
            providerName: "WordPress.org",
            providerURL: "",
            html: "",
            width: 400,
            height: 130,
            image: "https://cdn.masto.host/socialcozytronicscom/cache/preview_cards/images/000/000/310/original/0a9adb8f124f812f.png",
            embedURL: "")
    }
}


             
