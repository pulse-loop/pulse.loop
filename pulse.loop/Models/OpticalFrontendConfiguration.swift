//
//  OpticalFrontendConfiguration.swift
//  pulse.loop
//
//  Created by Riccardo Persello on 03/11/22.
//

import Foundation

struct OpticalFrontendConfiguration {
    struct LEDPhase {
        var led_st: TimeInterval = 0
        var led_end: TimeInterval = 0
        var sample_st: TimeInterval = 0
        var sample_end: TimeInterval = 0
        var reset_st: TimeInterval = 0
        var reset_end: TimeInterval = 0
        var conv_st: TimeInterval = 0
        var conv_end: TimeInterval = 0
    }
    
    struct AmbientPhase {
        var sample_st: TimeInterval = 0
        var sample_end: TimeInterval = 0
        var reset_st: TimeInterval = 0
        var reset_end: TimeInterval = 0
        var conv_st: TimeInterval = 0
        var conv_end: TimeInterval = 0
    }
    
    struct DynamicPowerDownPhase {
        var start: TimeInterval = 0
        var end: TimeInterval = 0
    }
    
    enum TIAResistor: Int, CustomStringConvertible, CaseIterable, Equatable {
        case R_2_MΩ = 7
        case R_1_MΩ = 6
        case R_500_kΩ = 0
        case R_250_kΩ = 1
        case R_100_kΩ = 2
        case R_50_kΩ = 3
        case R_25_kΩ = 4
        case R_10_kΩ = 5

        var description: String {
            switch self {
            case .R_500_kΩ: return "500 kΩ"
            case .R_250_kΩ: return "250 kΩ"
            case .R_100_kΩ: return "100 kΩ"
            case .R_50_kΩ: return "50 kΩ"
            case .R_25_kΩ: return "25 kΩ"
            case .R_10_kΩ: return "10 kΩ"
            case .R_1_MΩ: return "1 MΩ"
            case .R_2_MΩ: return "2 MΩ"
            }
        }
    }
    
    enum TIACapacitor: Int, CustomStringConvertible, CaseIterable, Equatable {
        case C_2_5_pF = 1
        case C_5_pF = 0
        case C_7_5_pF = 3
        case C_10_pF = 2
        case C_17_5_pF = 5
        case C_20_pF = 4
        case C_22_5_pF = 7
        case C_25_pF = 6

        var description: String {
            switch self {
            case .C_5_pF: return "5 pF"
            case .C_2_5_pF: return "2.5 pF"
            case .C_10_pF: return "10 pF"
            case .C_7_5_pF: return "7.5 pF"
            case .C_20_pF: return "20 pF"
            case .C_17_5_pF: return "17.5 pF"
            case .C_25_pF: return "25 pF"
            case .C_22_5_pF: return "22.5 pF"
            }
        }
    }
    
    var ambientPhase: AmbientPhase = AmbientPhase()
    var LED1Phase: LEDPhase = LEDPhase()
    var LED2Phase: LEDPhase = LEDPhase()
    var LED3Phase: LEDPhase = LEDPhase()
    var totalWindowLength: TimeInterval = 0
    var dynamicPowerDown: DynamicPowerDownPhase = DynamicPowerDownPhase()
    var tiaCapacitor1: TIACapacitor = .C_5_pF
    var tiaCapacitor2: TIACapacitor = .C_5_pF
    var tiaResistor1: TIAResistor = .R_2_MΩ
    var tiaResistor2: TIAResistor = .R_2_MΩ
}

extension TimeInterval {
    init(microseconds: Int) {
        self = Double(microseconds) / 1_000_000
    }
    
    init(milliseconds: Int) {
        self = Double(milliseconds) / 1000
    }
}
