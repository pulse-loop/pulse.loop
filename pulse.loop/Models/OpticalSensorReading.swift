//
//  OpticalSensorReading.swift
//  pulse.loop
//
//  Created by Riccardo Persello on 24/10/22.
//

import Foundation

struct OpticalSensorReading: Identifiable {
    var date: Date
    var value: Int32
    
    var id: Date {
        return date
    }

    init(_ value: Int32) {
        self.value = value
        self.date = Date.now
    }
}
