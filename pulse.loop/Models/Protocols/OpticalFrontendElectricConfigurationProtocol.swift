//
//  OpticalFrontendElectricConfigurationProtocol.swift
//  pulse.loop
//
//  Created by Riccardo Persello on 21/11/22.
//

import Foundation
import CharacteristicKit

protocol OpticalFrontendElectricConfigurationProtocol: ObservableObject {
    associatedtype TIAResistorType: CharacteristicProtocol<TIAResistor>
    associatedtype TIACapacitorType: CharacteristicProtocol<TIACapacitor>
    
    var tiaCapacitor1: TIACapacitorType { get set }
    var tiaCapacitor2: TIACapacitorType { get set }
    var tiaResistor1: TIAResistorType { get set }
    var tiaResistor2: TIAResistorType { get set }
}
