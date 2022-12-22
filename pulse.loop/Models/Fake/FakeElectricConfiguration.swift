//
//  FakeElectricConfiguration.swift
//  pulse.loop
//
//  Created by Riccardo Persello on 22/12/22.
//

import Foundation
import CharacteristicKit

class FakeElectricConfiguration: ElectricConfigurationProtocol, CharacteristicContainer {
    typealias TIAResistorType = MockCharacteristic<TIAResistor>
    typealias TIACapacitorType = MockCharacteristic<TIACapacitor>
    typealias CurrentType = MockCharacteristic<Float32>
    
    // MARK: Transimpedance amplifier.
    var tiaResistor1: TIAResistorType = TIAResistorType(constant: .R_100_kΩ)
    var tiaResistor2: TIAResistorType = TIAResistorType(constant: .R_100_kΩ)
    var tiaCapacitor1: TIACapacitorType = TIACapacitorType(constant: .C_10_pF)
    var tiaCapacitor2: TIACapacitorType = TIACapacitorType(constant: .C_10_pF)
    
    // MARK: LED currents.
    var led1Current: CurrentType = CurrentType(constant: .zero)
    var led2Current: CurrentType = CurrentType(constant: .zero)
    var led3Current: CurrentType = CurrentType(constant: .zero)
    
    // MARK: Offset currents.
    var ambientOffsetCurrent: CurrentType = CurrentType(constant: .zero)
    var led1OffsetCurrent: CurrentType = CurrentType(constant: .zero)
    var led2OffsetCurrent: CurrentType = CurrentType(constant: .zero)
    var led3OffsetCurrent: CurrentType = CurrentType(constant: .zero)
}
