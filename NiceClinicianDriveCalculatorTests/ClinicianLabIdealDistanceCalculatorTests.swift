//
//  ClinicianLabIdealDistanceCalculatorTests.swift
//  NiceClinicianDriveCalculatorTests
//
//  Created by Josh Lam on 2/7/22.
//

import XCTest
@testable import NiceClinicianDriveCalculator

class ClinicianLabIdealDistanceCalculatorTests: XCTestCase {
    
    var mockLab1: Lab { let mockLabDecodedData = LabDecodedData(aName: "Edina Lab", anAddress: "420 Garfield Ave, Minneapolis, MN 55409")
            let lab = Lab(mockLabDecodedData)
            return lab
        }
    var mockLab2: Lab { let mockLabDecodedData = LabDecodedData(aName: "Medical Arts Lab", anAddress: "835 Nicollet Mall, Minneapolis, MN 55402")
        let lab = Lab(mockLabDecodedData)
        return lab
    }
    
    var mockClinician1: Clinician {let mockClinicianDecodedData = ClinicianDecodedData(aName: "Bob", anAddress: "4120 Garfield Ave, Minneapolis, MN 55409")
        let clinician = Clinician(mockClinicianDecodedData)
        return clinician}
    
    var mockClinician2: Clinician {let mockClinicianDecodedData = ClinicianDecodedData(aName: "Joe", anAddress: "500 Garfield Ave, Minneapolis, MN 55409")
        let clinician = Clinician(mockClinicianDecodedData)
        return clinician}
    

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFindNearestLabsForClinicians() {
        let clincians = [mockClinician1, mockClinician2]
        let labs = [mockLab1, mockLab2]
        let clinicianIdealDistanceCal = ClinicianLabIdealDisanceCalculator()
        clinicianIdealDistanceCal.findNearestLabsForClinicians(clincians, labs: labs)
        XCTAssertNotNil(clincians[0].nearestLab)
        guard let distToNearestLab1 = clincians[0].distanceToNearestLab else {
            XCTFail("Distance not initialized")
            return
        }
        XCTAssertTrue(distToNearestLab1  > 0)
        XCTAssertNotNil(clincians[1].nearestLab)
        guard let distToNearestLab2 = clincians[1].distanceToNearestLab else {
            XCTFail("Distance not initialized")
            return
        }
        XCTAssertTrue(distToNearestLab2  > 0)
    }
    
    func testDetermineAndAssignIdeal() {
        let clinician = mockClinician1
        let lab1 = mockLab1
        let lab2 = mockLab2
        
        let clinicianIdealDistanceCal = ClinicianLabIdealDisanceCalculator()
        clinicianIdealDistanceCal.determineAndAssignIdeal(subject: clinician, target: lab1, oneWayDistanceBetweenSubjectAndTarget: 10)
        guard let nearestLab = clinician.nearestLab else {
            XCTFail("Expected a non nil lab")
            return
        }
        XCTAssertEqual(nearestLab.name, lab1.name)
        
        clinicianIdealDistanceCal.determineAndAssignIdeal(subject: clinician, target: lab2, oneWayDistanceBetweenSubjectAndTarget: 5)
        guard let nearestLab2 = clinician.nearestLab else {
            XCTFail("Expected a non nil lab")
            return
        }
        XCTAssertEqual(nearestLab2.name, lab2.name)
        
    }
    
    func testDetermineAndAssignIdeal2() {
        let clinician = mockClinician1
        let lab1 = mockLab1
        let lab2 = mockLab2
        
        let clinicianIdealDistanceCal = ClinicianLabIdealDisanceCalculator()
        clinicianIdealDistanceCal.determineAndAssignIdeal(subject: clinician, target: lab1, oneWayDistanceBetweenSubjectAndTarget: 10)
        guard let nearestLab = clinician.nearestLab else {
            XCTFail("Expected a non nil lab")
            return
        }
        XCTAssertEqual(nearestLab.name, lab1.name)
        
        clinicianIdealDistanceCal.determineAndAssignIdeal(subject: clinician, target: lab2, oneWayDistanceBetweenSubjectAndTarget: 25)
        guard let nearestLab2 = clinician.nearestLab else {
            XCTFail("Expected a non nil lab")
            return
        }
        XCTAssertEqual(nearestLab2.name, lab1.name)
        
    }
    
}
