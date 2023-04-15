//
//  RawOpticalData.swift
//  pulse.loop
//
//  Created by Riccardo Persello on 31/03/23.
//

import Foundation
import CharacteristicKit

struct RawOpticalData: Equatable {
    var ambientReading: Float32 = 0
    var led1Reading: Float32 = 0
    var led2Reading: Float32 = 0
    var led3Reading: Float32 = 0
}

extension RawOpticalData: DataDecodable {
    static func decode(from data: Data) -> RawOpticalData? {
        
        guard data.count == 16 else {
            return nil
        }
        
        var result = RawOpticalData()
        result.ambientReading = Float32.decode(from: data.subdata(in: 0..<4)) ?? 0
        result.led1Reading = Float32.decode(from: data.subdata(in: 4..<8)) ?? 0
        result.led2Reading = Float32.decode(from: data.subdata(in: 8..<12)) ?? 0
        result.led3Reading = Float32.decode(from: data.subdata(in: 12..<16)) ?? 0

        return result
    }
}

extension RawOpticalData: PlottableData {
    func getChannels() -> [(specifier: ChannelSpecifier, lastValue: Value)] {
        return [
            (ChannelSpecifier(name: "Ambient", color: .blue), self.ambientReading),
            (ChannelSpecifier(name: "Green", color: .green), self.led1Reading),
            (ChannelSpecifier(name: "Red", color: .red), self.led2Reading),
            (ChannelSpecifier(name: "Infrared", color: .gray), self.led3Reading)
        ]
    }
}
