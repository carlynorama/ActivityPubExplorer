//
//  ExampleInstance.swift
//  ActivityPubExplorer
//
//  Created by Labtanza on 11/9/22.
//

import Foundation


struct ExampleInstanceData {
    func fetchProfile() -> MSTDNInstanceProfile? {
            do {
                guard let jsonData = try loadJSONFile(ofName: "instance") else {
                    print("No file found")
                    return nil
                }
                let decodedData = try JSONDecoder().decode(MSTDNInstanceProfile.self, from: jsonData)
                return decodedData
            } catch { print(error)
                
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
