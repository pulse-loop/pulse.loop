//
//  SensorData.swift
//  pulse.loop
//
//  Created by Riccardo Persello on 21/11/22.
//

import Foundation
import CharacteristicKit
import Combine

class SensorData: SensorDataProtocol, CharacteristicContainer {
    typealias RawOpticalDataType = Characteristic<RawOpticalData>
    typealias FilteredOpticalDataType = Characteristic<FilteredOpticalData>

    var rawOpticalData: RawOpticalDataType
    var filteredOpticalData: FilteredOpticalDataType

    init() {
        self.rawOpticalData = RawOpticalDataType(initialValue: RawOpticalData(),
                                                 uuid: CBUUIDs.rawOpticalDataReadingCharacteristicIdentifier)
        
        self.filteredOpticalData = FilteredOpticalDataType(initialValue: FilteredOpticalData(),
                                                           uuid: CBUUIDs.filteredOpticalDataReadingCharacteristicIdentifier)
    }
}
