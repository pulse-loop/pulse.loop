//
//  ResultsDataProtocol.swift
//  pulse.loop
//
//  Created by Riccardo Persello on 15/04/23.
//

import Foundation
import CharacteristicKit

protocol ResultsDataProtocol: ObservableObject, CharacteristicContainer, PlottableData {
    associatedtype BloodOxygenDataType: GeneralCharacteristicProtocol<Float32>
    associatedtype HeartRateDataType: GeneralCharacteristicProtocol<Float32>
    associatedtype PerfusionIndexDataType: GeneralCharacteristicProtocol<Float32>
    associatedtype WristPresenceDataType: GeneralCharacteristicProtocol<Bool>
    
    var bloodOxygen: BloodOxygenDataType { get }
    var heartRate: HeartRateDataType { get }
    var led1PerfusionIndex: PerfusionIndexDataType { get }
    var led2PerfusionIndex: PerfusionIndexDataType { get }
    var led3PerfusionIndex: PerfusionIndexDataType { get }
    var wristPresence: WristPresenceDataType { get }
}

extension ResultsDataProtocol {
    func getChannels() -> [(specifier: ChannelSpecifier, lastValue: Float)] {
        return [
            (specifier: ChannelSpecifier(name: "Blood Oxygen", color: .blue), lastValue: self.bloodOxygen.value),
            (specifier: ChannelSpecifier(name: "Heart Rate", color: .red), lastValue: self.heartRate.value),
            (specifier: ChannelSpecifier(name: "LED 1 PI", color: .green), lastValue: self.heartRate.value),
            (specifier: ChannelSpecifier(name: "LED 2 PI", color: .red), lastValue: self.heartRate.value),
            (specifier: ChannelSpecifier(name: "LED 3 PI", color: .gray), lastValue: self.heartRate.value),
        ]
    }
}
