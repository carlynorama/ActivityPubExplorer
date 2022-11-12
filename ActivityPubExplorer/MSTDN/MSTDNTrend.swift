// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let [instanceTrend] = try? newJSONDecoder().decode([InstanceTrend].self, from: jsonData)

import Foundation

// MARK: - InstanceTrendElement
struct MSTDNTagTrend: Codable {
    let name: String
    let url: String
    let history: [MSTDNTagTrendHistory]
}

// MARK: - History
struct MSTDNTagTrendHistory: Codable {
    let day, accounts, uses: String
}
