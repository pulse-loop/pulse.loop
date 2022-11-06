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
    }
    
    class AmbientPhase: AmbientPhaseProtocol {
        var sample_st: TimeInterval
        var sample_end: TimeInterval
        var reset_st: TimeInterval
        var reset_end: TimeInterval
        var conv_st: TimeInterval
        var conv_end: TimeInterval
    }
    
    class DynamicPowerDownPhase: DynamicPowerDownPhaseProtocol {
        var start: TimeInterval
        var end: TimeInterval
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
}
