//
//  PublicTimelineView.swift
//  ActivityPubExplorer
//
//  Created by Labtanza on 10/29/22.
//

import SwiftUI


struct PublicTimelineContainerView: View {
    let list:[MSTDNStatusItem]
    
    @State var textfield:String = ""
    
    var queryType = "Public Timeline"
    
    var body: some View {
        List(list, id:\.id) { item in
            VStack(alignment: .leading) {
                AccountHeaderForRowView(account: item.account)
                Text(item.contentText)
                
                if let card = item.card {
                    CardView(card: card).padding().border(.gray)
                }
                
                if let mediaAttachments = item.mediaAttachments {
                    ForEach(mediaAttachments) { item in
                        MediaAttachmentView(attachment: item).border(.gray)
                    }
                }
                
                DisplayOptionsAvailableView(array: item.displayableOptions)
                
            }.id(UUID())  //Removing this will make program crash.
            //TODO: Doesn't crash but getting below error when use subview.
            //=== AttributeGraph: cycle detected through attribute ***SomeNumber*** ===
            //StatusItemRowView(item: item).id(UUID())
        }
    }
    
    func printString(_ item:MSTDNStatusItem) -> String? {
        print(item.content)
        return item.content
    }
    

}

struct StatusItemRowView: View {
    let item:MSTDNStatusItem
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
