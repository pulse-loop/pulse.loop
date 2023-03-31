//
//  RawOpticalData.swift
//  pulse.loop
//
//  Created by Riccardo Persello on 31/03/23.
//

import Foundation
import CharacteristicKit

struct RawOpticalData: Equatable {
    var ambientReading: Int32 = 0
    var led1Reading: Int32 = 0
    var led2Reading: Int32 = 0
    var led3Reading: Int32 = 0
}

extension RawOpticalData: DataDecodable {
    static func decode(from data: Data) -> RawOpticalData? {
        
        guard data.count == 16 else {
            return nil
        }
        
        var result = RawOpticalData()
        result.ambientReading = Int32.decode(from: data.subdata(in: 0..<4)) ?? 0
        result.led1Reading = Int32.decode(from: data.subdata(in: 4..<8)) ?? 0
        result.led2Reading = Int32.decode(from: data.subdata(in: 8..<12)) ?? 0
        result.led3Reading = Int32.decode(from: data.subdata(in: 12..<16)) ?? 0

        return result
    }
}
