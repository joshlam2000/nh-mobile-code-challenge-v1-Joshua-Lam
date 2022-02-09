//
//  AddressTest.swift
//  Tests iOS
//
//  Created by Josh Lam on 2/7/22.
//

import XCTest
@testable import NiceClinicianDriveCalculator

class AddressTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testAddressConstructorStringInput() throws {
        let addr = Address("4120 Garfield Ave, Minneapolis, MN 55409")
        XCTAssertEqual(addr.addressLine1, "4120 Garfield Ave")
        XCTAssertEqual(addr.city, "Minneapolis")
        XCTAssertEqual(addr.state, "MN")
        XCTAssertEqual(addr.zip, "55409")
    }

    func testAddressConstructorPartsInput() throws {
        let addr = Address(addressLine1: "4120 Garfield Ave", city: "Minneapolis", state: "MN", zip: "55409")
        XCTAssertEqual(addr.addressLine1, "4120 Garfield Ave")
        XCTAssertEqual(addr.city, "Minneapolis")
        XCTAssertEqual(addr.state, "MN")
        XCTAssertEqual(addr.zip, "55409")
    }
    
    func testSameAddress() {
        let addr1 = Address("4120 Garfield Ave, Minneapolis, MN 55409")
        let addr2 = Address(addressLine1: "4120 Garfield Ave", city: "Minneapolis", state: "MN", zip: "55409")
        XCTAssertTrue(addr1.sameAddressAs(addr2))
    }

}
