//
//  ClinicianTests.swift
//  NiceClinicianDriveCalculatorTests
//
//  Created by Josh Lam on 2/7/22.
//

import XCTest
@testable import NiceClinicianDriveCalculator

class ClinicianTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testClinicianConstruction() {
        let mockClinicianDecodedData = ClinicianDecodedData(aName: "Bob", anAddress: "4120 Garfield Ave, Minneapolis, MN 55409")
        let clinician = Clinician(mockClinicianDecodedData)
        XCTAssertEqual(clinician.name, "Bob")
        let addr = clinician.address
        XCTAssertEqual(addr.addressLine1, "4120 Garfield Ave")
        XCTAssertEqual(addr.city, "Minneapolis")
        XCTAssertEqual(addr.state, "MN")
        XCTAssertEqual(addr.zip, "55409")
    }
    
    func testAssign() {
        let mockLabDecodedData = LabDecodedData(aName: "Edina Lab", anAddress: "6525 France Ave, Edina, MN 55435")
        let lab = Lab(mockLabDecodedData)
        let mockClinicianDecodedData = ClinicianDecodedData(aName: "Bob", anAddress: "4120 Garfield Ave, Minneapolis, MN 55409")
        let clinician = Clinician(mockClinicianDecodedData)
        clinician.assign(mostIdealLocatable: lab, idealDistance: 10)
        guard let mostIdealLocatable = clinician.mostIdealLocatable() else {
            XCTFail("cannot get mostIdealLocatable")
            return
        }
        let nearestLab = mostIdealLocatable as! Lab
        XCTAssertEqual(nearestLab.name, "Edina Lab")
        XCTAssertEqual(clinician.mostIdealDistanceForLocatable(), 10)
        
    }

}
