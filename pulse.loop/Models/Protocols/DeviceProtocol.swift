//
//  DeviceProtocol.swift
//  pulse.loop
//
//  Created by Riccardo Persello on 24/10/22.
//

import Foundation
import CharacteristicKit

protocol DeviceProtocol: GenericPeripheralModel, Equatable {
        
    // MARK: Battery service.
    
    // MARK: Current time service.
    
    // MARK: Device information service.
    
    // MARK: Heart rate service.
    
    // MARK: Pulse oximeter service.
    
    // MARK: Firmware upgrade service.
    
    // MARK: Historic data.
    
    // MARK: Optical frontend configuration.
    associatedtype OpticalFrontendWindowType: OpticalFrontendWindowProtocol
    var opticalFrontendWindow: OpticalFrontendWindowType { get set }
    
    // MARK: Raw sensor data.
    associatedtype OpticalFrontendRawSensorDataType: OpticalFrontendRawSensorDataProtocol
    var rawData: OpticalFrontendRawSensorDataType { get }
    
    // MARK: Settings.
    
    // MARK: pulse.loop identifier.
    var apiVersion: Int { get }
    
    // MARK: Additional properties.
    var name: String { get }
    var status: PeripheralStatus { get set }
    var dataWindowLength: TimeInterval { get set }
}
