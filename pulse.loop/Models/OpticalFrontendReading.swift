//
//  OpticalFrontendReading.swift
//  pulse.loop
//
//  Created by Riccardo Persello on 15/11/22.
//

import Foundation

struct OpticalFrontendReading {
    let value: Double
    let date: Date
    
    init(value: Double, date: Date = Date.now) {
        self.value = value
        self.date = date
    }
}
