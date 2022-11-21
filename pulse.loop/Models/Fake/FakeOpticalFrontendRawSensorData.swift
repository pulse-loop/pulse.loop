//
//  FakeOpticalFrontendRawSensorData.swift
//  pulse.loop
//
//  Created by Riccardo Persello on 21/11/22.
//

import Foundation

class FakeOpticalFrontendRawSensorData: OpticalFrontendRawSensorDataProtocol {
    var ambient: FakeCharacteristic<Float32>
    var led1MinusAmbient: FakeCharacteristic<Float32>
    var led1: FakeCharacteristic<Float32>
    var led2: FakeCharacteristic<Float32>
    var led3: FakeCharacteristic<Float32>
    
    init(ambient: Float32,
         led1MinusAmbient: Float32,
         led1: Float32,
         led2: Float32,
         led3: Float32) {
        self.ambient = .init(constant: ambient)
        self.led1MinusAmbient = .init(constant: led1MinusAmbient)
        self.led1 = .init(constant: led1)
        self.led2 = .init(constant: led2)
        self.led3 = .init(constant: led3)
    }
    
    convenience init() {
        self.init(ambient: 0, led1MinusAmbient: 0, led1: 0, led2: 0, led3: 0)
    }
}
