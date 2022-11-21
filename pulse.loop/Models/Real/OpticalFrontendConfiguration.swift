//
//  OpticalFrontendConfiguration.swift
//  pulse.loop
//
//  Created by Riccardo Persello on 05/11/22.
//

import Foundation
import CoreBluetooth

class OpticalFrontendConfiguration: OpticalFrontendConfigurationProtocol, CharacteristicContainer {
    class LED1PhaseType: LEDPhaseProtocol, CharacteristicContainer {
        var led_st: Characteristic<TimeInterval>
        var led_end: Characteristic<TimeInterval>
        var sample_st: Characteristic<TimeInterval>
        var sample_end: Characteristic<TimeInterval>
        var reset_st: Characteristic<TimeInterval>
        var reset_end: Characteristic<TimeInterval>
        var conv_st: Characteristic<TimeInterval>
        var conv_end: Characteristic<TimeInterval>
        
        init(peripheral: CBPeripheral) {
            led_st = Characteristic(initialValue: 0, peripheral: peripheral, uuid: CBUUIDs.led1LightingStartCharacteristicIdentifier)
            led_end = Characteristic(initialValue: 0, peripheral: peripheral, uuid: CBUUIDs.led1LightingEndCharacteristicIdentifier)
            sample_st = Characteristic(initialValue: 0, peripheral: peripheral, uuid: CBUUIDs.led1SampleStartCharacteristicIdentifier)
            sample_end = Characteristic(initialValue: 0, peripheral: peripheral, uuid: CBUUIDs.led1SampleEndCharacteristicIdentifier)
            reset_st = Characteristic(initialValue: 0, peripheral: peripheral, uuid: CBUUIDs.led1ADCResetStartCharacteristicIdentifier)
            reset_end = Characteristic(initialValue: 0, peripheral: peripheral, uuid: CBUUIDs.led1ADCResetEndCharacteristicIdentifier)
            conv_st = Characteristic(initialValue: 0, peripheral: peripheral, uuid: CBUUIDs.led1ADCConversionStartCharacteristicIdentifier)
            conv_end = Characteristic(initialValue: 0, peripheral: peripheral, uuid: CBUUIDs.led1ADCConversionEndCharacteristicIdentifier)
        }
    }
    
    class LED2PhaseType: LEDPhaseProtocol, CharacteristicContainer {
        var led_st: Characteristic<TimeInterval>
        var led_end: Characteristic<TimeInterval>
        var sample_st: Characteristic<TimeInterval>
        var sample_end: Characteristic<TimeInterval>
        var reset_st: Characteristic<TimeInterval>
        var reset_end: Characteristic<TimeInterval>
        var conv_st: Characteristic<TimeInterval>
        var conv_end: Characteristic<TimeInterval>
        
        init(peripheral: CBPeripheral) {
            led_st = .init(initialValue: 0, peripheral: peripheral, uuid: CBUUIDs.led2LightingStartCharacteristicIdentifier)
            led_end = .init(initialValue: 0, peripheral: peripheral, uuid: CBUUIDs.led2LightingEndCharacteristicIdentifier)
            sample_st = .init(initialValue: 0, peripheral: peripheral, uuid: CBUUIDs.led2SampleStartCharacteristicIdentifier)
            sample_end = .init(initialValue: 0, peripheral: peripheral, uuid: CBUUIDs.led2SampleEndCharacteristicIdentifier)
            reset_st = .init(initialValue: 0, peripheral: peripheral, uuid: CBUUIDs.led2ADCResetStartCharacteristicIdentifier)
            reset_end = .init(initialValue: 0, peripheral: peripheral, uuid: CBUUIDs.led2ADCResetEndCharacteristicIdentifier)
            conv_st = .init(initialValue: 0, peripheral: peripheral, uuid: CBUUIDs.led2ADCConversionStartCharacteristicIdentifier)
            conv_end = .init(initialValue: 0, peripheral: peripheral, uuid: CBUUIDs.led2ADCConversionEndCharacteristicIdentifier)
        }
    }
    
    class LED3PhaseType: LEDPhaseProtocol, CharacteristicContainer {
        var led_st: Characteristic<TimeInterval>
        var led_end: Characteristic<TimeInterval>
        var sample_st: Characteristic<TimeInterval>
        var sample_end: Characteristic<TimeInterval>
        var reset_st: Characteristic<TimeInterval>
        var reset_end: Characteristic<TimeInterval>
        var conv_st: Characteristic<TimeInterval>
        var conv_end: Characteristic<TimeInterval>
        
