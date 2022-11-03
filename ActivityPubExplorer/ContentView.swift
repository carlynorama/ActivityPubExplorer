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
            List(list, id:\.id) { item in
                VStack(alignment: .leading) {
                    AccountHeaderForRowView(account: item.account)
                    Text(item.contentText).id(UUID())
                    
                    if let card = item.card {
                        CardView(card: card).padding().border(.gray)
                    }
                    
                    if let mediaAttachments = item.mediaAttachments {
                        ForEach(mediaAttachments) { item in
                            MediaAttachmentView(attachment: item).padding().border(.gray)
                        }
                    }
                    
                    DisplayOptionsAvailableView(array: item.displayableOptions)
                    
                }.id(UUID())  //Removing this will make program crash.
                //TODO: Doesn't crash but getting below error when use subview.
                //=== AttributeGraph: cycle detected through attribute ***SomeNumber*** ===
                //StatusItemRowView(item: item).id(UUID())
            }
        .task {
            await testTimeLine()
        }
        .task {
           // await mastodonInstance.getFollowing(for: "knitter")
        }
    }
    
    func printString(_ item:MastodonStatusItem) -> String? {
        print(item.content)
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

struct StatusItemRowView: View {
    let item:MastodonStatusItem
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(item.account.username)")
                .font(.headline)
            Text(item.content.catchingParseAsHTML()).id(UUID())
        }
    }
}


//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
