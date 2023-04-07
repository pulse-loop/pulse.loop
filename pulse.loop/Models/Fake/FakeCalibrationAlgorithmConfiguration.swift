//
//  FakeCalibrationAlgorithmConfiguration.swift
//  pulse.loop
//
//  Created by Riccardo Persello on 07/04/23.
//

import Foundation
import CharacteristicKit

class FakeCalibrationAlgorithmConfiguration: CalibrationAlgorithmConfigurationProtocol, CharacteristicContainer {
    typealias ADCSetPointType = MockCharacteristic<Float32>
    typealias ADCWorkingThresholdType = MockCharacteristic<Float32>
    typealias AlphaType = MockCharacteristic<Float32>
    typealias CurrentLimitType = MockCharacteristic<Float32>
    typealias OffsetCurrentType = MockCharacteristic<Float32>
    
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
        self.led1ADCSetpoint = ADCSetPointType(constant: 0.0)
        self.led1ADCWorkingThreshold = ADCWorkingThresholdType(constant: 0.0)
        self.led1Alpha = AlphaType(constant: 0.0)
        self.led1MaximumCurrent = CurrentLimitType(constant: 0.0)
        self.led1MinimumCurrent = CurrentLimitType(constant: 0.0)
        self.led1MaximumOffsetCurrent = OffsetCurrentType(constant: 0.0)
        self.led1MinimumOffsetCurrent = OffsetCurrentType(constant: 0.0)
        self.led1OffsetCurrentSetpoint = OffsetCurrentType(constant: 0.0)

        self.led2ADCSetpoint = ADCSetPointType(constant: 0.0)
        self.led2ADCWorkingThreshold = ADCWorkingThresholdType(constant: 0.0)
        self.led2Alpha = AlphaType(constant: 0.0)
        self.led2MaximumCurrent = CurrentLimitType(constant: 0.0)
        self.led2MinimumCurrent = CurrentLimitType(constant: 0.0)
        self.led2MaximumOffsetCurrent = OffsetCurrentType(constant: 0.0)
        self.led2MinimumOffsetCurrent = OffsetCurrentType(constant: 0.0)
        self.led2OffsetCurrentSetpoint = OffsetCurrentType(constant: 0.0)

        self.led3ADCSetpoint = ADCSetPointType(constant: 0.0)
        self.led3ADCWorkingThreshold = ADCWorkingThresholdType(constant: 0.0)
        self.led3Alpha = AlphaType(constant: 0.0)
        self.led3MaximumCurrent = CurrentLimitType(constant: 0.0)
        self.led3MinimumCurrent = CurrentLimitType(constant: 0.0)
        self.led3MaximumOffsetCurrent = OffsetCurrentType(constant: 0.0)
        self.led3MinimumOffsetCurrent = OffsetCurrentType(constant: 0.0)
        self.led3OffsetCurrentSetpoint = OffsetCurrentType(constant: 0.0)
    }
}
