//
//  FakeOpticalFrontendRawSensorData.swift
//  pulse.loop
//
//  Created by Riccardo Persello on 21/11/22.
//

import Foundation
import CharacteristicKit

class FakeRawSensorData: RawSensorDataProtocol {
    typealias RawOpticalType = MockCharacteristic<Float32>
    typealias AggregatedDataType = MockCharacteristic<AggregatedData>

    var ambient: RawOpticalType
    var led1MinusAmbient: RawOpticalType
    var led1: RawOpticalType
    var led2: RawOpticalType
    var led3: RawOpticalType
    var aggregatedData: AggregatedDataType

    init(ambient: Float32,
         led1MinusAmbient: Float32,
         led1: Float32,
         led2: Float32,
         led3: Float32,
         aggregatedData: AggregatedData) {
        self.ambient = RawOpticalType(constant: ambient)
        self.led1MinusAmbient = RawOpticalType(constant: led1MinusAmbient)
        self.led1 = RawOpticalType(constant: led1)
        self.led2 = RawOpticalType(constant: led2)
        self.led3 = RawOpticalType(constant: led3)
        self.aggregatedData = AggregatedDataType(constant: aggregatedData)
    }

    convenience init() {
        self.init(ambient: 0, led1MinusAmbient: 0, led1: 0, led2: 0, led3: 0, aggregatedData: AggregatedData())
    }
}
