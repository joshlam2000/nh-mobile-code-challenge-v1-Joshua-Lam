//
//  Clinician.swift
//  NiceClinicianDriveCalculator (iOS)
//
//  Created by Josh Lam on 2/6/22.
//

import Foundation

public class Clinician: Locatable {

    var name: String
    var address: Address
    var nearestLab: Lab?
    var distanceToNearestLab: Int?
    
    public init(_ clinicianData: ClinicianDecodedData) {
        name = clinicianData.name
        address = Address(clinicianData.address)
    }
    
    func mostIdealDistanceForLocatable() -> Int? {
        return distanceToNearestLab
    }
    
    func mostIdealLocatable() -> Locatable? {
        return nearestLab
    }
    
    func assign(mostIdealLocatable: Locatable, idealDistance: Int) {
        nearestLab = mostIdealLocatable as? Lab
        distanceToNearestLab = idealDistance
    }
    
}
