//
//  TimingWindow.swift
//  pulse.loop
//
//  Created by Riccardo Persello on 05/11/22.
//

import Foundation
import CoreBluetooth
import CharacteristicKit

// swiftlint:disable nesting

class TimingWindow: TimingWindowProtocol, CharacteristicContainer {
    class LED1PhaseType: LEDPhaseProtocol, CharacteristicContainer {
        var ledStart: TimeIntervalType
        var ledEnd: TimeIntervalType
        var sampleStart: TimeIntervalType
        var sampleEnd: TimeIntervalType
        var resetStart: TimeIntervalType
        var resetEnd: TimeIntervalType
        var convStart: TimeIntervalType
        var convEnd: TimeIntervalType

        init() {
            ledStart = TimeIntervalType(initialValue: 0, uuid: CBUUIDs.led1LightingStartCharacteristicIdentifier)
            ledEnd = TimeIntervalType(initialValue: 0, uuid: CBUUIDs.led1LightingEndCharacteristicIdentifier)
            sampleStart = TimeIntervalType(initialValue: 0, uuid: CBUUIDs.led1SampleStartCharacteristicIdentifier)
            sampleEnd = TimeIntervalType(initialValue: 0, uuid: CBUUIDs.led1SampleEndCharacteristicIdentifier)
            resetStart = TimeIntervalType(initialValue: 0, uuid: CBUUIDs.led1ADCResetStartCharacteristicIdentifier)
            resetEnd = TimeIntervalType(initialValue: 0, uuid: CBUUIDs.led1ADCResetEndCharacteristicIdentifier)
            convStart = TimeIntervalType(initialValue: 0, uuid: CBUUIDs.led1ADCConversionStartCharacteristicIdentifier)
            convEnd = TimeIntervalType(initialValue: 0, uuid: CBUUIDs.led1ADCConversionEndCharacteristicIdentifier)
        }
    }

    class LED2PhaseType: LEDPhaseProtocol, CharacteristicContainer {
        typealias TimeIntervalType = Characteristic<Float32>

        var ledStart: TimeIntervalType
        var ledEnd: TimeIntervalType
        var sampleStart: TimeIntervalType
        var sampleEnd: TimeIntervalType
        var resetStart: TimeIntervalType
        var resetEnd: TimeIntervalType
        var convStart: TimeIntervalType
        var convEnd: TimeIntervalType

        init() {
            ledStart = TimeIntervalType(initialValue: 0, uuid: CBUUIDs.led2LightingStartCharacteristicIdentifier)
            ledEnd = TimeIntervalType(initialValue: 0, uuid: CBUUIDs.led2LightingEndCharacteristicIdentifier)
            sampleStart = TimeIntervalType(initialValue: 0, uuid: CBUUIDs.led2SampleStartCharacteristicIdentifier)
            sampleEnd = TimeIntervalType(initialValue: 0, uuid: CBUUIDs.led2SampleEndCharacteristicIdentifier)
            resetStart = TimeIntervalType(initialValue: 0, uuid: CBUUIDs.led2ADCResetStartCharacteristicIdentifier)
            resetEnd = TimeIntervalType(initialValue: 0, uuid: CBUUIDs.led2ADCResetEndCharacteristicIdentifier)
            convStart = TimeIntervalType(initialValue: 0, uuid: CBUUIDs.led2ADCConversionStartCharacteristicIdentifier)
            convEnd = TimeIntervalType(initialValue: 0, uuid: CBUUIDs.led2ADCConversionEndCharacteristicIdentifier)
        }
    }

    class LED3PhaseType: LEDPhaseProtocol, CharacteristicContainer {
        typealias TimeIntervalType = Characteristic<Float32>

        var ledStart: TimeIntervalType
        var ledEnd: TimeIntervalType
        var sampleStart: TimeIntervalType
        var sampleEnd: TimeIntervalType
        var resetStart: TimeIntervalType
        var resetEnd: TimeIntervalType
        var convStart: TimeIntervalType
        var convEnd: TimeIntervalType

