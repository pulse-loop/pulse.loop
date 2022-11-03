//
//  FakeDevice.swift
//  pulse.loop
//
//  Created by Riccardo Persello on 24/10/22.
//

import Foundation

class FakeDevice: DeviceProtocol {
    @Published var rawOpticalAmbient: [OpticalSensorReading] = []
    @Published var rawOpticalLED1MinusAmbient: [OpticalSensorReading] = []
    @Published var rawOpticalLED1: [OpticalSensorReading] = []
    @Published var rawOpticalLED2: [OpticalSensorReading] = []
    @Published var rawOpticalLED3: [OpticalSensorReading] = []
    @Published var opticalFrontendConfiguration: OpticalFrontendConfiguration = OpticalFrontendConfiguration()
    @Published var apiVersion: Int = 1

    init() {
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { _ in
            self.rawOpticalAmbient.append(OpticalSensorReading(Int32.random(in: 0...100)))
            self.rawOpticalLED1MinusAmbient.append(OpticalSensorReading(Int32.random(in: 0...100)))
            self.rawOpticalLED1.append(OpticalSensorReading(Int32.random(in: 0...100)))
            self.rawOpticalLED2.append(OpticalSensorReading(Int32.random(in: 0...100)))
            self.rawOpticalLED3.append(OpticalSensorReading(Int32.random(in: 0...100)))
        })
    }
}
