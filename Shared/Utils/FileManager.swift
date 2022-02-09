//
//  FileManager.swift
//  NiceClinicianDriveCalculator (iOS)
//
//  Created by Josh Lam on 2/6/22.
//

import Foundation

public class FileManager {
    func dataFromJSONFile(fileName name: String) -> Data? {
        do {
            if let filePath = Bundle.main.path(forResource: name, ofType: "json") {
                let fileUrl = URL(fileURLWithPath: filePath)
                let data = try Data(contentsOf: fileUrl)
                return data
            }
        } catch {
            print("Error while trying to read file \(name) : \(error)")
        }
        return nil
    }
}
