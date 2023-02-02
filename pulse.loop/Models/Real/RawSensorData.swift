//
//  RawSensorData.swift
//  pulse.loop
//
//  Created by Riccardo Persello on 21/11/22.
//

import Foundation
import CharacteristicKit
import Combine

class RawSensorData: RawSensorDataProtocol, CharacteristicContainer {    
    typealias RawOpticalType = Characteristic<Float32>
    typealias AggregatedDataType = Characteristic<AggregatedData>
    
    var ambient: RawOpticalType
    var led1MinusAmbient: RawOpticalType
    var led1: RawOpticalType
    var led2: RawOpticalType
    var led3: RawOpticalType
    var aggregatedData: AggregatedDataType
    
    init() {
        self.ambient = RawOpticalType(initialValue: 0, uuid: CBUUIDs.ambientADCReadingCharacteristicIdentifier)
        self.led1MinusAmbient = RawOpticalType(initialValue: 0, uuid: CBUUIDs.led1MinusAmbientCharacteristicIdentifier)
        self.led1 = RawOpticalType(initialValue: 0, uuid: CBUUIDs.led1ADCReadingCharacteristicIdentifier)
        self.led2 = RawOpticalType(initialValue: 0, uuid: CBUUIDs.led2ADCReadingCharacteristicIdentifier)
        self.led3 = RawOpticalType(initialValue: 0, uuid: CBUUIDs.led3ADCReadingCharacteristicIdentifier)
        self.aggregatedData = AggregatedDataType(initialValue: AggregatedData(), uuid: CBUUIDs.aggregatedDataReadingCharacteristicIdentifier)
    }
}
