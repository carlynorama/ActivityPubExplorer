//
//  ContentView.swift
//  ActivityPubExplorer
//
//  Created by Labtanza on 10/29/22.
//

import SwiftUI

enum TimelineType {
    case tag(String)
    case account
    case instance
}

extension TimelineType {
    var displayName:String {
        switch self {
            
        case .tag(let tag):
           return "Timeline for tag \"\(tag)\""
        case .account:
            return "Timeline for account ---"
        case .instance:
            return "Public Timeline"
        }
    }
}


struct FeedVerticalView: View {
    @StateObject var timelineVM = TimelineViewModel(displayServer: MastodonAPIServer(server: myTestServer))

    
    @State var textfield:String = ""
    @State var showingServerInfo = false
    
    @State var queryType:TimelineType = .instance
    
    var body: some View {
        VStack {

            
            Group {
                HStack {
                    Group {
                        //Text("Timeline")
                        Text("\(queryType.displayName) on \(timelineVM.displayServer.name)").font(.caption)
                    }
                    
                    Button(
                        action: { showingServerInfo.toggle() },
                        label: { Image(systemName: "info") }
                    )
                }
                
                (FlowLayout(alignment: .center)) {
                    ForEach(timelineVM.displayTags, id:\.self) { tag in
                        Button("\(tag)") {
                            queryType = .tag(tag)
                        }
                    }
                }
                
                    
                
                
            }.sheet(isPresented: $showingServerInfo) {
                InstanceMetricsView(instance: timelineVM.displayServer)
            }
            
            PublicTimelineContainerView(list: timelineVM.displayItems).id(timelineVM.timelineID)
            
            Group {
                HStack {
                    TextField("enter a new server host", text: $textfield).textInputAutocapitalization(.never)
                    Button("Switch") {
                        timelineVM.updateViewInstance(newLocation: textfield)
                    }
                }.padding()
            }
        }
        .task {
            await timelineVM.testTimeLine()
        }
        .task {
            await timelineVM.fetchTrendTags()
            // await mastodonInstance.getFollowing(for: "knitter")
        }
        .onDisappear() {
            timelineVM.cancelTasks()
        }

                
            
    }

    func updateTimeline(tag:String) {
        
    }
    
    func returnToPublic() {
        
    }

}


//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
