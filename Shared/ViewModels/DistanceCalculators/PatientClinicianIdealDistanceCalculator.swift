//
//  PatientClinicianIdealDistanceCalculator.swift
//  NiceClinicianDriveCalculator (iOS)
//
//  Created by Josh Lam on 2/7/22.
//

import Foundation

public class PatientClinicianIdealDistanceCalculator: IdealDistanceCalculator {
    
    
    // For a given target (clinician) and the one way distance between the target and the subject (patient)
    // determine if the clinician has a more ideal total driving distance than one that already exists for
    // the patient.  If more ideal, then update the patient with this clinician and the total driving distance
    override func determineAndAssignIdeal(subject: Locatable, target: Locatable, oneWayDistanceBetweenSubjectAndTarget: Int) {
        guard let patient = subject as? Patient else {
            print("Found a subject that does not implement the Locatable protcol")
            return
        }
        let potentialNewClinicianTotalDistance = nearestVisitingClinicianTotalDistance(patient: patient, oneWayDistanceBetweenPatientAndClinician: oneWayDistanceBetweenSubjectAndTarget)
        if let currentClinicianTotalDistance = subject.mostIdealDistanceForLocatable() {

            if potentialNewClinicianTotalDistance < currentClinicianTotalDistance {
                subject.assign(mostIdealLocatable: target, idealDistance: potentialNewClinicianTotalDistance)
            }
        }
        else {
            subject.assign(mostIdealLocatable: target, idealDistance: potentialNewClinicianTotalDistance)
        }
        
    }
    
    // Find the total distance a clinician needs to travel to the patient taking if includeLab is true or false
    func nearestVisitingClinicianTotalDistance(patient: Patient, oneWayDistanceBetweenPatientAndClinician: Int) -> Int {
        var totalDistance = 0
        if (patient.includeLab) {
            let clinicianRoundTripToLab = (patient.idealClinician?.distanceToNearestLab ?? 0) * 2
            totalDistance = (oneWayDistanceBetweenPatientAndClinician * 2) + clinicianRoundTripToLab
        }
        else {
            totalDistance = oneWayDistanceBetweenPatientAndClinician * 2
        }
        return totalDistance
    }
    
    
}
