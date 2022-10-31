//
//  ContentView.swift
//  ActivityPubExplorer
//
//  Created by Labtanza on 10/29/22.
//

//TODO: Doesn't crash bust still getting:
//=== AttributeGraph: cycle detected through attribute ***SomeNumber*** ===

import SwiftUI

struct StatusItemRowView: View {
    let item:MastodonStatusItem
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(item.account.username)")
                .font(.headline)
            Text(item.content?.htmlToAttributedString() ?? "No content provided").id(UUID())
        }
    }
}

struct ContentView: View {
    var mastodonInstance = MastodonAPI(server: myTestServer)
    
    @State var list:[MastodonStatusItem] = []
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
            List(list, id:\.id) { item in
                StatusItemRowView(item: item).id(UUID())
            }
        }.id(UUID()) //Removing this will make program crash.
        .padding()
        .task {
            await testTimeLine()
        }
    }
    
    func printString(_ item:MastodonStatusItem) -> String? {
        print(item.content ?? "nothing")
        return item.content
    }
    
    func testTimeLine() async {
        do {
            list = try await mastodonInstance.publicTimeline()
            print("update complete")
        }catch {
            print(error)
        }
    
        //await mastodonInstance.tagTimeline(tag: "cat")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
