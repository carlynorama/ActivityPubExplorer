//
//  MastodonServerManager.swift
//  ActivityPubExplorer
//
//  Created by Labtanza on 11/6/22.
//

import Foundation


final class TimelineViewModel:ObservableObject {
    
    @Published var displayServer:MastodonAPIServer
    @Published var displayItems:[MSTDNStatusItem] = []
    @Published var displayTags:[String] = []
    
    init(displayServer: MastodonAPIServer) {
        self.displayServer = displayServer
        self.displayItems = []
    }
    
    //TODO: Acting as Account
    
    var fetchingTask:Task<Void,Error>?
    
    func fetchTrendTags() async {
        async let result = await displayServer.fetchTrends()?.compactMap { $0.name }
        var tagHolder = Set(displayTags)
        if let tags = await result {
            let newItems = tagHolder.union(tags)
            await MainActor.run { displayTags = Array(newItems) }
        }
       
    }
    
    func testTimeLine() async {
        do {
            let tmp:[MSTDNStatusItem] = try await displayServer.publicTimeline().compactMap{ $0 }
            await MainActor.run {
                displayItems = tmp
            }
            print("update complete")
            
        }catch {
            print(error)
        }
        
        //await mastodonInstance.tagTimeline(tag: "cat")
    }
    
    func updateViewInstance(newLocation:String) {
        
        if let newServer = APIServer.Location(host: newLocation, apiBase: displayServer.server.apiBase) {
            print("absolute:\(newServer.host.absoluteString), relative:\(newServer.host.absoluteString), ")
            displayItems = []
            displayServer = MastodonAPIServer(server: newServer)
            Task { await testTimeLine() }
            Task { await fetchTrendTags() } 
        }
        
        //testTimeLine()
        //In the other version there was a cancellable task handling server requests that should be here. 
    }
    
    func cancelTasks() {
        
    }
    
}
