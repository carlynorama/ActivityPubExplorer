//
//  ContentView.swift
//  ActivityPubExplorer
//
//  Created by Labtanza on 10/29/22.
//

import SwiftUI


struct FeedVerticalView: View {
    @StateObject var timelineVM = TimelineViewModel(displayServer: MastodonAPIServer(server: myTestServer))

    
    @State var textfield:String = ""
    @State var showingServerInfo = false
    
    var queryType = "Public Timeline"
    
    var body: some View {
        VStack {

            
            Group {
                HStack {
                    Group {
                        //Text("Timeline")
                        Text("\(queryType) on \(timelineVM.displayServer.name)").font(.caption)
                    }
                    
                    Button(
                        action: { showingServerInfo.toggle() },
                        label: { Image(systemName: "info") }
                    )
                }
            }.sheet(isPresented: $showingServerInfo) {
                InstanceMetricsView(instance: timelineVM.displayServer)
            }
            
            PublicTimelineContainerView(list: timelineVM.displayItems).id(timelineVM.displayServer.name)
            
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
            // await mastodonInstance.getFollowing(for: "knitter")
        }
        .onDisappear() {
            timelineVM.cancelTasks()
        }

                
            
    }
    
    func printString(_ item:MSTDNStatusItem) -> String? {
        print(item.content)
        return item.content
    }
    
    
    func updateViewInstance(newLocation:String) {
        
    }
}


//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
