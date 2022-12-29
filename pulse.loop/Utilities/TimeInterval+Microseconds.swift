//
//  TimeInterval+Microseconds.swift
//  pulse.loop
//
//  Created by Riccardo Persello on 05/11/22.
//

import Foundation

extension Float32 {
    init(microseconds: Double) {
        self = Float32(microseconds / 1_000_000)
    }
    
    init(milliseconds: Double) {
        self = Float32(milliseconds / 1_000)
    }
    
    static let microsecondsFormatter: NumberFormatter = {
        let f = NumberFormatter()
        f.maximumFractionDigits = 2
        f.multiplier = 1_000_000
        
        // MEH...
        f.numberStyle = .percent
        f.percentSymbol = " µs"
        return f
    }()
}
