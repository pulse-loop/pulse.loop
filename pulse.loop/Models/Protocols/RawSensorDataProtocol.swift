//
//  RawSensorDataProtocol.swift
//  pulse.loop
//
//  Created by Riccardo Persello on 21/11/22.
//

import Foundation
import CharacteristicKit

struct AggregatedData: Equatable {
    struct CriticalPoints: OptionSet, Equatable, DataDecodable {
        let rawValue: Int8
        
        static let led1Min = CriticalPoints(rawValue: 1 << 4)
        static let led2Min = CriticalPoints(rawValue: 1 << 2)
        static let led3Min = CriticalPoints(rawValue: 1 << 0)
        static let led1Max = CriticalPoints(rawValue: 2 << 4)
        static let led2Max = CriticalPoints(rawValue: 2 << 2)
        static let led3Max = CriticalPoints(rawValue: 2 << 0)
        
        static let none = CriticalPoints([])
        
        static func decode(from data: Data) -> AggregatedData.CriticalPoints? {
            return Self(rawValue: Int8.decode(from: data) ?? 0)
        }
    }
    
    var ambientReading: Int32 = 0
    var led1Reading: Int32 = 0
    var led2Reading: Int32 = 0
    var led3Reading: Int32 = 0
    var ambientLowerThreshold: Int32 = 0
    var ambientUpperThreshold: Int32 = 0
    var led1LowerThreshold: Int32 = 0
    var led1UpperThreshold: Int32 = 0
    var led2LowerThreshold: Int32 = 0
    var led2UpperThreshold: Int32 = 0
    var led3LowerThreshold: Int32 = 0
    var led3UpperThreshold: Int32 = 0
    var criticalPoints: CriticalPoints = .none
}

extension AggregatedData: DataDecodable {
    static func decode(from data: Data) -> AggregatedData? {
        var result = AggregatedData()
        result.ambientReading = Int32.decode(from: data.subdata(in: 0..<4)) ?? 0
        result.led1Reading = Int32.decode(from: data.subdata(in: 4..<8)) ?? 0
        result.led2Reading = Int32.decode(from: data.subdata(in: 8..<12)) ?? 0
        result.led3Reading = Int32.decode(from: data.subdata(in: 12..<16)) ?? 0
        result.ambientLowerThreshold = Int32.decode(from: data.subdata(in: 16..<20)) ?? 0
        result.ambientUpperThreshold = Int32.decode(from: data.subdata(in: 20..<24)) ?? 0
        result.led1LowerThreshold = Int32.decode(from: data.subdata(in: 24..<28)) ?? 0
        result.led1UpperThreshold = Int32.decode(from: data.subdata(in: 28..<32)) ?? 0
        result.led2LowerThreshold = Int32.decode(from: data.subdata(in: 32..<36)) ?? 0
        result.led2UpperThreshold = Int32.decode(from: data.subdata(in: 36..<40)) ?? 0
        result.led3LowerThreshold = Int32.decode(from: data.subdata(in: 40..<44)) ?? 0
        result.led3UpperThreshold = Int32.decode(from: data.subdata(in: 44..<48)) ?? 0
        result.criticalPoints = CriticalPoints.decode(from: data.subdata(in: 48..<49 )) ?? .none

        return result
    }
}

protocol RawSensorDataProtocol: ObservableObject {
    associatedtype RawOpticalType: GeneralCharacteristicProtocol<Float32>
    associatedtype AggregatedDataType: GeneralCharacteristicProtocol<AggregatedData>

    var ambient: RawOpticalType { get set }
    var led1MinusAmbient: RawOpticalType { get set }
    var led1: RawOpticalType { get set }
    var led2: RawOpticalType { get set }
    var led3: RawOpticalType { get set }
    var aggregatedData: AggregatedDataType { get }
}
