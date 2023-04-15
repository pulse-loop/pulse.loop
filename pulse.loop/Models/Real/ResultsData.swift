//
//  ResultsData.swift
//  pulse.loop
//
//  Created by Riccardo Persello on 15/04/23.
//

import Foundation
import CharacteristicKit

class ResultsData: ResultsDataProtocol {
    typealias BloodOxygenDataType = Characteristic<Float32>
    typealias HeartRateDataType = Characteristic<Float32>
    typealias PerfusionIndexDataType = Characteristic<Float32>
    typealias WristPresenceDataType = Characteristic<Bool>
    
    var bloodOxygen: BloodOxygenDataType
    var heartRate: HeartRateDataType
    var led1PerfusionIndex: PerfusionIndexDataType
    var led2PerfusionIndex: PerfusionIndexDataType
    var led3PerfusionIndex: PerfusionIndexDataType
    var wristPresence: WristPresenceDataType
    
    init() {
        self.bloodOxygen = BloodOxygenDataType(initialValue: 0, uuid: CBUUIDs.bloodOxygenSaturationCharacteristicIdentifier)
        self.heartRate = HeartRateDataType(initialValue: 0, uuid: CBUUIDs.heartRateCharacteristicIdentifier)
        self.led1PerfusionIndex = PerfusionIndexDataType(initialValue: 0, uuid: CBUUIDs.led1PerfusionIndexCharacteristicIdentifier)
        self.led2PerfusionIndex = PerfusionIndexDataType(initialValue: 0, uuid: CBUUIDs.led2PerfusionIndexCharacteristicIdentifier)
        self.led3PerfusionIndex = PerfusionIndexDataType(initialValue: 0, uuid: CBUUIDs.led3PerfusionIndexCharacteristicIdentifier)
        self.wristPresence = WristPresenceDataType(initialValue: false, uuid: CBUUIDs.wristPresenceCharacteristicIdentifier)
    }
}
