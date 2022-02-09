//
//  Proxy.swift
//  NiceClinicianDriveCalculator (iOS)
//
//  Created by Josh Lam on 2/6/22.
//

import Foundation

protocol Locatable {
    var name: String { get }
    var address: Address { get }
    func mostIdealDistanceForLocatable() -> Int?
    func mostIdealLocatable() -> Locatable?
    func assign(mostIdealLocatable: Locatable, idealDistance: Int)
    
}
