//
//  PatientClinicianIdealDistanceCalculatorTests.swift
//  NiceClinicianDriveCalculatorTests
//
//  Created by Josh Lam on 2/8/22.
//

import XCTest
@testable import NiceClinicianDriveCalculator

class PatientClinicianIdealDistanceCalculatorTests: XCTestCase {
    
    var mockClinician1: Clinician {let mockClinicianDecodedData = ClinicianDecodedData(aName: "Bob", anAddress: "4120 Garfield Ave, Minneapolis, MN 55409")
        let clinician = Clinician(mockClinicianDecodedData)
        return clinician}
    
    var mockClinician2: Clinician {let mockClinicianDecodedData = ClinicianDecodedData(aName: "Joe", anAddress: "500 Garfield Ave, Minneapolis, MN 55409")
        let clinician = Clinician(mockClinicianDecodedData)
        return clinician}
    
    var mockPatient: Patient {
        let mockAddr = Address("3000 Garfield Ave, Minneapolis, MN 55409")
        let patient = Patient(addr: mockAddr, needLab: false)
        return patient
    }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testNearestVisitingClinicianTotalDistanceNoLab() throws {
        let patient = mockPatient
        let clinician = mockClinician1
        clinician.distanceToNearestLab = 5
        patient.includeLab = true
        patient.idealClinician = clinician
        let mockDistance = 10
        let patientClinicianIdealDistCal = PatientClinicianIdealDistanceCalculator()
        let distanceWithoutLab = patientClinicianIdealDistCal.nearestVisitingClinicianTotalDistance(patient: patient, oneWayDistanceBetweenPatientAndClinician: mockDistance)
        let expectedDistance = 30
        XCTAssertEqual(distanceWithoutLab, expectedDistance)
    }

    func testNearestVisitingClinicianTotalDistanceIncludeLab() throws {
        let patient = mockPatient
        let clinician = mockClinician1
        clinician.distanceToNearestLab = 5
        patient.includeLab = true
        patient.idealClinician = clinician
        let mockDistance = 10
        let patientClinicianIdealDistCal = PatientClinicianIdealDistanceCalculator()
        let distanceWithLab = patientClinicianIdealDistCal.nearestVisitingClinicianTotalDistance(patient: patient, oneWayDistanceBetweenPatientAndClinician: mockDistance)
        let expectedDistance = 30
        XCTAssertEqual(distanceWithLab, expectedDistance)
    }

    func testDetermineAndAssignIdeal() throws {
        let patient = mockPatient
        let clinician1 = mockClinician1
        clinician1.distanceToNearestLab = 10
        let clinician2 = mockClinician2
        clinician2.distanceToNearestLab = 5
        
        let patientClinicianIdealDistCal = PatientClinicianIdealDistanceCalculator()
        patientClinicianIdealDistCal.determineAndAssignIdeal(subject: patient, target: clinician1, oneWayDistanceBetweenSubjectAndTarget: 20)
        guard let nearestClinician = patient.idealClinician else {
            XCTFail("Non Nil Clinician expected")
            return
        }
        XCTAssertEqual(nearestClinician.name, clinician1.name)
        patientClinicianIdealDistCal.determineAndAssignIdeal(subject: patient, target: clinician2, oneWayDistanceBetweenSubjectAndTarget: 5)
        guard let nearestClinician2 = patient.idealClinician else {
            XCTFail("Non Nil Clinician expected")
            return
        }
        XCTAssertEqual(nearestClinician2.name, clinician2.name)
    }
    
    func testDetermineClinician() throws {
        let patient = mockPatient
        let clinician1 = mockClinician1
        clinician1.distanceToNearestLab = 10
        let clinician2 = mockClinician2
        clinician2.distanceToNearestLab = 5
        let clinicians = [clinician1, clinician2]
        
        let patientClinicianIdealDistCal = PatientClinicianIdealDistanceCalculator()
        patientClinicianIdealDistCal.detemineIdealDistance(subject: patient, targets: clinicians)
        guard let _ = patient.idealClinician else {
            XCTFail("Non Nil Clinician expected")
            return
        }
        guard let distance = patient.mostIdealDistanceForClinician else {
            XCTFail("Non Nil Distance expected")
            return
        }
        XCTAssertTrue(distance > 0)
        
    }
}
