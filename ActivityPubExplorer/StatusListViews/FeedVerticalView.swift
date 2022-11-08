//
//  ContentView.swift
//  ActivityPubExplorer
//
//  Created by Labtanza on 10/29/22.
//

import SwiftUI


struct FeedVerticalView: View {
    @StateObject var timelineVM = TimelineViewModel()

    
    @State var textfield:String = ""
    
    var queryType = "Public Timeline"
    
    var body: some View {
        VStack {
            Group {
                Text("Timeline")
            }
            
            Group {
                Text("\(queryType) on \(timelineVM.displayServer.name)").font(.caption)
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
