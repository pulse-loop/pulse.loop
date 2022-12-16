//
//  FakeOpticalFrontendRawSensorData.swift
//  pulse.loop
//
//  Created by Riccardo Persello on 21/11/22.
//

import Foundation
import CharacteristicKit

class FakeOpticalFrontendRawSensorData: OpticalFrontendRawSensorDataProtocol {
    var ambient: MockCharacteristic<Float32>
    var led1MinusAmbient: MockCharacteristic<Float32>
    var led1: MockCharacteristic<Float32>
    var led2: MockCharacteristic<Float32>
    var led3: MockCharacteristic<Float32>
    
    init(ambient: Float32,
         led1MinusAmbient: Float32,
         led1: Float32,
         led2: Float32,
         led3: Float32) {
        self.ambient = MockCharacteristic(constant: ambient)
        self.led1MinusAmbient = MockCharacteristic(constant: led1MinusAmbient)
        self.led1 = MockCharacteristic(constant: led1)
        self.led2 = MockCharacteristic(constant: led2)
        self.led3 = MockCharacteristic(constant: led3)
    }
    
    convenience init() {
        self.init(ambient: 0, led1MinusAmbient: 0, led1: 0, led2: 0, led3: 0)
    }
}
