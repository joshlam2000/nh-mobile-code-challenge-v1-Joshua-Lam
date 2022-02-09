//
//  ClinicianIdelDrivingCalculatorViewModelTests.swift
//  NiceClinicianDriveCalculatorTests
//
//  Created by Josh Lam on 2/8/22.
//

import XCTest
@testable import NiceClinicianDriveCalculator

class ClinicianIdealDrivingCalculatorViewModelTests: XCTestCase {
    
    let mockAddress1 = "4 Garfield Ave"
    let mockCity = "Some City"
    let mockZip  = "55409"
    let mockState: ClinicianIdealDriveCalculatorViewModel.USStates = .MN
    let emptyState: ClinicianIdealDriveCalculatorViewModel.USStates = .empty
    
    var mockViewModel: ClinicianIdealDriveCalculatorViewModel {
        let viewModel = ClinicianIdealDriveCalculatorViewModel()
        viewModel.includeLab = false
        viewModel.address1 = mockAddress1
        viewModel.city = mockCity
        viewModel.zip = mockZip
        viewModel.state = mockState
        return viewModel
    }
    
    var mockLab1: Lab { let mockLabDecodedData = LabDecodedData(aName: "Edina Lab", anAddress: "420 Garfield Ave, Minneapolis, MN 55409")
            let lab = Lab(mockLabDecodedData)
            return lab
        }
    var mockLab2: Lab { let mockLabDecodedData = LabDecodedData(aName: "Medical Arts Lab", anAddress: "835 Nicollet Mall, Minneapolis, MN 55402")
        let lab = Lab(mockLabDecodedData)
        return lab
    }
    
    var mockLab3: Lab { let mockLabDecodedData = LabDecodedData(aName: "Hudson Lab", anAddress: "400 2nd St S, Hudson, WI 54016")
        let lab = Lab(mockLabDecodedData)
        return lab
    }
    
    var mockClinician1: Clinician {let mockClinicianDecodedData = ClinicianDecodedData(aName: "Bob", anAddress: "4120 Garfield Ave, Minneapolis, MN 55409")
        let clinician = Clinician(mockClinicianDecodedData)
        return clinician}
    
    var mockClinician2: Clinician {let mockClinicianDecodedData = ClinicianDecodedData(aName: "Joe", anAddress: "500 Garfield Ave, Minneapolis, MN 55409")
        let clinician = Clinician(mockClinicianDecodedData)
        return clinician}
    
    var mockClinician3: Clinician {let mockClinicianDecodedData = ClinicianDecodedData(aName: "Mary", anAddress: "608 Spruce Dr, Hudson, WI 54016")
        let clinician = Clinician(mockClinicianDecodedData)
        return clinician}
    
    var mockPatient1: Patient {
        let mockAddr = Address("3000 Garfield Ave, Minneapolis, MN 55409")
        let patient = Patient(addr: mockAddr, needLab: false)
        return patient
    }
    
    var mockPatient2: Patient {
        let mockAddr = Address("4912 3rd St S, Hudson, WI 54016")
        let patient = Patient(addr: mockAddr, needLab: false)
        return patient
    }
    

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testConstruction() throws {
        let viewModel = mockViewModel
        XCTAssertEqual(viewModel.address1, mockAddress1)
        XCTAssertEqual(viewModel.city, mockCity)
        XCTAssertEqual(viewModel.zip, mockZip)
        XCTAssertEqual(viewModel.state, mockState)
    }

    func testReset() throws {
        let viewModel = mockViewModel
        viewModel.reset()
        XCTAssertEqual(viewModel.address1, "")
        XCTAssertEqual(viewModel.city, "")
        XCTAssertEqual(viewModel.zip, "")
        XCTAssertEqual(viewModel.state, emptyState)
    }
    
    func testValidateForm() throws {
        let viewModel = ClinicianIdealDriveCalculatorViewModel()
        viewModel.reset()
        viewModel.validateForm()
        XCTAssertNotNil(viewModel.appError)
        XCTAssertEqual(viewModel.appError?.error, DriveCalculatorError.formAddressLine1Error)
        
        viewModel.appError = nil
        viewModel.address1 = "123 Main"
        viewModel.validateForm()
        XCTAssertNotNil(viewModel.appError)
        XCTAssertEqual(viewModel.appError?.error, DriveCalculatorError.formCityError)
        
        viewModel.appError = nil
        viewModel.city = "A City"
        viewModel.validateForm()
        XCTAssertNotNil(viewModel.appError)
        XCTAssertEqual(viewModel.appError?.error, DriveCalculatorError.formStateError)
        
        viewModel.appError = nil
        viewModel.state = mockState
        viewModel.validateForm()
        XCTAssertNotNil(viewModel.appError)
        XCTAssertEqual(viewModel.appError?.error, DriveCalculatorError.formZipError)
        
        viewModel.appError = nil
        viewModel.zip = "ABCDE"
        viewModel.validateForm()
        XCTAssertNotNil(viewModel.appError)
        XCTAssertEqual(viewModel.appError?.error, DriveCalculatorError.formZipError)
        
        viewModel.appError = nil
        viewModel.zip = "123"
        viewModel.validateForm()
        XCTAssertNotNil(viewModel.appError)
        XCTAssertEqual(viewModel.appError?.error, DriveCalculatorError.formZipError)
        
        viewModel.appError = nil
        viewModel.zip = "123001"
        viewModel.validateForm()
        XCTAssertNotNil(viewModel.appError)
        XCTAssertEqual(viewModel.appError?.error, DriveCalculatorError.formZipError)
        
        viewModel.appError = nil
        viewModel.zip = mockZip
        viewModel.validateForm()
        XCTAssertNil(viewModel.appError)
    }
    
