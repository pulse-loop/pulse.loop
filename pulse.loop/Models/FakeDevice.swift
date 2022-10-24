//
//  FakeDevice.swift
//  pulse.loop
//
//  Created by Riccardo Persello on 24/10/22.
//

import Foundation

class FakeDevice: DeviceProtocol {
    @Published var greenSensorData: [OpticalSensorReading] = []
    @Published var redSensorData: [OpticalSensorReading] = []
    @Published var infraredSensorData: [OpticalSensorReading] = []
    @Published var ambientSensorData: [OpticalSensorReading] = []
    
    init() {
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { _ in
            self.infraredSensorData.append(OpticalSensorReading(Int32.random(in: 0...100)))
            self.ambientSensorData.append(OpticalSensorReading(Int32.random(in: 0...100)))
            self.greenSensorData.append(OpticalSensorReading(Int32.random(in: 0...100)))
            self.redSensorData.append(OpticalSensorReading(Int32.random(in: 0...100)))
        })
    }
}
