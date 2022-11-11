//
//  BLEDevice.swift
//  pulse.loop
//
//  Created by Riccardo Persello on 05/11/22.
//

import Foundation
import CoreBluetooth
import OSLog

class BLEDevice: NSObject, DeviceProtocol {

    internal var logger: Logger
    
    // MARK: Public BLE interface.
    var opticalFrontendConfiguration: FakeOpticalFrontendConfiguration = FakeDevice().opticalFrontendConfiguration
    @Published var rawOpticalAmbient: [OpticalSensorReading] = []
    @Published var rawOpticalLED1MinusAmbient: [OpticalSensorReading] = []
    @Published var rawOpticalLED1: [OpticalSensorReading] = []
    @Published var rawOpticalLED2: [OpticalSensorReading] = []
    @Published var rawOpticalLED3: [OpticalSensorReading] = []
    var apiVersion: Int = 0
    
    // MARK: Additional information.
    var name: String {
        peripheral.name ?? "Unnamed device"
    }
    @Published var status: DeviceStatus = .disconnected
        
    // MARK: Private BLE logic.
    var peripheral: CBPeripheral
    
    // MARK: Initialisers.
    init(from peripheral: CBPeripheral) {
        self.logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: "Bluetooth Device Model")
        logger.info("Initialising a new device from CoreBluetooth peripheral \"\(peripheral)\".")
        
        self.peripheral = peripheral
        
        super.init()

        peripheral.delegate = self
    }
    
    // MARK: Control functions.
    func connect() {
        DeviceManager.shared.connect(to: self)
    }
    
    func disconnect() {
        DeviceManager.shared.disconnect(from: self)
    }
}

extension BLEDevice {
    static func == (lhs: BLEDevice, rhs: BLEDevice) -> Bool {
        return rhs.peripheral == lhs.peripheral
    }
}
