//
//  TimingWindow.swift
//  pulse.loop
//
//  Created by Riccardo Persello on 05/11/22.
//

import Foundation
import CoreBluetooth
import CharacteristicKit

class TimingWindow: TimingWindowProtocol, CharacteristicContainer {
    class LED1PhaseType: LEDPhaseProtocol, CharacteristicContainer {
        var led_st: TimeIntervalType
        var led_end: TimeIntervalType
        var sample_st: TimeIntervalType
        var sample_end: TimeIntervalType
        var reset_st: TimeIntervalType
        var reset_end: TimeIntervalType
        var conv_st: TimeIntervalType
        var conv_end: TimeIntervalType
        
        init() {
            led_st = TimeIntervalType(initialValue: 0, uuid: CBUUIDs.led1LightingStartCharacteristicIdentifier)
            led_end = TimeIntervalType(initialValue: 0, uuid: CBUUIDs.led1LightingEndCharacteristicIdentifier)
            sample_st = TimeIntervalType(initialValue: 0, uuid: CBUUIDs.led1SampleStartCharacteristicIdentifier)
            sample_end = TimeIntervalType(initialValue: 0, uuid: CBUUIDs.led1SampleEndCharacteristicIdentifier)
            reset_st = TimeIntervalType(initialValue: 0, uuid: CBUUIDs.led1ADCResetStartCharacteristicIdentifier)
            reset_end = TimeIntervalType(initialValue: 0, uuid: CBUUIDs.led1ADCResetEndCharacteristicIdentifier)
            conv_st = TimeIntervalType(initialValue: 0, uuid: CBUUIDs.led1ADCConversionStartCharacteristicIdentifier)
            conv_end = TimeIntervalType(initialValue: 0, uuid: CBUUIDs.led1ADCConversionEndCharacteristicIdentifier)
        }
    }
    
    class LED2PhaseType: LEDPhaseProtocol, CharacteristicContainer {
        typealias TimeIntervalType = Characteristic<Float32>

        var led_st: TimeIntervalType
        var led_end: TimeIntervalType
        var sample_st: TimeIntervalType
        var sample_end: TimeIntervalType
        var reset_st: TimeIntervalType
        var reset_end: TimeIntervalType
        var conv_st: TimeIntervalType
        var conv_end: TimeIntervalType
        
        init() {
            led_st = TimeIntervalType(initialValue: 0, uuid: CBUUIDs.led2LightingStartCharacteristicIdentifier)
            led_end = TimeIntervalType(initialValue: 0, uuid: CBUUIDs.led2LightingEndCharacteristicIdentifier)
            sample_st = TimeIntervalType(initialValue: 0, uuid: CBUUIDs.led2SampleStartCharacteristicIdentifier)
            sample_end = TimeIntervalType(initialValue: 0, uuid: CBUUIDs.led2SampleEndCharacteristicIdentifier)
            reset_st = TimeIntervalType(initialValue: 0, uuid: CBUUIDs.led2ADCResetStartCharacteristicIdentifier)
            reset_end = TimeIntervalType(initialValue: 0, uuid: CBUUIDs.led2ADCResetEndCharacteristicIdentifier)
            conv_st = TimeIntervalType(initialValue: 0, uuid: CBUUIDs.led2ADCConversionStartCharacteristicIdentifier)
            conv_end = TimeIntervalType(initialValue: 0, uuid: CBUUIDs.led2ADCConversionEndCharacteristicIdentifier)
        }
    }
    
    class LED3PhaseType: LEDPhaseProtocol, CharacteristicContainer {
        typealias TimeIntervalType = Characteristic<Float32>

        var led_st: TimeIntervalType
        var led_end: TimeIntervalType
        var sample_st: TimeIntervalType
        var sample_end: TimeIntervalType
        var reset_st: TimeIntervalType
        var reset_end: TimeIntervalType
        var conv_st: TimeIntervalType
        var conv_end: TimeIntervalType
        
        init() {
            led_st = TimeIntervalType(initialValue: 0, uuid: CBUUIDs.led3LightingStartCharacteristicIdentifier)
            led_end = TimeIntervalType(initialValue: 0, uuid: CBUUIDs.led3LightingEndCharacteristicIdentifier)
            sample_st = TimeIntervalType(initialValue: 0, uuid: CBUUIDs.led3SampleStartCharacteristicIdentifier)
            sample_end = TimeIntervalType(initialValue: 0, uuid: CBUUIDs.led3SampleEndCharacteristicIdentifier)
            reset_st = TimeIntervalType(initialValue: 0, uuid: CBUUIDs.led3ADCResetStartCharacteristicIdentifier)
            reset_end = TimeIntervalType(initialValue: 0, uuid: CBUUIDs.led3ADCResetEndCharacteristicIdentifier)
            conv_st = TimeIntervalType(initialValue: 0, uuid: CBUUIDs.led3ADCConversionStartCharacteristicIdentifier)
            conv_end = TimeIntervalType(initialValue: 0, uuid: CBUUIDs.led3ADCConversionEndCharacteristicIdentifier)
        }
    }
    
    class AmbientPhaseType: AmbientPhaseProtocol, CharacteristicContainer {
        typealias TimeIntervalType = Characteristic<Float32>

        var sample_st: TimeIntervalType
        var sample_end: TimeIntervalType
        var reset_st: TimeIntervalType
        var reset_end: TimeIntervalType
        var conv_st: TimeIntervalType
        var conv_end: TimeIntervalType
        
        init() {
            sample_st = TimeIntervalType(initialValue: 0, uuid: CBUUIDs.ambientSampleStartCharacteristicIdentifier)
            sample_end = TimeIntervalType(initialValue: 0, uuid: CBUUIDs.ambientSampleEndCharacteristicIdentifier)
            reset_st = TimeIntervalType(initialValue: 0, uuid: CBUUIDs.ambientADCResetStartCharacteristicIdentifier)
            reset_end = TimeIntervalType(initialValue: 0, uuid: CBUUIDs.ambientADCResetEndCharacteristicIdentifier)
            conv_st = TimeIntervalType(initialValue: 0, uuid: CBUUIDs.ambientADCConversionStartCharacteristicIdentifier)
            conv_end = TimeIntervalType(initialValue: 0, uuid: CBUUIDs.ambientADCConversionEndCharacteristicIdentifier)
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