    public func testSetUpLabsByState() throws {
        let labs = [mockLab1, mockLab2, mockLab3]
        let viewModel = ClinicianIdealDriveCalculatorViewModel()
        viewModel.allAvailableLabs = labs
        viewModel.setupLabByState()
        let labsByState = viewModel.labsByState
        
        XCTAssertTrue(labsByState.keys.count > 0)
        XCTAssertTrue(labsByState.keys.count == 2)
        
        guard let labsInMN = labsByState["MN"] else {
            XCTFail("Expected labs in MN")
            return
        }
        XCTAssertEqual(labsInMN.count, 2)
        
        guard let labsInWI = labsByState["WI"] else {
            XCTFail("Expected labs in WI")
            return
        }
        XCTAssertEqual(labsInWI.count, 1)
    }
    
    public func testSetUpClinicianByState() throws {
        let clinicians = [mockClinician1, mockClinician2, mockClinician3]
        let viewModel = ClinicianIdealDriveCalculatorViewModel()
        viewModel.allAvailableClinicians = clinicians
        viewModel.setupClinicanByState()
        let cliniciansByState = viewModel.clinicianByState
        
        XCTAssertTrue(cliniciansByState.keys.count > 0)
        XCTAssertTrue(cliniciansByState.keys.count == 2)
        
        guard let cliniciansInMN = cliniciansByState["MN"] else {
            XCTFail("Expected clinicans in MN")
            return
        }
        XCTAssertEqual(cliniciansInMN.count, 2)
        
        guard let cliniciansInWI = cliniciansByState["WI"] else {
            XCTFail("Expected clinicians in WI")
            return
        }
        XCTAssertEqual(cliniciansInWI.count, 1)
    }
        
    public func testSetup() throws {
        let viewModel = ClinicianIdealDriveCalculatorViewModel()
        viewModel.setup()
        XCTAssertNil(viewModel.appError)
        XCTAssertTrue(viewModel.allAvailableClinicians.count > 0)
        XCTAssertTrue(viewModel.allAvailableLabs.count > 0)
        XCTAssertTrue(viewModel.clinicianByState.count > 0)
        XCTAssertTrue(viewModel.labsByState.count > 0)
    }
    
    public func testDetermineLabsToNearestClinicians() throws {
        let viewModel = ClinicianIdealDriveCalculatorViewModel()
        viewModel.setup()
        XCTAssertNil(viewModel.appError)
        let allClinicians = viewModel.allAvailableClinicians
        XCTAssertTrue(allClinicians.count > 0)
        for clinician in allClinicians {
            guard let _ = clinician.nearestLab, let _ = clinician.distanceToNearestLab else {
                XCTFail("Lab not assigned to clinician: \(clinician.name) whose address is: \(clinician.address.addressString())")
               return
           }
        }
    }
    
    public func testDetermineMostIdealClinicianForPatient() throws {
        let viewModel = ClinicianIdealDriveCalculatorViewModel()
        viewModel.includeLab = false
        viewModel.address1 = mockAddress1
        viewModel.city = mockCity
        viewModel.zip = mockZip
        viewModel.state = mockState
        viewModel.setup()
        
        let patientMN = viewModel.determineMostIdealClinicianForPatient()
        guard let clinicianMN = patientMN.idealClinician else {
            XCTFail("Expected clinician from MN but got none")
            return
        }
        XCTAssertEqual(patientMN.address.state, clinicianMN.address.state)
        
        viewModel.address1 = "123 Main"
        viewModel.city = "Madison"
        viewModel.state = .WI
        viewModel.zip = "54016"
        
        let patientWI = viewModel.determineMostIdealClinicianForPatient()
        guard let clinicianWI = patientWI.idealClinician else {
            XCTFail("Expected clinician from WI but got none")
            return
        }
        XCTAssertEqual(patientWI.address.state, clinicianWI.address.state)
        
    }
}
