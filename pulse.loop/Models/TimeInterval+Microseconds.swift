//
//  TimeInterval+Microseconds.swift
//  pulse.loop
//
//  Created by Riccardo Persello on 05/11/22.
//

import Foundation

extension TimeInterval {
    init(microseconds: Double) {
        self = Double(microseconds) / 1_000_000
    }
    
    init(milliseconds: Double) {
        self = Double(milliseconds) / 1000
    }
    
    static let microsecondsFormatter: NumberFormatter = {
        let f = NumberFormatter()
        f.minimumSignificantDigits = 6
        f.multiplier = 1_000_000
        
        // MEH...
        f.numberStyle = .percent
        f.percentSymbol = " µs"
        return f
    }()
}
