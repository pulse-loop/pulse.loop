//
//  OpticalFrontendConfiguration.swift
//  pulse.loop
//
//  Created by Riccardo Persello on 05/11/22.
//

import Foundation
import CoreBluetooth

class OpticalFrontendConfiguration: OpticalFrontendConfigurationProtocol {
    class LED1Phase: LEDPhaseProtocol {
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
    
    class LED2Phase: LEDPhaseProtocol {
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
    
    class LED3Phase: LEDPhaseProtocol {
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
    
    class AmbientPhase: AmbientPhaseProtocol {
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
    
    class DynamicPowerDownPhase: DynamicPowerDownPhaseProtocol {
        var start: TimeInterval
        var end: TimeInterval
        
        init() {
            // TODO: Get data from characteristics.
            start = 0
            end = 0
        }
    }
    
    var ambientPhase: AmbientPhase
    var LED1Phase: LED1Phase
    var LED2Phase: LED2Phase
    var LED3Phase: LED3Phase
    var totalWindowLength: TimeInterval
    var dynamicPowerDown: DynamicPowerDownPhase
    var tiaCapacitor1: TIACapacitor
    var tiaCapacitor2: TIACapacitor
    var tiaResistor1: TIAResistor
    var tiaResistor2: TIAResistor
    
    init() {
        // TODO: Get data from characteristics.
        ambientPhase = AmbientPhase()
        self.LED1Phase = Self.LED1Phase()
        self.LED2Phase = Self.LED2Phase()
        self.LED3Phase = Self.LED3Phase()
        totalWindowLength = 0
        dynamicPowerDown = DynamicPowerDownPhase()
        tiaCapacitor1 = .C_10_pF
        tiaCapacitor2 = .C_5_pF
        tiaResistor1 = .R_100_kΩ
        tiaResistor2 = .R_1_MΩ
    }
}
