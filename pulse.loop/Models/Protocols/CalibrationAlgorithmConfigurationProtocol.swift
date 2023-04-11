//
//  CalibrationAlgorithmConfigurationProtocol.swift
//  pulse.loop
//
//  Created by Riccardo Persello on 07/04/23.
//

import Foundation
import CharacteristicKit

protocol CalibrationAlgorithmConfigurationProtocol: ObservableObject {
    associatedtype ADCSetPointType: GeneralCharacteristicProtocol<Float32>
    associatedtype ADCWorkingThresholdType: GeneralCharacteristicProtocol<Float32>
    associatedtype AlphaType: GeneralCharacteristicProtocol<Float32>
    associatedtype CurrentLimitType: GeneralCharacteristicProtocol<Float32>
    associatedtype OffsetCurrentType: GeneralCharacteristicProtocol<Float32>
    
    var led1ADCSetpoint: ADCSetPointType { get set }                    // OK
    var led1ADCWorkingThreshold: ADCWorkingThresholdType { get set }    // OK
    var led1Alpha: AlphaType { get set }                                //
    var led1MaximumCurrent: CurrentLimitType { get set }                // OK
    var led1MinimumCurrent: CurrentLimitType { get set }                // OK
    var led1MaximumOffsetCurrent: OffsetCurrentType { get set }         // OK
    var led1MinimumOffsetCurrent: OffsetCurrentType { get set }         // OK
    var led1OffsetCurrentSetpoint: OffsetCurrentType { get set }        //
    
    var led2ADCSetpoint: ADCSetPointType { get set }
    var led2ADCWorkingThreshold: ADCWorkingThresholdType { get set }
    var led2Alpha: AlphaType { get set }
    var led2MaximumCurrent: CurrentLimitType { get set }
    var led2MinimumCurrent: CurrentLimitType { get set }
    var led2MaximumOffsetCurrent: OffsetCurrentType { get set }
    var led2MinimumOffsetCurrent: OffsetCurrentType { get set }
    var led2OffsetCurrentSetpoint: OffsetCurrentType { get set }
    
    var led3ADCSetpoint: ADCSetPointType { get set }
    var led3ADCWorkingThreshold: ADCWorkingThresholdType { get set }
    var led3Alpha: AlphaType { get set }
    var led3MaximumCurrent: CurrentLimitType { get set }
    var led3MinimumCurrent: CurrentLimitType { get set }
    var led3MaximumOffsetCurrent: OffsetCurrentType { get set }
    var led3MinimumOffsetCurrent: OffsetCurrentType { get set }
    var led3OffsetCurrentSetpoint: OffsetCurrentType { get set }
}
