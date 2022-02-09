//
//  LabTests.swift
//  NiceClinicianDriveCalculatorTests
//
//  Created by Josh Lam on 2/7/22.
//

import XCTest
@testable import NiceClinicianDriveCalculator

class LabTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLabConstructor() {
        let mockLabDecodedData = LabDecodedData(aName: "Edina Lab", anAddress: "4120 Garfield Ave, Minneapolis, MN 55409")
        let lab = Lab(mockLabDecodedData)
        XCTAssertEqual(lab.name, "Edina Lab")
        let addr = lab.address
        XCTAssertEqual(addr.addressLine1, "4120 Garfield Ave")
        XCTAssertEqual(addr.city, "Minneapolis")
        XCTAssertEqual(addr.state, "MN")
        XCTAssertEqual(addr.zip, "55409")
    }
}
