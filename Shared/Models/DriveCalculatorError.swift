//
//  DriveCalculatorError.swift
//  NiceClinicianDriveCalculator (iOS)
//
//  Created by Josh Lam on 2/7/22.
//

import Foundation

enum DriveCalculatorError: Error, LocalizedError {
    case labFileReadError
    case clinicianFileReadError
    case labDecodingError
    case clinicianDecodingError
    case formAddressLine1Error
    case formCityError
    case formStateError
    case formZipError
    case unknownError
    
    var errorDescription: String? {
        switch self {
        case.labFileReadError:
            return NSLocalizedString("Problem reading labs file. Reinstall the app", comment: "")
        case.clinicianFileReadError:
            return NSLocalizedString("Problem reading clinicians file. Reinstall the app", comment: "")
        case .labDecodingError:
            return NSLocalizedString("Problem decoding labs file. Reinstall the app", comment: "")
        case .clinicianDecodingError:
            return NSLocalizedString("Problem decoding clinician file. Reinstall the app", comment: "")
        case .formAddressLine1Error:
            return NSLocalizedString("Address Line 1 cannot be empty", comment: "")
        case .formCityError:
            return NSLocalizedString("City cannot be empty", comment: "")
        case .formStateError:
            return NSLocalizedString("A State needs to be selected", comment: "")
        case .formZipError:
            return NSLocalizedString("A Zip needs to be a numeric 5 digit number", comment: "")
        case .unknownError:
            return NSLocalizedString("Unknown Error", comment: "")
        }
    }
}

struct ErrorType: Identifiable {
    let id = UUID()
    let error: DriveCalculatorError
}
