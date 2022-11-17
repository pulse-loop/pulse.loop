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
    
    init(value: Float32, date: Date = Date.now) {
        self.value = Double(value)
        self.date = date
    }
}
