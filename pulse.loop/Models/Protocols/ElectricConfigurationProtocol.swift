//
//  ElectricConfigurationProtocol.swift
//  pulse.loop
//
//  Created by Riccardo Persello on 21/11/22.
//

import Foundation
import CharacteristicKit

protocol ElectricConfigurationProtocol: ObservableObject {
    associatedtype TIAResistorType: CharacteristicProtocol<TIAResistor.RawValue>
    associatedtype TIACapacitorType: CharacteristicProtocol<TIACapacitor.RawValue>
    associatedtype CurrentType: CharacteristicProtocol<Float32>
    
    // MARK: Transimpedance amplifier.
    var tiaCapacitor1: TIACapacitorType { get set }
    var tiaCapacitor2: TIACapacitorType { get set }
    var tiaResistor1: TIAResistorType { get set }
    var tiaResistor2: TIAResistorType { get set }
    
    // MARK: LED currents.
    var led1Current: CurrentType { get set }
    var led2Current: CurrentType { get set }
    var led3Current: CurrentType { get set }

    // MARK: Offset input currents.
    var ambientOffsetCurrent: CurrentType { get set }
    var led1OffsetCurrent: CurrentType { get set }
    var led2OffsetCurrent: CurrentType { get set }
    var led3OffsetCurrent: CurrentType { get set }
}
