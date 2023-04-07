//
//  ElectricConfiguration.swift
//  pulse.loop
//
//  Created by Riccardo Persello on 22/12/22.
//

import Foundation
import CharacteristicKit

class ElectricConfiguration: ElectricConfigurationProtocol, CharacteristicContainer {
    typealias TIAResistorType = Characteristic<TIAResistor.RawValue>
    typealias TIACapacitorType = Characteristic<TIACapacitor.RawValue>
    typealias CurrentType = Characteristic<Float32>
    typealias ADCCountsType = Characteristic<UInt8>

    // MARK: Transimpedance amplifier.
    var tiaResistor1: TIAResistorType
    var tiaResistor2: TIAResistorType
    var tiaCapacitor1: TIACapacitorType
    var tiaCapacitor2: TIACapacitorType

    // MARK: LED currents.
    var led1Current: CurrentType
    var led2Current: CurrentType
    var led3Current: CurrentType

    // MARK: Offset currents.
    var ambientOffsetCurrent: CurrentType
    var led1OffsetCurrent: CurrentType
    var led2OffsetCurrent: CurrentType
    var led3OffsetCurrent: CurrentType
    
    // MARK: ADC settings.
    var adcAverages: ADCCountsType
    var decimationFactor: ADCCountsType

    init() {
        self.tiaResistor1 = TIAResistorType(initialValue: TIAResistor.r100kΩ.rawValue,
                                            uuid: CBUUIDs.tiaResistor1CharacteristicIdentifier)
        self.tiaResistor2 = TIAResistorType(initialValue: TIAResistor.r100kΩ.rawValue,
                                            uuid: CBUUIDs.tiaResistor2CharacteristicIdentifier)
        self.tiaCapacitor1 = TIACapacitorType(initialValue: TIACapacitor.c10pF.rawValue,
                                              uuid: CBUUIDs.tiaCapacitor1CharacteristicIdentifier)
        self.tiaCapacitor2 = TIACapacitorType(initialValue: TIACapacitor.c10pF.rawValue,
                                              uuid: CBUUIDs.tiaCapacitor2CharacteristicIdentifier)

        self.led1Current = CurrentType(initialValue: .zero,
                                       uuid: CBUUIDs.led1CurrentCharacteristicIdentifier)
        self.led2Current = CurrentType(initialValue: .zero,
                                       uuid: CBUUIDs.led2CurrentCharacteristicIdentifier)
        self.led3Current = CurrentType(initialValue: .zero,
                                       uuid: CBUUIDs.led3CurrentCharacteristicIdentifier)

        self.ambientOffsetCurrent = CurrentType(initialValue: .zero,
                                                uuid: CBUUIDs.ambientOffsetCurrentCharacteristicIdentifier)
        self.led1OffsetCurrent = CurrentType(initialValue: .zero,
                                             uuid: CBUUIDs.led1OffsetCurrentCharacteristicIdentifier)
        self.led2OffsetCurrent = CurrentType(initialValue: .zero,
                                             uuid: CBUUIDs.led2OffsetCurrentCharacteristicIdentifier)
        self.led3OffsetCurrent = CurrentType(initialValue: .zero,
                                             uuid: CBUUIDs.led3OffsetCurrentCharacteristicIdentifier)
        
        self.adcAverages = ADCCountsType(initialValue: 0, uuid: CBUUIDs.ADCAveragesCharacteristicIdentifier)
        self.decimationFactor = ADCCountsType(initialValue: 0, uuid: CBUUIDs.decimationFactorCharacteristicIdentifier)
    }
}