        init(peripheral: CBPeripheral) {
            led_st = .init(initialValue: 0, peripheral: peripheral, uuid: CBUUIDs.led3LightingStartCharacteristicIdentifier)
            led_end = .init(initialValue: 0, peripheral: peripheral, uuid: CBUUIDs.led3LightingEndCharacteristicIdentifier)
            sample_st = .init(initialValue: 0, peripheral: peripheral, uuid: CBUUIDs.led3SampleStartCharacteristicIdentifier)
            sample_end = .init(initialValue: 0, peripheral: peripheral, uuid: CBUUIDs.led3SampleEndCharacteristicIdentifier)
            reset_st = .init(initialValue: 0, peripheral: peripheral, uuid: CBUUIDs.led3ADCResetStartCharacteristicIdentifier)
            reset_end = .init(initialValue: 0, peripheral: peripheral, uuid: CBUUIDs.led3ADCResetEndCharacteristicIdentifier)
            conv_st = .init(initialValue: 0, peripheral: peripheral, uuid: CBUUIDs.led3ADCConversionStartCharacteristicIdentifier)
            conv_end = .init(initialValue: 0, peripheral: peripheral, uuid: CBUUIDs.led3ADCConversionEndCharacteristicIdentifier)
        }
    }
    
    class AmbientPhaseType: AmbientPhaseProtocol, CharacteristicContainer {
        var sample_st: Characteristic<TimeInterval>
        var sample_end: Characteristic<TimeInterval>
        var reset_st: Characteristic<TimeInterval>
        var reset_end: Characteristic<TimeInterval>
        var conv_st: Characteristic<TimeInterval>
        var conv_end: Characteristic<TimeInterval>
        
        init(peripheral: CBPeripheral) {
            sample_st = .init(initialValue: 0, peripheral: peripheral, uuid: CBUUIDs.ambientSampleStartCharacteristicIdentifier)
            sample_end = .init(initialValue: 0, peripheral: peripheral, uuid: CBUUIDs.ambientSampleEndCharacteristicIdentifier)
            reset_st = .init(initialValue: 0, peripheral: peripheral, uuid: CBUUIDs.ambientADCResetStartCharacteristicIdentifier)
            reset_end = .init(initialValue: 0, peripheral: peripheral, uuid: CBUUIDs.ambientADCResetEndCharacteristicIdentifier)
            conv_st = .init(initialValue: 0, peripheral: peripheral, uuid: CBUUIDs.ambientADCConversionStartCharacteristicIdentifier)
            conv_end = .init(initialValue: 0, peripheral: peripheral, uuid: CBUUIDs.ambientADCConversionEndCharacteristicIdentifier)
        }
    }
    
    class DynamicPowerDownPhaseType: DynamicPowerDownPhaseProtocol, CharacteristicContainer {
        var start: Characteristic<TimeInterval>
        var end: Characteristic<TimeInterval>
        
        init(peripheral: CBPeripheral) {
            start = .init(initialValue: 0, peripheral: peripheral, uuid: CBUUIDs.dynamicPowerDownStartCharacteristicIdentifier)
            end = .init(initialValue: 0, peripheral: peripheral, uuid: CBUUIDs.dynamicPowerDownEndCharacteristicIdentifier)
        }
    }
    
    var ambientPhase: AmbientPhaseType
    var LED1Phase: LED1PhaseType
    var LED2Phase: LED2PhaseType
    var LED3Phase: LED3PhaseType
    var totalWindowLength: Characteristic<TimeInterval>
    var dynamicPowerDown: DynamicPowerDownPhaseType
    var tiaCapacitor1: Characteristic<TIACapacitor>
    var tiaCapacitor2: Characteristic<TIACapacitor>
    var tiaResistor1: Characteristic<TIAResistor>
    var tiaResistor2: Characteristic<TIAResistor>
    
    init(peripheral: CBPeripheral) {
        ambientPhase = AmbientPhaseType(peripheral: peripheral)
        self.LED1Phase = Self.LED1PhaseType(peripheral: peripheral)
        self.LED2Phase = Self.LED2PhaseType(peripheral: peripheral)
        self.LED3Phase = Self.LED3PhaseType(peripheral: peripheral)
        totalWindowLength = .init(initialValue: 0, peripheral: peripheral, uuid: CBUUIDs.totalWindowLengthCharacteristicIdentifier)
        dynamicPowerDown = DynamicPowerDownPhaseType(peripheral: peripheral)
        tiaCapacitor1 = .init(initialValue: .C_5_pF, peripheral: peripheral, uuid: CBUUIDs.tiaCapacitor1CharacteristicIdentifier)
        tiaCapacitor2 = .init(initialValue: .C_5_pF, peripheral: peripheral, uuid: CBUUIDs.tiaCapacitor2CharacteristicIdentifier)
        tiaResistor1 = .init(initialValue: .R_10_kΩ, peripheral: peripheral, uuid: CBUUIDs.tiaResistor1CharacteristicIdentifier)
        tiaResistor2 = .init(initialValue: .R_10_kΩ, peripheral: peripheral, uuid: CBUUIDs.tiaResistor2CharacteristicIdentifier)
    }
}
