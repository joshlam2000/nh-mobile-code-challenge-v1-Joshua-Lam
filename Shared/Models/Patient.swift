//
//  Patient.swift
//  NiceClinicianDriveCalculator (iOS)
//
//  Created by Josh Lam on 2/6/22.
//

import Foundation

public class Patient: Locatable {
    
    
    var name: String
    var address: Address
    var includeLab: Bool = false
    var idealClinician: Clinician?
    var mostIdealDistanceForClinician: Int?
    
    
    public init(addr: Address, needLab: Bool) {
        address = addr
        name = ""
        includeLab = needLab
    }
    
    func mostIdealDistanceForLocatable() -> Int? {
        return mostIdealDistanceForClinician
    }
    
    
    func mostIdealLocatable() -> Locatable? {
        return idealClinician
    }
    
    func mostIdealDistanceForClinicianString() -> String {
        if let mostIdealDistanceForClinician = self.mostIdealDistanceForClinician {
            return String(mostIdealDistanceForClinician)
        }
        else {
            return "0"
        }
    }
    
    func assign(mostIdealLocatable: Locatable, idealDistance: Int) {
        self.idealClinician = mostIdealLocatable as? Clinician
        self.mostIdealDistanceForClinician = idealDistance
    }
}
