//
//  BLEDevice.swift
//  pulse.loop
//
//  Created by Riccardo Persello on 05/11/22.
//

import Foundation
import CoreBluetooth
import OSLog
import CharacteristicKit

final class BLEDevice: DeviceProtocol {
    

    internal var logger: Logger
        
    // MARK: Initialisers.
    init(from peripheral: CBPeripheral) {
        self.logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: "Bluetooth Device Model")
        logger.info("Initialising a new device from CoreBluetooth peripheral \"\(peripheral)\".")
        
        self.peripheral = peripheral
                
        // Characteristic container structs.
        self.opticalFrontendWindow = OpticalFrontendWindow(for: peripheral)
        self.rawData = OpticalFrontendRawSensorData()
        
        // Delegate.
        self.delegate = PeripheralDelegate(device: self)
        // TODO: Remove peripheral!!!
        peripheral.delegate = self.delegate
    }
    
    // MARK: Battery service.
    
    // MARK: Current time service.
    
    // MARK: Device information service.
    
    // MARK: Heart rate service.
    
    // MARK: Pulse oximeter service.
    
    // MARK: Firmware upgrade service.
    
    // MARK: Historic data.
    
    // MARK: Optical frontend configuration.
    typealias OpticalFrontendWindowType = OpticalFrontendWindow
    var opticalFrontendWindow: OpticalFrontendWindowType
    
    // MARK: Raw sensor data.
    typealias OpticalFrontendRawSensorDataType = OpticalFrontendRawSensorData
    var rawData: OpticalFrontendRawSensorDataType
    
    // MARK: Settings.
    
    // MARK: pulse.loop identifier.
    var apiVersion: Int = 0
    
    // MARK: Additional properties.
    var name: String { peripheral.name ?? "Unnamed device" }
    @Published var status: DeviceStatus = .disconnected
    var dataWindowLength: TimeInterval = 5
    
    // MARK: Internal variables.
    // TODO: REMOVE!!!
    var peripheral: CBPeripheral!
    var delegate: PeripheralDelegate<BLEDevice>?
    
    // MARK: Control functions.
    func connect() {
        DeviceManager.shared.connect(to: self)
    }
    
    func disconnect() {
        DeviceManager.shared.disconnect(from: self)
    }
}

extension BLEDevice: Equatable {
    static func == (lhs: BLEDevice, rhs: BLEDevice) -> Bool {
        return rhs.peripheral == lhs.peripheral
    }
}
