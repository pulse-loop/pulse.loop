//
//  ElectricConfiguration.swift
//  pulse.loop
//
//  Created by Riccardo Persello on 22/12/22.
//

import Foundation
import CharacteristicKit

class ElectricConfiguration: ElectricConfigurationProtocol, CharacteristicContainer {
    typealias TIAResistorType = Characteristic<TIAResistor>
    typealias TIACapacitorType = Characteristic<TIACapacitor>
    typealias CurrentType = Characteristic<Float32>
    
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
    
    init() {
        self.tiaResistor1 = TIAResistorType(initialValue: .R_100_kΩ, uuid: CBUUIDs.tiaResistor1CharacteristicIdentifier)
        self.tiaResistor2 = TIAResistorType(initialValue: .R_100_kΩ, uuid: CBUUIDs.tiaResistor2CharacteristicIdentifier)
        self.tiaCapacitor1 = TIACapacitorType(initialValue: .C_10_pF, uuid: CBUUIDs.tiaCapacitor1CharacteristicIdentifier)
        self.tiaCapacitor2 = TIACapacitorType(initialValue: .C_10_pF, uuid: CBUUIDs.tiaCapacitor2CharacteristicIdentifier)
        
        self.led1Current = CurrentType(initialValue: .zero, uuid: CBUUIDs.led1CurrentCharacteristicIdentifier)
        self.led2Current = CurrentType(initialValue: .zero, uuid: CBUUIDs.led2CurrentCharacteristicIdentifier)
        self.led3Current = CurrentType(initialValue: .zero, uuid: CBUUIDs.led3CurrentCharacteristicIdentifier)
        
//        self.ambientOffsetCurrent = CurrentType(initialValue: .zero, uuid: )
//        self.led1OffsetCurrent = CurrentType(initialValue: .zero, uuid: )
//        self.led2OffsetCurrent = CurrentType(initialValue: .zero, uuid: )
//        self.led3OffsetCurrent = CurrentType(initialValue: .zero, uuid: )
    }
}
