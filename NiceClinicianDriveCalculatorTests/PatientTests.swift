//
//  PatientTests.swift
//  NiceClinicianDriveCalculatorTests
//
//  Created by Josh Lam on 2/7/22.
//

import XCTest
@testable import NiceClinicianDriveCalculator

class PatientTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    func testPatientConstructorDoNotIncludeLab() {
        let mockAddr = Address("4120 Garfield Ave, Minneapolis, MN 55409")
        let patient = Patient(addr: mockAddr, needLab: false)
        XCTAssertEqual(patient.includeLab, false)
        let addr = patient.address
        XCTAssertEqual(addr.addressLine1, "4120 Garfield Ave")
        XCTAssertEqual(addr.city, "Minneapolis")
        XCTAssertEqual(addr.state, "MN")
        XCTAssertEqual(addr.zip, "55409")
    }

    func testPatientConstructorIncludeLab() {
        let mockAddr = Address("4120 Garfield Ave, Minneapolis, MN 55409")
        let patient = Patient(addr: mockAddr, needLab: true)
        XCTAssertEqual(patient.includeLab, true)
        let addr = patient.address
        XCTAssertEqual(addr.addressLine1, "4120 Garfield Ave")
        XCTAssertEqual(addr.city, "Minneapolis")
        XCTAssertEqual(addr.state, "MN")
        XCTAssertEqual(addr.zip, "55409")
    }

}
