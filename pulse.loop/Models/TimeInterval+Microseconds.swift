//
//  TimeInterval+Microseconds.swift
//  pulse.loop
//
//  Created by Riccardo Persello on 05/11/22.
//

import Foundation

extension Float32 {
    init(microseconds: Double) {
        self = Float(microseconds)
    }
    
    init(milliseconds: Double) {
        self = Float(milliseconds) * 1_000
    }
    
    static let microsecondsFormatter: NumberFormatter = {
        let f = NumberFormatter()
        f.minimumSignificantDigits = 6
        f.multiplier = 1
        
        // MEH...
        f.numberStyle = .percent
        f.percentSymbol = " µs"
        return f
    }()
}
