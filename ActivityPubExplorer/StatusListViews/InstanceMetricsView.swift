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
            currentProfile = await instance.fetchProfile()
            //currentProfile = loadSampleData()
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

//let uri, title, shortDescription, instanceMetaDescription: String
//let email, version: String
//let urls: Urls
//let stats: Stats
//let thumbnail: String
//let languages: [String]
//let registrations, approvalRequired, invitesEnabled: Bool
//let configuration: Configuration
//let contactAccount: ContactAccount
//let rules: [JSONAny]

struct InstanceStatsView: View {
    let profile:MSTDNInstanceProfile
    
    var body: some View {
        Form {
            Section("Information") {
                LabeledContent("Name", value: profile.title)
                LabeledContent("Member Count", value: profile.stats.userCount, format: .number)
                LabeledContent("Name", value: profile.title)
                LabeledContent("Member Count", value: profile.stats.userCount, format: .number)
            }
            
            Section("Additional URLS") {
                
            }
            
            Section("Contact Account") {
                LabeledContent("Name", value: profile.title)
            }
            
            Section("Stats") {
                LabeledContent("Name", value: profile.title)
                LabeledContent("Member Count", value: profile.stats.userCount, format: .number)
                
            }
            
            Section("Configuration") {
                LabeledContent("Name", value: profile.title)
                LabeledContent("Member Count", value: profile.stats.userCount, format: .number)
                
            }
//            if !profile .isEmpty {
//                Section("Pets") {
//                    ForEach(pet) { pet in
//                        LabeledContent(pet.species, value: pet.name)
//                    }
//                }
//            }
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
