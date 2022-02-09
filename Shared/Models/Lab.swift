//
//  Lab.swift
//  NiceClinicianDriveCalculator (iOS)
//
//  Created by Josh Lam on 2/6/22.
//

import Foundation

public class Lab: Locatable {
    
    var name: String
    var address: Address
    
    public init(_ labData: LabDecodedData) {
        name = labData.name
        address = Address(labData.address)
    }
    
    func mostIdealDistanceForLocatable() -> Int? {
        return nil
    }
    
    func mostIdealLocatable() -> Locatable? {
        return nil
    }
    
    
    func assign(mostIdealLocatable nearestLocatable: Locatable, idealDistance distance: Int) {
        
    }
    
    
}
