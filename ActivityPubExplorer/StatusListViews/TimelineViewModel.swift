//
//  MastodonServerManager.swift
//  ActivityPubExplorer
//
//  Created by Labtanza on 11/6/22.
//

import Foundation


final class TimelineViewModel:ObservableObject {
    
    @Published var displayServer:MastodonAPIServer = MastodonAPIServer(server: myTestServer)
    @Published var displayItems:[MSTDNStatusItem] = []
    
    //TODO: Acting as Account
    
    var fetchingTask:Task<Void,Error>?
    
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
        }
        
        //testTimeLine()
        //In the other version there was a cancellable task handling server requests that should be here. 
    }
    
    func cancelTasks() {
        
    }
    
}
