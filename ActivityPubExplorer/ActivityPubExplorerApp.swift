//
//  ActivityPubExplorerApp.swift
//  ActivityPubExplorer
//
//  Created by Labtanza on 10/29/22.
//

import SwiftUI

let myTestServer:APIServer.Location = APIServer.Location(host: "social.cozytronics.com", apiBase: "/api/v1")!

@main
struct ActivityPubExplorerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
