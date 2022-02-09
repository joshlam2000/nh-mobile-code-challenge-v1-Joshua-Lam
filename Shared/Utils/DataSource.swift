//
//  DataSource.swift
//  NiceClinicianDriveCalculator (iOS)
//
//  Created by Josh Lam on 2/7/22.
//

import Foundation

public class DataSource {
    
    public static func retrieveAllClinicians() throws -> [Clinician] {
        let fileManager = FileManager()
        var allAvailableClinicians = [Clinician]()
        if let clinicianData = fileManager.dataFromJSONFile(fileName: "clinicians") {
            let decoder = JSONDecoder()
            do {
                let clinicians = try decoder.decode(Array<ClinicianDecodedData>.self, from: clinicianData)
                for doc in clinicians {
                    allAvailableClinicians.append(Clinician(doc))
                }
            }
            catch {
                print("Error during decoding of clinicians: \(error)")
                throw DriveCalculatorError.clinicianDecodingError
            }
        }
        else {
            throw DriveCalculatorError.clinicianFileReadError
        }
        return allAvailableClinicians
    }
    
    public static func retrieveAllLabs() throws -> [Lab] {
        let fileManager = FileManager()
        var allAvailableLabs = [Lab]()
        if let labsData = fileManager.dataFromJSONFile(fileName: "labs") {
            let decoder = JSONDecoder()
            do {
                let labs = try decoder.decode(Array<LabDecodedData>.self, from: labsData)
                for lab in labs {
                    allAvailableLabs.append(Lab(lab))
                }
            }
            catch {
                print("Error during decoding of labs: \(error)")
                throw DriveCalculatorError.labDecodingError
            }
        }
        else {
            throw DriveCalculatorError.labFileReadError
        }
        return allAvailableLabs
    }
}
