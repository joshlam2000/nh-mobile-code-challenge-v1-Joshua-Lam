//
//  IdealDistanceCalculator.swift
//  NiceClinicianDriveCalculator (iOS)
//
//  Created by Josh Lam on 2/6/22.
//

import Foundation

public class IdealDistanceCalculator {
    
    // For each subject, determine which target in the list has the most ideal distance based on
    // the derived class's determineAndAssignIdeal implementation
    func detemineIdealDistance(subject: Locatable, targets: [Locatable]) {
        for target in targets {
            let idealAddress = target.address
            // if its subject and target has same address, then its the nearest one
            if subject.address.sameAddressAs(idealAddress) {
                subject.assign(mostIdealLocatable: target, idealDistance: 0)
                break
            }
            else { // loops thru each lab and figure out the nearest lab
                let distanceBetweenSubjectAndTarget = distanceBetweenTwoAddresses(subject.address, target.address)
                determineAndAssignIdeal(subject: subject, target: target, oneWayDistanceBetweenSubjectAndTarget: distanceBetweenSubjectAndTarget)
            }
        } // for labs
    }
    
    // Get the distance between two addresses
    func distanceBetweenTwoAddresses( _ addr1: Address, _ addr2: Address) -> Int {
        return Int.random(in: 1...100)
    }
    
    func determineAndAssignIdeal(subject: Locatable, target: Locatable, oneWayDistanceBetweenSubjectAndTarget: Int) {
        // To be overloaded by derived classes
    }
}
