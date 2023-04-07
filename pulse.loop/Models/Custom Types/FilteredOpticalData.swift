//
//  FilteredOpticalData.swift
//  pulse.loop
//
//  Created by Riccardo Persello on 07/04/23.
//

import Foundation
import CharacteristicKit

struct FilteredOpticalData: Equatable {
    var led1DC: Int32 = 0
    var led1AC: Int32 = 0
    var led2DC: Int32 = 0
    var led2AC: Int32 = 0
    var led3DC: Int32 = 0
    var led3AC: Int32 = 0
}

extension FilteredOpticalData: DataDecodable {
    static func decode(from data: Data) -> FilteredOpticalData? {
        
        guard data.count == 24 else {
            return nil
        }
        
        var result = FilteredOpticalData()
        result.led1DC = Int32.decode(from: data.subdata(in: 0..<4)) ?? 0
        result.led1AC = Int32.decode(from: data.subdata(in: 4..<8)) ?? 0
        result.led2DC = Int32.decode(from: data.subdata(in: 8..<12)) ?? 0
        result.led2AC = Int32.decode(from: data.subdata(in: 12..<16)) ?? 0
        result.led3DC = Int32.decode(from: data.subdata(in: 16..<20)) ?? 0
        result.led3AC = Int32.decode(from: data.subdata(in: 20..<24)) ?? 0

        return result
    }
}

extension FilteredOpticalData: PlottableData {
    func getChannels() -> [(specifier: ChannelSpecifier, lastValue: Value)] {
        return [
            (ChannelSpecifier(name: "Green DC", color: .blue), Float(self.led1DC)),
            (ChannelSpecifier(name: "Green AC", color: .green), Float(self.led1AC)),
            (ChannelSpecifier(name: "Red DC", color: .red), Float(self.led2DC)),
            (ChannelSpecifier(name: "Red AC", color: .gray), Float(self.led2AC)),
            (ChannelSpecifier(name: "Infrared DC", color: .red), Float(self.led3DC)),
            (ChannelSpecifier(name: "Infrared AC", color: .gray), Float(self.led3AC))
        ]
    }
}
