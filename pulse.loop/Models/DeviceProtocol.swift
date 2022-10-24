//
//  DeviceProtocol.swift
//  pulse.loop
//
//  Created by Riccardo Persello on 24/10/22.
//

import Foundation

protocol DeviceProtocol: ObservableObject {
    var greenSensorData: [OpticalSensorReading] { get set }
    var redSensorData: [OpticalSensorReading] { get set }
    var infraredSensorData: [OpticalSensorReading] { get set }
    var ambientSensorData: [OpticalSensorReading] { get set }
}
