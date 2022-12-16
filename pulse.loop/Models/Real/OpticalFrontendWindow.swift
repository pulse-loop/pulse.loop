//
//  OpticalFrontendWindow.swift
//  pulse.loop
//
//  Created by Riccardo Persello on 05/11/22.
//

import Foundation
import CoreBluetooth
import CharacteristicKit

class OpticalFrontendWindow: OpticalFrontendWindowProtocol, CharacteristicContainer {
    class LED1PhaseType: LEDPhaseProtocol, CharacteristicContainer {
        var led_st: Characteristic<Float32>
        var led_end: Characteristic<Float32>
        var sample_st: Characteristic<Float32>
        var sample_end: Characteristic<Float32>
        var reset_st: Characteristic<Float32>
        var reset_end: Characteristic<Float32>
        var conv_st: Characteristic<Float32>
        var conv_end: Characteristic<Float32>
        
        init() {
            led_st = Characteristic(initialValue: 0, uuid: CBUUIDs.led1LightingStartCharacteristicIdentifier)
            led_end = Characteristic(initialValue: 0, uuid: CBUUIDs.led1LightingEndCharacteristicIdentifier)
            sample_st = Characteristic(initialValue: 0, uuid: CBUUIDs.led1SampleStartCharacteristicIdentifier)
            sample_end = Characteristic(initialValue: 0, uuid: CBUUIDs.led1SampleEndCharacteristicIdentifier)
            reset_st = Characteristic(initialValue: 0, uuid: CBUUIDs.led1ADCResetStartCharacteristicIdentifier)
            reset_end = Characteristic(initialValue: 0, uuid: CBUUIDs.led1ADCResetEndCharacteristicIdentifier)
            conv_st = Characteristic(initialValue: 0, uuid: CBUUIDs.led1ADCConversionStartCharacteristicIdentifier)
            conv_end = Characteristic(initialValue: 0, uuid: CBUUIDs.led1ADCConversionEndCharacteristicIdentifier)
        }
    }
    
    class LED2PhaseType: LEDPhaseProtocol, CharacteristicContainer {
        var led_st: Characteristic<Float32>
        var led_end: Characteristic<Float32>
        var sample_st: Characteristic<Float32>
        var sample_end: Characteristic<Float32>
        var reset_st: Characteristic<Float32>
        var reset_end: Characteristic<Float32>
        var conv_st: Characteristic<Float32>
        var conv_end: Characteristic<Float32>
        
        init() {
            led_st = Characteristic(initialValue: 0, uuid: CBUUIDs.led2LightingStartCharacteristicIdentifier)
            led_end = Characteristic(initialValue: 0, uuid: CBUUIDs.led2LightingEndCharacteristicIdentifier)
            sample_st = Characteristic(initialValue: 0, uuid: CBUUIDs.led2SampleStartCharacteristicIdentifier)
            sample_end = Characteristic(initialValue: 0, uuid: CBUUIDs.led2SampleEndCharacteristicIdentifier)
            reset_st = Characteristic(initialValue: 0, uuid: CBUUIDs.led2ADCResetStartCharacteristicIdentifier)
            reset_end = Characteristic(initialValue: 0, uuid: CBUUIDs.led2ADCResetEndCharacteristicIdentifier)
            conv_st = Characteristic(initialValue: 0, uuid: CBUUIDs.led2ADCConversionStartCharacteristicIdentifier)
            conv_end = Characteristic(initialValue: 0, uuid: CBUUIDs.led2ADCConversionEndCharacteristicIdentifier)
        }
    }
    
    class LED3PhaseType: LEDPhaseProtocol, CharacteristicContainer {
        var led_st: Characteristic<Float32>
        var led_end: Characteristic<Float32>
        var sample_st: Characteristic<Float32>
        var sample_end: Characteristic<Float32>
        var reset_st: Characteristic<Float32>
        var reset_end: Characteristic<Float32>
        var conv_st: Characteristic<Float32>
        var conv_end: Characteristic<Float32>
        
        init() {
            led_st = Characteristic(initialValue: 0, uuid: CBUUIDs.led3LightingStartCharacteristicIdentifier)
            led_end = Characteristic(initialValue: 0, uuid: CBUUIDs.led3LightingEndCharacteristicIdentifier)
            sample_st = Characteristic(initialValue: 0, uuid: CBUUIDs.led3SampleStartCharacteristicIdentifier)
            sample_end = Characteristic(initialValue: 0, uuid: CBUUIDs.led3SampleEndCharacteristicIdentifier)
            reset_st = Characteristic(initialValue: 0, uuid: CBUUIDs.led3ADCResetStartCharacteristicIdentifier)
            reset_end = Characteristic(initialValue: 0, uuid: CBUUIDs.led3ADCResetEndCharacteristicIdentifier)
            conv_st = Characteristic(initialValue: 0, uuid: CBUUIDs.led3ADCConversionStartCharacteristicIdentifier)
            conv_end = Characteristic(initialValue: 0, uuid: CBUUIDs.led3ADCConversionEndCharacteristicIdentifier)
        }
    }
    
    class AmbientPhaseType: AmbientPhaseProtocol, CharacteristicContainer {
        var sample_st: Characteristic<Float32>
        var sample_end: Characteristic<Float32>
        var reset_st: Characteristic<Float32>
        var reset_end: Characteristic<Float32>
        var conv_st: Characteristic<Float32>
        var conv_end: Characteristic<Float32>
        
        init() {
            sample_st = Characteristic(initialValue: 0, uuid: CBUUIDs.ambientSampleStartCharacteristicIdentifier)
            sample_end = Characteristic(initialValue: 0, uuid: CBUUIDs.ambientSampleEndCharacteristicIdentifier)
            reset_st = Characteristic(initialValue: 0, uuid: CBUUIDs.ambientADCResetStartCharacteristicIdentifier)
            reset_end = Characteristic(initialValue: 0, uuid: CBUUIDs.ambientADCResetEndCharacteristicIdentifier)
            conv_st = Characteristic(initialValue: 0, uuid: CBUUIDs.ambientADCConversionStartCharacteristicIdentifier)
            conv_end = Characteristic(initialValue: 0, uuid: CBUUIDs.ambientADCConversionEndCharacteristicIdentifier)
        }
    }
    
    class DynamicPowerDownPhaseType: DynamicPowerDownPhaseProtocol, CharacteristicContainer {
        var start: Characteristic<Float32>
        var end: Characteristic<Float32>
        
        init() {
            start = Characteristic(initialValue: 0, uuid: CBUUIDs.dynamicPowerDownStartCharacteristicIdentifier)
            end = Characteristic(initialValue: 0, uuid: CBUUIDs.dynamicPowerDownEndCharacteristicIdentifier)
        }
    }
    
    var ambientPhase: AmbientPhaseType
    var LED1Phase: LED1PhaseType
    var LED2Phase: LED2PhaseType
    var LED3Phase: LED3PhaseType
    var totalWindowLength: Characteristic<Float32>
    var dynamicPowerDown: DynamicPowerDownPhaseType
    
    init() {
        ambientPhase = AmbientPhaseType()
        self.LED1Phase = Self.LED1PhaseType()
        self.LED2Phase = Self.LED2PhaseType()
        self.LED3Phase = Self.LED3PhaseType()
        totalWindowLength = Characteristic(initialValue: 0, uuid: CBUUIDs.totalWindowLengthCharacteristicIdentifier)
        dynamicPowerDown = DynamicPowerDownPhaseType()
    }
}
