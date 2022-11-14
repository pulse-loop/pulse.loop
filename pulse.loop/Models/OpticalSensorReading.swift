//
//  OpticalSensorReading.swift
//  pulse.loop
//
//  Created by Riccardo Persello on 24/10/22.
//

import Foundation
import SwiftUICharts

struct OpticalSensorReading: Identifiable {
    var date: Date
    var value: Float32
    
    var id: Date {
        return date
    }

    init(_ value: Float32) {
        self.value = value
        self.date = Date.now
    }
}
