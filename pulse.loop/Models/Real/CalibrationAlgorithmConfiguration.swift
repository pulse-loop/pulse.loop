//
//  CalibrationAlgorithmConfiguration.swift
//  pulse.loop
//
//  Created by Riccardo Persello on 07/04/23.
//

import Foundation
import CharacteristicKit

class CalibrationAlgorithmConfiguration: CalibrationAlgorithmConfigurationProtocol, CharacteristicContainer {
    typealias ADCSetPointType = Characteristic<Float32>
    typealias ADCWorkingThresholdType = Characteristic<Float32>
    typealias AlphaType = Characteristic<Float32>
    typealias CurrentLimitType = Characteristic<Float32>
    typealias OffsetCurrentType = Characteristic<Float32>
    
    var led1ADCSetpoint: ADCSetPointType
    var led1ADCWorkingThreshold: ADCWorkingThresholdType
    var led1Alpha: AlphaType
    var led1MaximumCurrent: CurrentLimitType
    var led1MinimumCurrent: CurrentLimitType
    var led1MaximumOffsetCurrent: OffsetCurrentType
    var led1MinimumOffsetCurrent: OffsetCurrentType
    var led1OffsetCurrentSetpoint: OffsetCurrentType
    
    var led2ADCSetpoint: ADCSetPointType
    var led2ADCWorkingThreshold: ADCWorkingThresholdType
    var led2Alpha: AlphaType
    var led2MaximumCurrent: CurrentLimitType
    var led2MinimumCurrent: CurrentLimitType
    var led2MaximumOffsetCurrent: OffsetCurrentType
    var led2MinimumOffsetCurrent: OffsetCurrentType
    var led2OffsetCurrentSetpoint: OffsetCurrentType
    
    var led3ADCSetpoint: ADCSetPointType
    var led3ADCWorkingThreshold: ADCWorkingThresholdType
    var led3Alpha: AlphaType
    var led3MaximumCurrent: CurrentLimitType
    var led3MinimumCurrent: CurrentLimitType
    var led3MaximumOffsetCurrent: OffsetCurrentType
    var led3MinimumOffsetCurrent: OffsetCurrentType
    var led3OffsetCurrentSetpoint: OffsetCurrentType
    
    init() {
        self.led1ADCSetpoint = ADCSetPointType(initialValue: 0.0, uuid: CBUUIDs.led1ADCSetPointCharacteristicIdentifier)
        self.led1ADCWorkingThreshold = ADCWorkingThresholdType(initialValue: 0.0, uuid: CBUUIDs.led1ADCWorkingThresholdCharacteristicIdentifier)
        self.led1Alpha = AlphaType(initialValue: 0.0, uuid: CBUUIDs.led1AlphaCharacteristicIdentifier)
        self.led1MaximumCurrent = CurrentLimitType(initialValue: 0.0, uuid: CBUUIDs.led1CurrentMaxCharacteristicIdentifier)
        self.led1MinimumCurrent = CurrentLimitType(initialValue: 0.0, uuid: CBUUIDs.led1CurrentMinCharacteristicIdentifier)
        self.led1MaximumOffsetCurrent = OffsetCurrentType(initialValue: 0.0, uuid: CBUUIDs.led1OffsetCurrentMaxCharacteristicIdentifier)
        self.led1MinimumOffsetCurrent = OffsetCurrentType(initialValue: 0.0, uuid: CBUUIDs.led1OffsetCurrentMinCharacteristicIdentifier)
        self.led1OffsetCurrentSetpoint = OffsetCurrentType(initialValue: 0.0, uuid: CBUUIDs.led1OffsetCurrentCharacteristicIdentifier)

        self.led2ADCSetpoint = ADCSetPointType(initialValue: 0.0, uuid: CBUUIDs.led2ADCSetPointCharacteristicIdentifier)
        self.led2ADCWorkingThreshold = ADCWorkingThresholdType(initialValue: 0.0, uuid: CBUUIDs.led2ADCWorkingThresholdCharacteristicIdentifier)
        self.led2Alpha = AlphaType(initialValue: 0.0, uuid: CBUUIDs.led2AlphaCharacteristicIdentifier)
        self.led2MaximumCurrent = CurrentLimitType(initialValue: 0.0, uuid: CBUUIDs.led2CurrentMaxCharacteristicIdentifier)
        self.led2MinimumCurrent = CurrentLimitType(initialValue: 0.0, uuid: CBUUIDs.led2CurrentMinCharacteristicIdentifier)
        self.led2MaximumOffsetCurrent = OffsetCurrentType(initialValue: 0.0, uuid: CBUUIDs.led2OffsetCurrentMaxCharacteristicIdentifier)
        self.led2MinimumOffsetCurrent = OffsetCurrentType(initialValue: 0.0, uuid: CBUUIDs.led2OffsetCurrentMinCharacteristicIdentifier)
        self.led2OffsetCurrentSetpoint = OffsetCurrentType(initialValue: 0.0, uuid: CBUUIDs.led2OffsetCurrentCharacteristicIdentifier)

        self.led3ADCSetpoint = ADCSetPointType(initialValue: 0.0, uuid: CBUUIDs.led3ADCSetPointCharacteristicIdentifier)
        self.led3ADCWorkingThreshold = ADCWorkingThresholdType(initialValue: 0.0, uuid: CBUUIDs.led3ADCWorkingThresholdCharacteristicIdentifier)
        self.led3Alpha = AlphaType(initialValue: 0.0, uuid: CBUUIDs.led3AlphaCharacteristicIdentifier)
        self.led3MaximumCurrent = CurrentLimitType(initialValue: 0.0, uuid: CBUUIDs.led3CurrentMaxCharacteristicIdentifier)
        self.led3MinimumCurrent = CurrentLimitType(initialValue: 0.0, uuid: CBUUIDs.led3CurrentMinCharacteristicIdentifier)
        self.led3MaximumOffsetCurrent = OffsetCurrentType(initialValue: 0.0, uuid: CBUUIDs.led3OffsetCurrentMaxCharacteristicIdentifier)
        self.led3MinimumOffsetCurrent = OffsetCurrentType(initialValue: 0.0, uuid: CBUUIDs.led3OffsetCurrentMinCharacteristicIdentifier)
        self.led3OffsetCurrentSetpoint = OffsetCurrentType(initialValue: 0.0, uuid: CBUUIDs.led3OffsetCurrentSetPointCharacteristicIdentifier)
    }
}
