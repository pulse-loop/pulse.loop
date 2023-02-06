//
//  FakeElectricConfiguration.swift
//  pulse.loop
//
//  Created by Riccardo Persello on 22/12/22.
//

import Foundation
import CharacteristicKit
import Combine

class FakeElectricConfiguration: ElectricConfigurationProtocol, CharacteristicContainer {
    typealias TIAResistorType = MockCharacteristic<TIAResistor.RawValue>
    typealias TIACapacitorType = MockCharacteristic<TIACapacitor.RawValue>
    typealias CurrentType = MockCharacteristic<Float32>

    // MARK: Transimpedance amplifier.
    var tiaResistor1: TIAResistorType = TIAResistorType(constant: TIAResistor.r100kΩ.rawValue)
    var tiaResistor2: TIAResistorType = TIAResistorType(constant: TIAResistor.r100kΩ.rawValue)
    var tiaCapacitor1: TIACapacitorType = TIACapacitorType(constant: TIACapacitor.c10pF.rawValue)
    var tiaCapacitor2: TIACapacitorType = TIACapacitorType(constant: TIACapacitor.c10pF.rawValue)

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
