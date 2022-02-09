//
//  ClinicianLabIdealDistanceCalculator.swift
//  NiceClinicianDriveCalculator (iOS)
//
//  Created by Josh Lam on 2/7/22.
//

import Foundation

public class ClinicianLabIdealDisanceCalculator: IdealDistanceCalculator {
    // For each clinician given a list of labs witin the same state, determine the nearest lab
    // Assumption is all the labs are located in same state as clinicians
    func findNearestLabsForClinicians(_ clinicians: [Clinician], labs: [Lab]) {
        for clinician in clinicians {
            detemineIdealDistance(subject: clinician, targets: labs)
        } // for clinicians
    }
    
    // Examine the given one way distance between subject (clinician) and target (lab),
    // if this distance is shorter than the clinician's
    // current ideal distance, then a new closer target is found
    override func determineAndAssignIdeal(subject: Locatable, target: Locatable, oneWayDistanceBetweenSubjectAndTarget: Int) {
        if let currentIdealDistance = subject.mostIdealDistanceForLocatable() {
            if oneWayDistanceBetweenSubjectAndTarget < currentIdealDistance {
                subject.assign(mostIdealLocatable: target, idealDistance: oneWayDistanceBetweenSubjectAndTarget)
            }
        } else {
            subject.assign(mostIdealLocatable: target, idealDistance: oneWayDistanceBetweenSubjectAndTarget)
        }
    }
}
