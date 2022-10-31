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

    
    //MARK: Endpoints
    
    //see https://docs.joinmastodon.org/methods/timelines/
    private func publicTimelineEndpoint(for who:String = "public", count:Int) -> Endpoint {
        Endpoint(path: "/timelines/\(who)", queryItems: [URLQueryItem(name: "limit", value: "\(count)")])
    }
    
    //see https://docs.joinmastodon.org/methods/timelines/#hashtag-timeline
    private func singleTagEndpoint(for what:String, count:Int) -> Endpoint {
        Endpoint(path: "/timelines/tag/\(what)", queryItems: [URLQueryItem(name: "limit", value: "\(count)")])
    }
}
