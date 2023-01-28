//
//  RawSensorDataProtocol.swift
//  pulse.loop
//
//  Created by Riccardo Persello on 21/11/22.
//

import Foundation
import CharacteristicKit

struct AggregatedData: Equatable {
    struct CriticalPoints: OptionSet, Equatable {
        let rawValue: Int8
        
        static let led1Min = CriticalPoints(rawValue: 1 << 4)
        static let led2Min = CriticalPoints(rawValue: 1 << 2)
        static let led3Min = CriticalPoints(rawValue: 1 << 0)
        static let led1Max = CriticalPoints(rawValue: 2 << 4)
        static let led2Max = CriticalPoints(rawValue: 2 << 2)
        static let led3Max = CriticalPoints(rawValue: 2 << 0)
        
        static let none = CriticalPoints([])
    }
    
    var ambientReading: Float32 = 0
    var led1Reading: Float32 = 0
    var led2Reading: Float32 = 0
    var led3Reading: Float32 = 0
    var ambientLowerThreshold: Float32 = 0
    var ambientUpperThreshold: Float32 = 0
    var led1LowerThreshold: Float32 = 0
    var led1UpperThreshold: Float32 = 0
    var led2LowerThreshold: Float32 = 0
    var led2UpperThreshold: Float32 = 0
    var led3LowerThreshold: Float32 = 0
    var led3UpperThreshold: Float32 = 0
    var criticalPoints: CriticalPoints = .none
}

protocol RawSensorDataProtocol: ObservableObject {
    associatedtype RawOpticalType: CharacteristicProtocol<Float32>
    associatedtype AggregatedDataType: CharacteristicProtocol<AggregatedData>

    var ambient: RawOpticalType { get set }
    var led1MinusAmbient: RawOpticalType { get set }
    var led1: RawOpticalType { get set }
    var led2: RawOpticalType { get set }
    var led3: RawOpticalType { get set }
    var aggregatedData: AggregatedDataType { get }
}
