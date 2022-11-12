//
//  OpticalFrontendConfiguration.swift
//  pulse.loop
//
//  Created by Riccardo Persello on 05/11/22.
//

import Foundation
import CoreBluetooth

class OpticalFrontendConfiguration: OpticalFrontendConfigurationProtocol {
    class LED1PhaseType: LEDPhaseProtocol {
        var led_st: TimeInterval
        var led_end: TimeInterval
        var sample_st: TimeInterval
        var sample_end: TimeInterval
        var reset_st: TimeInterval
        var reset_end: TimeInterval
        var conv_st: TimeInterval
        var conv_end: TimeInterval
        
        init() {
            // TODO: Get data from characteristics.
            led_st = 0
            led_end = 0
            sample_st = 0
            sample_end = 0
            reset_st = 0
            reset_end = 0
            conv_st = 0
            conv_end = 0
        }
    }
    
    class LED2PhaseType: LEDPhaseProtocol {
        var led_st: TimeInterval
        var led_end: TimeInterval
        var sample_st: TimeInterval
        var sample_end: TimeInterval
        var reset_st: TimeInterval
        var reset_end: TimeInterval
        var conv_st: TimeInterval
        var conv_end: TimeInterval
        
        init() {
            // TODO: Get data from characteristics.
            led_st = 0
            led_end = 0
            sample_st = 0
            sample_end = 0
            reset_st = 0
            reset_end = 0
            conv_st = 0
            conv_end = 0
        }
    }
    
    class LED3PhaseType: LEDPhaseProtocol {
        var led_st: TimeInterval
        var led_end: TimeInterval
        var sample_st: TimeInterval
        var sample_end: TimeInterval
        var reset_st: TimeInterval
        var reset_end: TimeInterval
        var conv_st: TimeInterval
        var conv_end: TimeInterval
        
        init() {
            // TODO: Get data from characteristics.
            led_st = 0
            led_end = 0
            sample_st = 0
            sample_end = 0
            reset_st = 0
            reset_end = 0
            conv_st = 0
            conv_end = 0
        }
    }
    
    class AmbientPhaseType: AmbientPhaseProtocol {
        var sample_st: TimeInterval
        var sample_end: TimeInterval
        var reset_st: TimeInterval
        var reset_end: TimeInterval
        var conv_st: TimeInterval
        var conv_end: TimeInterval
        
        init() {
            // TODO: Get data from characteristics.
            sample_st = 0
            sample_end = 0
            reset_st = 0
            reset_end = 0
            conv_st = 0
            conv_end = 0
        }
    }
    
    class DynamicPowerDownPhaseType: DynamicPowerDownPhaseProtocol {
        var start: TimeInterval
        var end: TimeInterval
        
        init() {
            // TODO: Get data from characteristics.
            start = 0
            end = 0
        }
    }
    
    var ambientPhase: AmbientPhaseType
    var LED1Phase: LED1PhaseType
    var LED2Phase: LED2PhaseType
    var LED3Phase: LED3PhaseType
    var totalWindowLength: TimeInterval
    var dynamicPowerDown: DynamicPowerDownPhaseType
    var tiaCapacitor1: TIACapacitor
    var tiaCapacitor2: TIACapacitor
    var tiaResistor1: TIAResistor
    var tiaResistor2: TIAResistor
    
    init() {
        // TODO: Get data from characteristics.
        ambientPhase = AmbientPhaseType()
        self.LED1Phase = Self.LED1PhaseType()
        self.LED2Phase = Self.LED2PhaseType()
        self.LED3Phase = Self.LED3PhaseType()
        totalWindowLength = 0
        dynamicPowerDown = DynamicPowerDownPhaseType()
        tiaCapacitor1 = .C_10_pF
        tiaCapacitor2 = .C_5_pF
        tiaResistor1 = .R_100_kΩ
        tiaResistor2 = .R_1_MΩ
    }
}
