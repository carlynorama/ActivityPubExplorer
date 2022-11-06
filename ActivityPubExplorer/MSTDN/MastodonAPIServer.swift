//
//  MastodonAPI.swift
//  ActivityPubExplorer
//
//  Created by Labtanza on 10/30/22.
//

import Foundation
//apiBase: "/api/v1"
struct MastodonAPIServer {
    typealias Endpoint = APIServer.Endpoint
    let server:APIServer.Location  //
    let requestService:RequestService = RequestService()
    
    var name:String {
        server.name
    }
    
    //TODO: What happens in the app if the network connection fails? 
    
    
    public func publicTimeline(itemCount:Int = 20) async throws -> [MSTDNStatusItem] {
            let url = try APIServer.urlFrom(server: server, endpoint: publicTimelineEndpoint(count: itemCount))
        
            //let result = try await requestService.fetchValue(ofType: [MSTDNStatusItem?].self, from: url)
        print("trying to fetch store")
        let result = try await requestService.fetchCollectionOfOptionals(ofType: MSTDNStatusItem.self, from: url)
        let validOnly = result.compactMap { $0 }
        print("\(result.count - validOnly.count) items could not be rendered")
        return validOnly
    }
    
    public func tagTimeline(tag:String, itemCount:Int = 1) async {
        do {
            let url = try APIServer.urlFrom(server: server, endpoint: singleTagEndpoint(for: tag, count: itemCount))
            let result = try await requestService.fetchValue(ofType: [MSTDNStatusItem].self, from: url)
            print(result)
        } catch {
            print(error)
        }
    }
    
    public func getFollowing(for account:String) async {
        do {
            let url = try APIServer.urlFrom(server: server, path: pathForJSON(account: account, forKey: "following"), usingAPIBase: false)
            let result = try await requestService.fetchRawString(from: url)
            print(result)
        } catch {
            print(error)
        }
    }

    
    //MARK: Endpoints
    
    let apJSONEndpointPaths = [
        "id" : "/users/{handle}",
        "following" : "{id_string}/following",
        "followers" : "{id_string}/followers",
        "liked" : "{id_string}/liked",
        "inbox" : "{id_string}/inbox",
        "outbox" : "{id_string}/outbox"
    ]
    
    private func pathForJSON(account:String, forKey key:String) throws -> String {
        let root = apJSONEndpointPaths["id"]?.replacingOccurrences(of: "{handle}", with: account) ?? ""
        let path = apJSONEndpointPaths[key]?.replacingOccurrences(of: "{id_string}", with: root)
        
        print(path ?? "no path")
        
        guard var path else {
            throw APIError("Could not build path from keys")
        }
        
        path = path.appending(".json")
        print(path)
        return path
    }
    
    private func activityPubStyleJSON(forUsername:String, forKey key:String) throws -> Endpoint {
        let root = apJSONEndpointPaths["id"]?.replacingOccurrences(of: "{handle}", with: forUsername) ?? ""
        let path = apJSONEndpointPaths[key]?.replacingOccurrences(of: "{id_string}", with: root)
        
        print(path ?? "no path")
        
        guard var path else {
            throw APIError("Could not build path from keys")
        }
        
        path = path.appending(".json")
        
        return Endpoint(path: path, queryItems: [])
    }
    
    
    //see https://docs.joinmastodon.org/methods/timelines/
    private func publicTimelineEndpoint(for who:String = "public", count:Int) -> Endpoint {
        Endpoint(path: "/timelines/\(who)", queryItems: [URLQueryItem(name: "limit", value: "\(count)")])
    }
    
    //see https://docs.joinmastodon.org/methods/timelines/#hashtag-timeline
    private func singleTagEndpoint(for what:String, count:Int) -> Endpoint {
        Endpoint(path: "/timelines/tag/\(what)", queryItems: [URLQueryItem(name: "limit", value: "\(count)")])
    }
}
