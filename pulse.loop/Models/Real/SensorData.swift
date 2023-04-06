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
    typealias AggregatedDataType = Characteristic<RawOpticalData>

    var aggregatedData: AggregatedDataType

    init() {
        self.aggregatedData = AggregatedDataType(initialValue: RawOpticalData(),
                                                 uuid: CBUUIDs.aggregatedDataReadingCharacteristicIdentifier)
    }
}
