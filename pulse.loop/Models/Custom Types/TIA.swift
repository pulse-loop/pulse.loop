//
//  TIA.swift
//  pulse.loop
//
//  Created by Riccardo Persello on 05/11/22.
//

import Foundation

enum TIAResistor: UInt8, CustomStringConvertible, CaseIterable, Equatable {
    case r10kΩ = 5
    case r25kΩ = 4
    case r50kΩ = 3
    case r100kΩ = 2
    case r250kΩ = 1
    case r500kΩ = 0
    case r1MΩ = 6
    case r2MΩ = 7

    var description: String {
        switch self {
        case .r500kΩ: return "500 kΩ"
        case .r250kΩ: return "250 kΩ"
        case .r100kΩ: return "100 kΩ"
        case .r50kΩ: return "50 kΩ"
        case .r25kΩ: return "25 kΩ"
        case .r10kΩ: return "10 kΩ"
        case .r1MΩ: return "1 MΩ"
        case .r2MΩ: return "2 MΩ"
        }
    }
}

enum TIACapacitor: UInt8, CustomStringConvertible, CaseIterable, Equatable {
    case c2p5F = 1
    case c5pF = 0
    case c7p5F = 3
    case c10pF = 2
    case c17p5F = 5
    case c20pF = 4
    case c22p5F = 7
    case c25pF = 6

    var description: String {
        switch self {
        case .c5pF: return "5 pF"
        case .c2p5F: return "2.5 pF"
        case .c10pF: return "10 pF"
        case .c7p5F: return "7.5 pF"
        case .c20pF: return "20 pF"
        case .c17p5F: return "17.5 pF"
        case .c25pF: return "25 pF"
        case .c22p5F: return "22.5 pF"
        }
    }
}
