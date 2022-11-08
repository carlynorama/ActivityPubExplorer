//
//  ServerMetricsView.swift
//  ActivityPubExplorer
//
//  Created by Labtanza on 11/8/22.
//

import SwiftUI

struct InstanceMetricsView: View {
    let instance:MastodonAPIServer
    @State var currentProfile:MSTDNInstanceProfile?
    
    var body: some View {
        VStack {
            Text(instance.server.name)
            if let currentProfile {
                InstanceStatsView(profile: currentProfile).id(currentProfile.uri)
            }
        }.task {
            //currentProfile = await instance.fetchProfile()
            currentProfile = loadSampleData()
        }
        
    }
    
    func loadSampleData() -> MSTDNInstanceProfile? {
            do {
                guard let jsonData = try loadJSONFile(ofName: "instance") else { return nil }
                let decodedData = try JSONDecoder().decode(MSTDNInstanceProfile.self, from: jsonData)
                return decodedData
            } catch { print("JSON decode error")
                
            }
        return nil
    }
    
    private func loadJSONFile(ofName name: String) throws -> Data? {
        if let bundlePath = Bundle.main.path(forResource: name, ofType: "json") {
            print("path: \(bundlePath)")
            let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8)
            return jsonData
        }
        return nil
    }
}

struct InstanceStatsView: View {
    let profile:MSTDNInstanceProfile
    
    var body: some View {
        Grid(alignment: .leading) {
            GridRow {
                Text("Version")
                Text(profile.version)
            }
        }
    }
}

struct ServerMetricsView_Previews: PreviewProvider {
    static var previews: some View {
        InstanceMetricsView(
            instance: MastodonAPIServer(server: myTestServer)
        )
    }
}
