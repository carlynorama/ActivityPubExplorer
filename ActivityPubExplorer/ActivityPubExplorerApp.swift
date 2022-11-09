//
//  ActivityPubExplorerApp.swift
//  ActivityPubExplorer
//
//  Created by Labtanza on 10/29/22.
//

import SwiftUI

let myTestServer:APIServer.Location = APIServer.Location(host: "mastodon.social", apiBase: "/api/v1")!

@main
struct ActivityPubExplorerApp: App {
    var body: some Scene {
        WindowGroup {
            InstanceMetricsView(instance: MastodonAPIServer(server: myTestServer))
            //FeedVerticalView()
        }
    }
}
