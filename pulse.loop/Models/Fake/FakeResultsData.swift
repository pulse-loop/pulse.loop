//
//  FakeResultsData.swift
//  pulse.loop
//
//  Created by Riccardo Persello on 15/04/23.
//

import Foundation
import CharacteristicKit

class FakeResultsData: ResultsDataProtocol {
    typealias BloodOxygenDataType = MockCharacteristic<Float32>
    typealias HeartRateDataType = MockCharacteristic<Float32>
    typealias PerfusionIndexDataType = MockCharacteristic<Float32>
    typealias WristPresenceDataType = MockCharacteristic<Bool>
    
    var bloodOxygen: BloodOxygenDataType
    var heartRate: HeartRateDataType
    var led1PerfusionIndex: PerfusionIndexDataType
    var led2PerfusionIndex: PerfusionIndexDataType
    var led3PerfusionIndex: PerfusionIndexDataType
    var wristPresence: WristPresenceDataType
    
    init() {
        self.bloodOxygen = BloodOxygenDataType(constant: 0)
        self.heartRate = HeartRateDataType(constant: 0)
        self.led1PerfusionIndex = PerfusionIndexDataType(constant: 0)
        self.led2PerfusionIndex = PerfusionIndexDataType(constant: 0)
        self.led3PerfusionIndex = PerfusionIndexDataType(constant: 0)
        self.wristPresence = WristPresenceDataType(constant: false)
    }
}
