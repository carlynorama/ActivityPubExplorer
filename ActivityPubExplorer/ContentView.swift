//
//  ContentView.swift
//  ActivityPubExplorer
//
//  Created by Labtanza on 10/29/22.
//

import SwiftUI

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
                        VStack(alignment: .leading) {
                            Text("\(item.account.username)")
                                .font(.headline)
                            Text(item.content ?? "Nothing here")
                        }
                    }
        }
        .padding()
        .task {
            await testTimeLine()
        }
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
