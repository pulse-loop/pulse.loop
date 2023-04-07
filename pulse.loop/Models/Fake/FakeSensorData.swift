//
//  FakeSensorData.swift
//  pulse.loop
//
//  Created by Riccardo Persello on 21/11/22.
//

import Foundation
import CharacteristicKit

class FakeSensorData: SensorDataProtocol {
    typealias RawOpticalDataType = MockCharacteristic<RawOpticalData>
    typealias FilteredOpticalDataType = MockCharacteristic<FilteredOpticalData>

    var rawOpticalData: RawOpticalDataType
    var filteredOpticalData: FilteredOpticalDataType

    init(rawOpticalData: RawOpticalData, filteredOpticalData: FilteredOpticalData) {
        self.rawOpticalData = RawOpticalDataType(constant: rawOpticalData)
        self.filteredOpticalData = FilteredOpticalDataType(constant: filteredOpticalData)
    }

    convenience init() {
        self.init(
            rawOpticalData: RawOpticalData(),
            filteredOpticalData: FilteredOpticalData()
        )
    }
}
