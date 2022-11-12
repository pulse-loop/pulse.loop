//
//  OpticalFrontendConfigurationProtocol.swift
//  pulse.loop
//
//  Created by Riccardo Persello on 05/11/22.
//

import Foundation

protocol LEDPhaseProtocol: ObservableObject {
    var led_st: TimeInterval { get set }
    var led_end: TimeInterval { get set }
    var sample_st: TimeInterval { get set }
    var sample_end: TimeInterval { get set }
    var reset_st: TimeInterval { get set }
    var reset_end: TimeInterval { get set }
    var conv_st: TimeInterval { get set }
    var conv_end: TimeInterval { get set }
}

protocol AmbientPhaseProtocol: ObservableObject {
    var sample_st: TimeInterval {get set }
    var sample_end: TimeInterval {get set }
    var reset_st: TimeInterval {get set }
    var reset_end: TimeInterval {get set }
    var conv_st: TimeInterval {get set }
    var conv_end: TimeInterval {get set }
}

protocol DynamicPowerDownPhaseProtocol: ObservableObject {
    var start: TimeInterval { get set }
    var end: TimeInterval { get set }
}

protocol OpticalFrontendConfigurationProtocol: ObservableObject {
    
    associatedtype LED1PhaseType: LEDPhaseProtocol
    associatedtype LED2PhaseType: LEDPhaseProtocol
    associatedtype LED3PhaseType: LEDPhaseProtocol
    associatedtype AmbientPhaseType: AmbientPhaseProtocol
    associatedtype DynamicPowerDownPhaseType: DynamicPowerDownPhaseProtocol
    
    var ambientPhase: AmbientPhaseType { get set }
    var LED1Phase: LED1PhaseType { get set }
    var LED2Phase: LED2PhaseType { get set }
    var LED3Phase: LED3PhaseType { get set }
    var totalWindowLength: TimeInterval { get set }
    var dynamicPowerDown: DynamicPowerDownPhaseType { get set }
    var tiaCapacitor1: TIACapacitor { get set }
    var tiaCapacitor2: TIACapacitor { get set }
    var tiaResistor1: TIAResistor { get set }
    var tiaResistor2: TIAResistor { get set }
}
