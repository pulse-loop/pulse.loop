//
//  FilteredOpticalData.swift
//  pulse.loop
//
//  Created by Riccardo Persello on 07/04/23.
//

import Foundation
import CharacteristicKit

struct FilteredOpticalData: Equatable {
    var led1DC: Float32 = 0
    var led1AC: Float32 = 0
    var led2DC: Float32 = 0
    var led2AC: Float32 = 0
    var led3DC: Float32 = 0
    var led3AC: Float32 = 0
}

extension FilteredOpticalData: DataDecodable {
    static func decode(from data: Data) -> FilteredOpticalData? {
        
        guard data.count == 24 else {
            return nil
        }
        
        var result = FilteredOpticalData()
        result.led1DC = Float32.decode(from: data.subdata(in: 0..<4)) ?? 0
        result.led1AC = Float32.decode(from: data.subdata(in: 4..<8)) ?? 0
        result.led2DC = Float32.decode(from: data.subdata(in: 8..<12)) ?? 0
        result.led2AC = Float32.decode(from: data.subdata(in: 12..<16)) ?? 0
        result.led3DC = Float32.decode(from: data.subdata(in: 16..<20)) ?? 0
        result.led3AC = Float32.decode(from: data.subdata(in: 20..<24)) ?? 0

        return result
    }
}

extension FilteredOpticalData: PlottableData {
    func getChannels() -> [(specifier: ChannelSpecifier, lastValue: Value)] {
        return [
            (ChannelSpecifier(name: "Green DC", color: .green), self.led1DC * 1E12),
            (ChannelSpecifier(name: "Green AC", color: .green), self.led1AC * 1E12),
            (ChannelSpecifier(name: "Red DC", color: .red), self.led2DC * 1E12),
            (ChannelSpecifier(name: "Red AC", color: .red), self.led2AC * 1E12),
            (ChannelSpecifier(name: "Infrared DC", color: .gray), self.led3DC * 1E12),
            (ChannelSpecifier(name: "Infrared AC", color: .gray), self.led3AC * 1E12)
        ]
    }
}
