//
//  LabJSONData.swift
//  NiceClinicianDriveCalculator (iOS)
//
//  Created by Josh Lam on 2/6/22.
//

import Foundation

public struct LabDecodedData: Codable {
    var name: String = ""
    var address: String = ""
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let name = try? container.decode(String.self, forKey: .name) {
            self.name = name
        }
        if let address = try? container.decode(String.self, forKey: .address) {
            self.address = address
        }
    }
    
    #if DEBUG
    public init(aName: String, anAddress: String) {
        name = aName
        address = anAddress
    }
    #endif
}