        init() {
            ledStart = TimeIntervalType(initialValue: 0, uuid: CBUUIDs.led3LightingStartCharacteristicIdentifier)
            ledEnd = TimeIntervalType(initialValue: 0, uuid: CBUUIDs.led3LightingEndCharacteristicIdentifier)
            sampleStart = TimeIntervalType(initialValue: 0, uuid: CBUUIDs.led3SampleStartCharacteristicIdentifier)
            sampleEnd = TimeIntervalType(initialValue: 0, uuid: CBUUIDs.led3SampleEndCharacteristicIdentifier)
            resetStart = TimeIntervalType(initialValue: 0, uuid: CBUUIDs.led3ADCResetStartCharacteristicIdentifier)
            resetEnd = TimeIntervalType(initialValue: 0, uuid: CBUUIDs.led3ADCResetEndCharacteristicIdentifier)
            convStart = TimeIntervalType(initialValue: 0, uuid: CBUUIDs.led3ADCConversionStartCharacteristicIdentifier)
            convEnd = TimeIntervalType(initialValue: 0, uuid: CBUUIDs.led3ADCConversionEndCharacteristicIdentifier)
        }
    }

    class AmbientPhaseType: AmbientPhaseProtocol, CharacteristicContainer {
        typealias TimeIntervalType = Characteristic<Float32>

        var sampleStart: TimeIntervalType
        var sampleEnd: TimeIntervalType
        var resetStart: TimeIntervalType
        var resetEnd: TimeIntervalType
        var convStart: TimeIntervalType
        var convEnd: TimeIntervalType

        init() {
            sampleStart = TimeIntervalType(initialValue: 0,
                                           uuid: CBUUIDs.ambientSampleStartCharacteristicIdentifier)
            sampleEnd = TimeIntervalType(initialValue: 0,
                                         uuid: CBUUIDs.ambientSampleEndCharacteristicIdentifier)
            resetStart = TimeIntervalType(initialValue: 0,
                                          uuid: CBUUIDs.ambientADCResetStartCharacteristicIdentifier)
            resetEnd = TimeIntervalType(initialValue: 0,
                                        uuid: CBUUIDs.ambientADCResetEndCharacteristicIdentifier)
            convStart = TimeIntervalType(initialValue: 0,
                                         uuid: CBUUIDs.ambientADCConversionStartCharacteristicIdentifier)
            convEnd = TimeIntervalType(initialValue: 0,
                                       uuid: CBUUIDs.ambientADCConversionEndCharacteristicIdentifier)
        }
    }

    class DynamicPowerDownPhaseType: DynamicPowerDownPhaseProtocol, CharacteristicContainer {
        typealias TimeIntervalType = Characteristic<Float32>

        var start: TimeIntervalType
        var end: TimeIntervalType

        init() {
            start = TimeIntervalType(initialValue: 0, uuid: CBUUIDs.dynamicPowerDownStartCharacteristicIdentifier)
            end = TimeIntervalType(initialValue: 0, uuid: CBUUIDs.dynamicPowerDownEndCharacteristicIdentifier)
        }
    }

    typealias TimeIntervalType = Characteristic<Float32>

    var ambientPhase: AmbientPhaseType
    var LED1Phase: LED1PhaseType
    var LED2Phase: LED2PhaseType
    var LED3Phase: LED3PhaseType
    var totalWindowLength: TimeIntervalType
    var dynamicPowerDown: DynamicPowerDownPhaseType

    init() {
        ambientPhase = AmbientPhaseType()
        self.LED1Phase = Self.LED1PhaseType()
        self.LED2Phase = Self.LED2PhaseType()
        self.LED3Phase = Self.LED3PhaseType()
        totalWindowLength = TimeIntervalType(initialValue: 0, uuid: CBUUIDs.totalWindowLengthCharacteristicIdentifier)
        dynamicPowerDown = DynamicPowerDownPhaseType()
    }
}
