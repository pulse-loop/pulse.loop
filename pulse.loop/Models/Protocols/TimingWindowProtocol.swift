//
//  TimingWindowProtocol.swift
//  pulse.loop
//
//  Created by Riccardo Persello on 05/11/22.
//

import Foundation
import CharacteristicKit

protocol LEDPhaseProtocol: ObservableObject, CharacteristicContainer {
    associatedtype TimeIntervalType: GeneralCharacteristicProtocol<Float32>

    var ledStart: TimeIntervalType { get set }
    var ledEnd: TimeIntervalType { get set }
    var sampleStart: TimeIntervalType { get set }
    var sampleEnd: TimeIntervalType { get set }
    var resetStart: TimeIntervalType { get set }
    var resetEnd: TimeIntervalType { get set }
    var convStart: TimeIntervalType { get set }
    var convEnd: TimeIntervalType { get set }
}

protocol AmbientPhaseProtocol: ObservableObject, CharacteristicContainer {
    associatedtype TimeIntervalType: GeneralCharacteristicProtocol<Float32>

    var sampleStart: TimeIntervalType { get set }
    var sampleEnd: TimeIntervalType { get set }
    var resetStart: TimeIntervalType { get set }
    var resetEnd: TimeIntervalType { get set }
    var convStart: TimeIntervalType { get set }
    var convEnd: TimeIntervalType { get set }
}

protocol DynamicPowerDownPhaseProtocol: ObservableObject, CharacteristicContainer {
    associatedtype TimeIntervalType: GeneralCharacteristicProtocol<Float32>

    var start: TimeIntervalType { get set }
    var end: TimeIntervalType { get set }
}

protocol TimingWindowProtocol: ObservableObject, CharacteristicContainer {

    associatedtype LED1PhaseType: LEDPhaseProtocol
    associatedtype LED2PhaseType: LEDPhaseProtocol
    associatedtype LED3PhaseType: LEDPhaseProtocol
    associatedtype AmbientPhaseType: AmbientPhaseProtocol
    associatedtype DynamicPowerDownPhaseType: DynamicPowerDownPhaseProtocol
    associatedtype TimeIntervalType: GeneralCharacteristicProtocol<Float32>

    var ambientPhase: AmbientPhaseType { get set }
    var LED1Phase: LED1PhaseType { get set }
    var LED2Phase: LED2PhaseType { get set }
    var LED3Phase: LED3PhaseType { get set }
    var totalWindowLength: TimeIntervalType { get set }
    var dynamicPowerDown: DynamicPowerDownPhaseType { get set }
}
