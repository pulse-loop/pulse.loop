//
//  SensorDataProtocol.swift
//  pulse.loop
//
//  Created by Riccardo Persello on 21/11/22.
//

import Foundation
import CharacteristicKit

protocol SensorDataProtocol: ObservableObject, CharacteristicContainer {
    associatedtype RawOpticalDataType: GeneralCharacteristicProtocol<RawOpticalData>
    associatedtype FilteredOpticalDataType: GeneralCharacteristicProtocol<FilteredOpticalData>

    var rawOpticalData: RawOpticalDataType { get }
    var filteredOpticalData: FilteredOpticalDataType { get }
}
