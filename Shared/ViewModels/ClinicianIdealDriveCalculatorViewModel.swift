//
//  ClinicianIdealDriveCalculatorViewModel.swift
//  NiceClinicianDriveCalculator (iOS)
//
//  Created by Josh Lam on 2/6/22.
//

import Foundation

public class ClinicianIdealDriveCalculatorViewModel: ObservableObject {
    
    enum USStates: String, CaseIterable, Identifiable {
        case empty = " "
        case CO
        case MN
        case WI
        
        var id: String {self.rawValue}
    }
    
    @Published var address1: String = ""
    @Published var city: String = ""
    @Published var state: USStates = .empty
    @Published var zip: String = ""
    @Published var includeLab: Bool = false
    @Published var isPresented = false
    @Published var appError: ErrorType? = nil
    
    var labsByState = [String:[Lab]]()
    var clinicianByState = [String:[Clinician]]()
    var allAvailableLabs = [Lab]()
    var allAvailableClinicians = [Clinician]()
    
    public init() {
        self.reset()
    }
    
    public func reset() {
        self.address1 = ""
        self.city = ""
        self.state = .empty
        self.zip = ""
        self.includeLab = false
        self.isPresented = false
        self.appError = nil
    }
    
    // Determine the ideal clinican given patient info from form
    public func determineMostIdealClinicianForPatient() -> Patient {
        let patient = Patient(addr: patientAddress(), needLab: self.includeLab)
        let patientAddrState = patient.address.state
        if let allClinicianInPatientState = clinicianByState[patientAddrState] {
           let pc = PatientClinicianIdealDistanceCalculator()
            pc.detemineIdealDistance(subject: patient, targets: allClinicianInPatientState)
        }
        return patient
    }
    
    // Validate the form entries
    public func validateForm()  {
        if let anError = validateFormFields() {
            appError = ErrorType(error: anError)
        }
    }
    
    // Check each form entry
    private func validateFormFields() -> DriveCalculatorError? {
        if (address1.isEmpty) {
            return DriveCalculatorError.formAddressLine1Error
        }
        if (city.isEmpty) {
            return DriveCalculatorError.formCityError
        }
        if (state.rawValue == " ") {
            return DriveCalculatorError.formStateError
        }
        if ((zip.isEmpty) || (zip.count != 5) || (!zip.isInt)) {
            return DriveCalculatorError.formZipError
        }
        return nil
    }
    
    private func patientAddress() -> Address {
        return Address(addressLine1: self.address1, city: self.city, state: self.state.rawValue, zip: self.zip)
    }
    
    // Setup the models for the viewModel
    public func setup() -> Void {
        do {
            allAvailableLabs = try DataSource.retrieveAllLabs()
            allAvailableClinicians = try DataSource.retrieveAllClinicians()
            setupLabByState()
            setupClinicanByState()
            determineNearestLabForEachClinician()
        }
        catch DriveCalculatorError.labFileReadError {
            appError = ErrorType(error: .labFileReadError)
        }
        catch DriveCalculatorError.clinicianFileReadError {
            appError = ErrorType(error: .clinicianFileReadError)
        }
        catch DriveCalculatorError.labDecodingError {
            appError = ErrorType(error: .labDecodingError)
        }
        catch DriveCalculatorError.clinicianDecodingError {
            appError = ErrorType(error: .clinicianDecodingError)
        }
        catch {
            appError = ErrorType(error: .unknownError)
        }
    }
    
    // Group clinicians by state
    func setupClinicanByState() {
        for clinician in allAvailableClinicians {
            if let clinitiansInState = clinicianByState[clinician.address.state] {
                var allClinicianInState = clinitiansInState
                allClinicianInState.append(clinician)
                clinicianByState[clinician.address.state] = allClinicianInState
            }
            else {
                var allClinicianInState = [Clinician]()
                allClinicianInState.append(clinician)
                clinicianByState[clinician.address.state] = allClinicianInState
            }
        } // for clinicians
    }
    
    // Group labs by state
    func setupLabByState() {
        for lab in allAvailableLabs {
            let state = lab.address.state
            if let allLabsInState = labsByState[state] {
                var allLabsInStateVar = allLabsInState
                allLabsInStateVar.append(lab)
                labsByState[state] = allLabsInStateVar
            }
            else {
                var allLabsInState = [Lab]()
                allLabsInState.append(lab)
                labsByState[lab.address.state] = allLabsInState
            }
        } // for labs
    }
    
    // Run thru every clinican to determine the nearest lab for each clinician
    func determineNearestLabForEachClinician() {
        let clinicianLabDistCal = ClinicianLabIdealDisanceCalculator()
        for state in clinicianByState.keys {
            if let clinicians = clinicianByState[state] {
               if let labs = labsByState[state] {
                   clinicianLabDistCal.findNearestLabsForClinicians(clinicians, labs: labs)
               }
               else { // if there is no labs in state, look for the next nearest lab in other states for poor clinicans
                   //findAndAssignNearestNeighborItem2(clinicians, fromNeighborItems: allAvailableLabs)
                   // TODO: post MVP
               }
            }
        }
    }
    
}
