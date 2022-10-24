//
//  DeviceManager.swift
//  pulse.loop
//
//  Created by Riccardo Persello on 02/10/22.
//

import Foundation
import CoreBluetooth
import OSLog

class DeviceManager: NSObject, ObservableObject {
    internal let logger: Logger
    private let centralManager: CBCentralManager
    
    override init() {
        self.logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: "Bluetooth Device Manager")
        self.centralManager = CBCentralManager()
        super.init()
        self.centralManager.delegate = self
    }
    
    internal func scan() {
        guard self.centralManager.state == .poweredOn else {
            // TODO: Error management.
            self.logger.warning("Cannot start scan.")
            return
        }
        
        self.logger.info("Starting scan.")
        
        self.centralManager.scanForPeripherals(withServices: [CBUUID(string: "FAFAFAFA-FAFA-FAFA-FAFA-FAFAFAFAFAFA")])
    }
}
