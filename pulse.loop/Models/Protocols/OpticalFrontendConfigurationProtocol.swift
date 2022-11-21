//
//  OpticalFrontendConfigurationProtocol.swift
//  pulse.loop
//
//  Created by Riccardo Persello on 05/11/22.
//

import Foundation

protocol LEDPhaseProtocol: ObservableObject {
    associatedtype TimeIntervalType: CharacteristicProtocol<TimeInterval>
    
    var led_st: TimeIntervalType { get set }
    var led_end: TimeIntervalType { get set }
    var sample_st: TimeIntervalType { get set }
    var sample_end: TimeIntervalType { get set }
    var reset_st: TimeIntervalType { get set }
    var reset_end: TimeIntervalType { get set }
    var conv_st: TimeIntervalType { get set }
    var conv_end: TimeIntervalType { get set }
}

protocol AmbientPhaseProtocol: ObservableObject {
    associatedtype TimeIntervalType: CharacteristicProtocol<TimeInterval>

    var sample_st: TimeIntervalType { get set }
    var sample_end: TimeIntervalType { get set }
    var reset_st: TimeIntervalType { get set }
    var reset_end: TimeIntervalType { get set }
    var conv_st: TimeIntervalType { get set }
    var conv_end: TimeIntervalType { get set }
}

protocol DynamicPowerDownPhaseProtocol: ObservableObject {
    associatedtype TimeIntervalType: CharacteristicProtocol<TimeInterval>

    var start: TimeIntervalType { get set }
    var end: TimeIntervalType { get set }
}

protocol OpticalFrontendConfigurationProtocol: ObservableObject {
    
    associatedtype LED1PhaseType: LEDPhaseProtocol
    associatedtype LED2PhaseType: LEDPhaseProtocol
    associatedtype LED3PhaseType: LEDPhaseProtocol
    associatedtype AmbientPhaseType: AmbientPhaseProtocol
    associatedtype DynamicPowerDownPhaseType: DynamicPowerDownPhaseProtocol
    associatedtype TimeIntervalType: CharacteristicProtocol<TimeInterval>
    associatedtype TIAResistorType: CharacteristicProtocol<TIAResistor>
    associatedtype TIACapacitorType: CharacteristicProtocol<TIACapacitor>
    
    var ambientPhase: AmbientPhaseType { get set }
    var LED1Phase: LED1PhaseType { get set }
    var LED2Phase: LED2PhaseType { get set }
    var LED3Phase: LED3PhaseType { get set }
    var totalWindowLength: TimeIntervalType { get set }
    var dynamicPowerDown: DynamicPowerDownPhaseType { get set }
    var tiaCapacitor1: TIACapacitorType { get set }
    var tiaCapacitor2: TIACapacitorType { get set }
    var tiaResistor1: TIAResistorType { get set }
    var tiaResistor2: TIAResistorType { get set }
}
