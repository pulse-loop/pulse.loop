//
//  DeviceProtocol.swift
//  pulse.loop
//
//  Created by Riccardo Persello on 24/10/22.
//

import Foundation

enum DeviceStatus: CustomStringConvertible {
    case disconnected
    case connecting
    case connected
    
    var description: String {
        switch self {
        case .connected: return "connected"
        case .connecting: return "connecting"
        case .disconnected: return "disconnected"
        }
    }
}

protocol DeviceProtocol: ObservableObject, Equatable {
    
    associatedtype OpticalFrontendConfiguration: OpticalFrontendConfigurationProtocol
    
    // MARK: Battery service.
    
    // MARK: Current time service.
    
    // MARK: Device information service.
    
    // MARK: Heart rate service.
    
    // MARK: Pulse oximeter service.
    
    // MARK: Firmware upgrade service.
    
    // MARK: Historic data.
    
    // MARK: Optical frontend configuration.
    var opticalFrontendConfiguration: OpticalFrontendConfiguration { get set }
    
    // MARK: Raw sensor data.
    var rawOpticalAmbient: [OpticalSensorReading] { get set }
    var rawOpticalLED1MinusAmbient: [OpticalSensorReading] { get set }
    var rawOpticalLED1: [OpticalSensorReading] { get set }
    var rawOpticalLED2: [OpticalSensorReading] { get set }
    var rawOpticalLED3: [OpticalSensorReading] { get set }
    
    // MARK: Settings.
    
    // MARK: pulse.loop identifier.
    var apiVersion: Int { get }
    
    // MARK: Additional properties.
    var name: String { get }
    var status: DeviceStatus { get }
    
    // MARK: Control functions.
    func connect()
    func disconnect()
}
