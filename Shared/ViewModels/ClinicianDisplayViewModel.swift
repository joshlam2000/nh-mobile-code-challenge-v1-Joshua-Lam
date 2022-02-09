//
//  ClinicianDisplayViewModel.swift
//  NiceClinicianDriveCalculator (iOS)
//
//  Created by Josh Lam on 2/8/22.
//

import Foundation

public struct ClinicianDisplayViewModel {
    var patient: Patient? = nil
    var patientAddress: String = ""
    var idealClinicianFound: Bool = false
    var idealClinicianName: String = "No Clinican Found"
    var idealDistance: Int = 0
    var includeLab: Bool = false
    
    // Setup the model
    public init(patient: Patient?) {
        self.patient = patient
        if let p = patient {
            patientAddress = p.address.addressString()
            includeLab = p.includeLab
        }
        if let clinician = patient?.idealClinician {
            idealClinicianFound = true
            idealClinicianName = clinician.name
            if let distance = patient?.mostIdealDistanceForClinician {
                idealDistance = distance
            }
        }
    }
    
    public func labInclude() -> String {
        if includeLab {
            return "Yes"
        }
        else {
            return "No"
        }
    }
}
