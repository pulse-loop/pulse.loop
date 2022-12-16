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
    
    // MARK: Internal data types.
    struct BLEDeviceDiscovery {
        var device: BLEDevice
        var lastSeen: Date
    }
    
    // MARK: Properties.
    internal let logger: Logger
    
    @Published var discoveredDevices: [UUID: BLEDeviceDiscovery]
    private let centralManager: CBCentralManager!
    
    static let shared: DeviceManager = DeviceManager()
    
    // MARK: Initialiser.
    private override init() {
        self.logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: "Bluetooth Device Manager")
        self.discoveredDevices = [:]
        self.centralManager = CBCentralManager(delegate: nil, queue: DispatchQueue(label: "CBCentralManager", qos: .userInteractive))
        super.init()
        
        self.centralManager.delegate = self
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            
            // Clean up peripherals that haven't been seen for a while.
            for discovery in self.discoveredDevices {
                let delta = discovery.value.lastSeen.timeIntervalSince(Date.now)
                if abs(delta) > 3.0 && discovery.value.device.status == .disconnected {
                    DispatchQueue.main.async {
                        self.discoveredDevices.removeValue(forKey: discovery.key)
                    }
                }
            }
        }
    }
    
    // MARK: Methods.
    internal func scan() {
        guard self.centralManager.state == .poweredOn else {
            // TODO: Error management.
            self.logger.warning("Cannot start scan.")
            return
        }
        
        self.logger.info("Starting scan.")
        
        self.centralManager.scanForPeripherals(withServices: [CBUUIDs.pulseLoopIdentifierServiceIdentifier],
                                               options: [CBCentralManagerScanOptionAllowDuplicatesKey: true])
    }
    
    func connect(to device: BLEDevice) {
        guard let peripheral = device.peripheral else {
            logger.warning("Trying to connect to a device whose peripheral is nil.")
            return
        }
        
        self.centralManager.connect(peripheral)
    }
    
    func disconnect(from device: BLEDevice) {
        guard let peripheral = device.peripheral else {
            logger.warning("Trying to connect to a device whose peripheral is nil.")
            return
        }
        
        self.centralManager.cancelPeripheralConnection(peripheral)
    }
}
