//
//  OpticalFrontendConfiguration.swift
//  pulse.loop
//
//  Created by Riccardo Persello on 03/11/22.
//

import Foundation

class OpticalFrontendConfiguration: ObservableObject {
    class LEDPhase: ObservableObject {
        @Published var led_st: TimeInterval
        @Published var led_end: TimeInterval
        @Published var sample_st: TimeInterval
        @Published var sample_end: TimeInterval
        @Published var reset_st: TimeInterval
        @Published var reset_end: TimeInterval
        @Published var conv_st: TimeInterval
        @Published var conv_end: TimeInterval
        
        init(led_st: TimeInterval, led_end: TimeInterval, sample_st: TimeInterval, sample_end: TimeInterval, reset_st: TimeInterval, reset_end: TimeInterval, conv_st: TimeInterval, conv_end: TimeInterval) {
            self.led_st = led_st
            self.led_end = led_end
            self.sample_st = sample_st
            self.sample_end = sample_end
            self.reset_st = reset_st
            self.reset_end = reset_end
            self.conv_st = conv_st
            self.conv_end = conv_end
        }
    }
    
    class AmbientPhase: ObservableObject {
        @Published var sample_st: TimeInterval
        @Published var sample_end: TimeInterval
        @Published var reset_st: TimeInterval
        @Published var reset_end: TimeInterval
        @Published var conv_st: TimeInterval
        @Published var conv_end: TimeInterval
        
        init(sample_st: TimeInterval, sample_end: TimeInterval, reset_st: TimeInterval, reset_end: TimeInterval, conv_st: TimeInterval, conv_end: TimeInterval) {
            self.sample_st = sample_st
            self.sample_end = sample_end
            self.reset_st = reset_st
            self.reset_end = reset_end
            self.conv_st = conv_st
            self.conv_end = conv_end
        }
    }
    
    class DynamicPowerDownPhase: ObservableObject {
        @Published var start: TimeInterval
        @Published var end: TimeInterval
        
        init(start: TimeInterval, end: TimeInterval) {
            self.start = start
            self.end = end
        }
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
    
    @Published var ambientPhase: AmbientPhase
    @Published var LED1Phase: LEDPhase
    @Published var LED2Phase: LEDPhase
    @Published var LED3Phase: LEDPhase
    @Published var totalWindowLength: TimeInterval
    @Published var dynamicPowerDown: DynamicPowerDownPhase
    @Published var tiaCapacitor1: TIACapacitor
    @Published var tiaCapacitor2: TIACapacitor
    @Published var tiaResistor1: TIAResistor
    @Published var tiaResistor2: TIAResistor
    
    init(ambientPhase: AmbientPhase, LED1Phase: LEDPhase, LED2Phase: LEDPhase, LED3Phase: LEDPhase, totalWindowLength: TimeInterval, dynamicPowerDown: DynamicPowerDownPhase, tiaCapacitor1: TIACapacitor, tiaCapacitor2: TIACapacitor, tiaResistor1: TIAResistor, tiaResistor2: TIAResistor) {
        self.ambientPhase = ambientPhase
        self.LED1Phase = LED1Phase
        self.LED2Phase = LED2Phase
        self.LED3Phase = LED3Phase
        self.totalWindowLength = totalWindowLength
        self.dynamicPowerDown = dynamicPowerDown
        self.tiaCapacitor1 = tiaCapacitor1
        self.tiaCapacitor2 = tiaCapacitor2
        self.tiaResistor1 = tiaResistor1
        self.tiaResistor2 = tiaResistor2
    }
}

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
