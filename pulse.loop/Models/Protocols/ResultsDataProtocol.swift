//
//  ResultsDataProtocol.swift
//  pulse.loop
//
//  Created by Riccardo Persello on 15/04/23.
//

import Foundation
import CharacteristicKit

protocol ResultsDataProtocol: ObservableObject, CharacteristicContainer {
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
