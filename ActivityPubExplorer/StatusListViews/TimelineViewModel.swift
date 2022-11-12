//
//  MastodonServerManager.swift
//  ActivityPubExplorer
//
//  Created by Labtanza on 11/6/22.
//

import Foundation

//In the other version there was a cancellable task handling server requests that should be here.

final class TimelineViewModel:ObservableObject {
    
    @Published var displayServer:MastodonAPIServer
    @Published var displayItems:[MSTDNStatusItem] = []
    @Published var displayTags:[String] = []
    
    @Published var timelineID:String
    
    @Published var queryType:TimelineType
    
    init(displayServer: MastodonAPIServer) {
        self.displayServer = displayServer
        self.displayItems = []
        self.queryType = TimelineType.instance
        self.timelineID = displayServer.name+TimelineType.instance.displayName
    }
    
    //TODO: Acting as Account
    
    var fetchingTask:Task<Void,Error>?
    
    
    public func updateTimeline(type: TimelineType) async {
        switch type {
        case .instance:
            print("Revert to Public")
            freshLoadPublic()
        case .tag(let tag):
            print("Load \(tag) related")
            await freshLoadTag(tag)
        case .account:
            print("Someday load the person status items")
        }
    }
    
    public func updateMSTDNLocation(newLocation:String) async {
        guard newLocation != displayServer.name else {
            print("Already pointed to this server")
            return
        }
        if let newServer = APIServer.Location(host: newLocation, apiBase: displayServer.server.apiBase) {
//            print("absolute:\(newServer.host.absoluteString), relative:\(newServer.host.absoluteString), ")
            Task {
                await MainActor.run {
                    displayServer = MastodonAPIServer(server: newServer)
                }
            }
            freshLoadPublic()
        }
    }
    
    private func freshLoadPublic()  {
        Task {
            await MainActor.run {
                displayItems = []
                displayTags = []
                queryType = .instance
            }
            await setTimelineID(type: .instance)
            await loadPublicTimeline()
            if let newTags = await fetchTrendTags(baseTags: displayTags) {
                await MainActor.run { displayTags = newTags }
            }
        }
    }
    
    private func freshLoadTag(_ tag:String) async {
        Task {
            await MainActor.run {
                displayItems = []
                displayTags = []
                queryType = .tag(tag)
            }
            await setTimelineID(type: .tag(tag))
            await loadTagItems(tag)
            if let newTags = await fetchTrendTags(baseTags: displayTags) {
                displayTags = newTags
            }
        }
    }
    
    private func loadTagItems(_ tag:String) async {
        do {
            let tmp:[MSTDNStatusItem] = try await displayServer.tagTimeline(tag: tag)//.compactMap{ $0 }
            await MainActor.run {
                displayItems = tmp
                
            }
            print("update complete")
            
        }catch {
            print(error)
        }
    }
    
    private func loadPublicTimeline() async {
        do {
            let tmp:[MSTDNStatusItem] = try await displayServer.publicTimeline().compactMap{ $0 }
            await MainActor.run {
                displayItems = tmp
                
            }
            print("update complete")
            
        }catch {
            print(error)
        }
    }
    
    
    
    private func fetchTrendTags(baseTags:[String]) async -> [String]? {
        let minimumTags = ["cats"] + baseTags
        async let result = await displayServer.fetchTrends()?.compactMap { $0.name }
        if let tags = await result {
            return Array(Set(minimumTags).union(tags))
        }
        return minimumTags
    }
    

    private func setTimelineID(type: TimelineType) async {
        await MainActor.run {
            self.timelineID = displayServer.name+type.displayName
        }
    }
    
    public func cancelTasks() {
        
    }
    
}
