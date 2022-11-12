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
    

    
    var body: some View {
        VStack {

            
            Group {
                HStack {
                    Group {
                        //Text("Timeline")
                        Text("\(timelineVM.queryType.displayName) on \(timelineVM.displayServer.name)").font(.caption)
                    }
                    
                    Button(
                        action: { showingServerInfo.toggle() },
                        label: { Image(systemName: "info") }
                    )
                }
                
                (FlowLayout(alignment: .center)) {
                    ForEach(timelineVM.displayTags, id:\.self) { tag in
                        Button("\(tag)") {
                            Task { await timelineVM.updateTimeline(type: .tag(tag)) }
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
                        Task { await timelineVM.updateMSTDNLocation(newLocation: textfield) }
                    }
                }.padding()
            }
        }
        .task {
            await timelineVM.updateTimeline(type: .instance)
        }.onDisappear() {
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
