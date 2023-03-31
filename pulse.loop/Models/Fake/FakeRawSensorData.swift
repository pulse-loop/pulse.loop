//
//  FakeOpticalFrontendSensorData.swift
//  pulse.loop
//
//  Created by Riccardo Persello on 21/11/22.
//

import Foundation
import CharacteristicKit

class FakeSensorData: SensorDataProtocol {
    typealias AggregatedDataType = MockCharacteristic<RawOpticalData>

    var aggregatedData: AggregatedDataType

    init(aggregatedData: RawOpticalData) {
        self.aggregatedData = AggregatedDataType(constant: aggregatedData)
    }

    convenience init() {
        self.init(aggregatedData: RawOpticalData())
    }
}
