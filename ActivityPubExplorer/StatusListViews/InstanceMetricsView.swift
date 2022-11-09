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
            //currentProfile = ExampleInstanceData().fetchProfile()
        }
        
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
                LabeledContent("title", value: profile.title)
                LabeledContent("uri", value: profile.uri)
                LabeledContent("version", value: profile.version)
                LabeledContent("languages", value: profile.languages?.description ?? "None")
            }

            
            Section("Registrations") {
                LabeledContent("open", value: profile.registrations ? "Yes" : "No")
                LabeledContent("approval", value: profile.approvalRequired ? "Yes" : "No")
                LabeledContent("invites", value: profile.invitesEnabled ? "Yes" : "No")
            }
            
            Section("Descriptions") {
                LabeledContent("short_description", value: profile.shortDescription)
                LabeledContent("description", value: profile.instanceMetaDescription)
                LabeledContent("email", value: profile.email)
            }
            
            
            Section("Stats") {
                //StringDictionaryDisplay(profile.stats)
                LabeledContent("user count", value: profile.stats?.userCount.formatted() ?? "None")
                LabeledContent("domain count", value: profile.stats?.domainCount.formatted() ?? "None")
                LabeledContent("status count", value: profile.stats?.statusCount.formatted() ?? "None")
            }
            
            Section("Contact Account") {
                LabeledContent("username", value: profile.contactAccount?.username ?? "None")
            }
            
            Section("Additional URLS") {
                StringDictionaryDisplay(profile.urls)
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
