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
    
    associatedtype OpticalFrontendConfigurationType: OpticalFrontendConfigurationProtocol
    associatedtype RawOpticalType: CharacteristicProtocol<Float32>
    
    // MARK: Battery service.
    
    // MARK: Current time service.
    
    // MARK: Device information service.
    
    // MARK: Heart rate service.
    
    // MARK: Pulse oximeter service.
    
    // MARK: Firmware upgrade service.
    
    // MARK: Historic data.
    
    // MARK: Optical frontend configuration.
    func getOpticalFrontendConfiguration() -> OpticalFrontendConfigurationType
    func setOpticalFrontendConfiguration(_ configuration: OpticalFrontendConfigurationType)
    
    // MARK: Raw sensor data.
    var rawOpticalAmbient: RawOpticalType { get set }
    var rawOpticalLED1MinusAmbient: RawOpticalType { get set }
    var rawOpticalLED1: RawOpticalType { get set }
    var rawOpticalLED2: RawOpticalType { get set }
    var rawOpticalLED3: RawOpticalType { get set }
    
    // MARK: Settings.
    
    // MARK: pulse.loop identifier.
    var apiVersion: Int { get }
    
    // MARK: Additional properties.
    var name: String { get }
    var status: DeviceStatus { get }
    var dataWindowLength: TimeInterval { get set }
    
    // MARK: Control functions.
    func connect()
    func disconnect()
}
