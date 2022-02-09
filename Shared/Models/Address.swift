//
//  Address.swift
//  NiceClinicianDriveCalculator (iOS)
//
//  Created by Josh Lam on 2/6/22.
//

import Foundation

public class Address {
    
    let addressLine1: String
    let city: String
    let state: String
    let zip: String
    
    public init(_ addr: String) {
        let addrComponents = addr.components(separatedBy: ",")
        addressLine1 = addrComponents[0].trimmingCharacters(in: .whitespacesAndNewlines)
        city = addrComponents[1].trimmingCharacters(in: .whitespacesAndNewlines)
        
        let stateNZipComponents = addrComponents[2].trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: " ")
        state = stateNZipComponents[0].trimmingCharacters(in: .whitespacesAndNewlines)
        zip = stateNZipComponents[1].trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    public init(addressLine1: String, city: String, state: String, zip: String) {
        self.addressLine1 = addressLine1
        self.city = city
        self.state = state
        self.zip = zip
    }
    
    
    func printAddr() {
        print("Address: \(addressLine1) \(city) \(state) \(zip)")
    }
    
    func addressString() -> String {
        return addressLine1 + " " + city + " " + state + " " + zip
    }
    
    
    public func sameAddressAs( _ from: Address) -> Bool {
        guard addressLine1 == from.addressLine1 && zip == from.zip && city == from.city && state == from.state else {
            return false
        }
        return true
    }
}
