//
//  ClinicanDisplayViewModelTests.swift
//  NiceClinicianDriveCalculatorTests
//
//  Created by Josh Lam on 2/8/22.
//

import XCTest
@testable import NiceClinicianDriveCalculator

class ClinicanDisplayViewModelTests: XCTestCase {

    var mockPatient: Patient {
        let mockAddr = Address("3000 Garfield Ave, Minneapolis, MN 55409")
        let patient = Patient(addr: mockAddr, needLab: false)
        return patient
    }
    
    var mockClinician: Clinician {let mockClinicianDecodedData = ClinicianDecodedData(aName: "Bob", anAddress: "4120 Garfield Ave, Minneapolis, MN 55409")
        let clinician = Clinician(mockClinicianDecodedData)
        return clinician}
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testConstruction() throws {
        let patient = mockPatient
        let clinician = mockClinician
        patient.idealClinician = clinician
        patient.mostIdealDistanceForClinician = 10
        patient.includeLab = false
        let vm = ClinicianDisplayViewModel(patient: patient)
        XCTAssertTrue(vm.includeLab == false)
        XCTAssertEqual(vm.patientAddress, patient.address.addressString())
        XCTAssertTrue(vm.idealClinicianFound == true)
        XCTAssertEqual(vm.idealClinicianName, clinician.name)
    }
    
    func testIncludeLabNo() throws {
        let patient = mockPatient
        let clinician = mockClinician
        patient.idealClinician = clinician
        patient.mostIdealDistanceForClinician = 10
        patient.includeLab = false
        let vm = ClinicianDisplayViewModel(patient: patient)
        XCTAssertEqual(vm.labInclude(), "No")
    }

    func testIncludeLabYes() throws {
        let patient = mockPatient
        let clinician = mockClinician
        patient.idealClinician = clinician
        patient.mostIdealDistanceForClinician = 10
        patient.includeLab = true
        let vm = ClinicianDisplayViewModel(patient: patient)
        XCTAssertEqual(vm.labInclude(), "Yes")
    }
}
