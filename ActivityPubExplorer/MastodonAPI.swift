//
//  MastodonAPI.swift
//  ActivityPubExplorer
//
//  Created by Labtanza on 10/30/22.
//

import Foundation

struct MastodonAPI {
    typealias Endpoint = API.Endpoint
    let server:API.Server
    let requestService:RequestService = RequestService()
    
    
    public func publicTimeline(itemCount:Int = 20) async throws -> [MastodonStatusItem] {
            let url = try API.urlFrom(server: server, endpoint: publicTimelineEndpoint(count: itemCount))
            let result = try await requestService.fetchValue(ofType: [MastodonStatusItem].self, from: url)
            return result
    }
    
    public func tagTimeline(tag:String, itemCount:Int = 1) async {
        do {
            let url = try API.urlFrom(server: server, endpoint: singleTagEndpoint(for: tag, count: itemCount))
            let result = try await requestService.fetchValue(ofType: [MastodonStatusItem].self, from: url)
            print(result)
        } catch {
            print(error)
        }
    }
    
    public func getFollowing(for account:String) async {
        do {
            let url = try API.urlFrom(server: server, path: pathForJSON(account: account, forKey: "following"), usingAPIBase: false)
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
