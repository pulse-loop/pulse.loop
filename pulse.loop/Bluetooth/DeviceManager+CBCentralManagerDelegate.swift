//
//  DeviceManager+CBCentralManagerDelegate.swift
//  pulse.loop
//
//  Created by Riccardo Persello on 20/10/22.
//

import Foundation
import CoreBluetooth

extension CBManagerState: CustomStringConvertible {
    public var description: String {
        switch self {
        case .poweredOn: return "Powered On"
        case .poweredOff: return "Powered Off"
        case .resetting: return "Resetting"
        case .unauthorized: return "Unauthorized"
        case .unsupported: return "Unsupported"
        default: return "Unknown"
        }
    }
}

extension DeviceManager: CBCentralManagerDelegate {
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        self.logger.info("Central manager state updated to \"\(central.state)\".")
        if central.state == .poweredOn {
            self.scan()
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        if self.discoveredDevices[peripheral.identifier] == nil {
            self.logger.info("Central manager discovered new peripheral \"\(peripheral.description)\" (\(RSSI)), with advertisement data \(advertisementData.description).")

            let discovery = BLEDeviceDiscovery(device: BLEDevice(from: peripheral), lastSeen: Date.now)
            self.discoveredDevices[peripheral.identifier] = discovery
        } else {
            self.discoveredDevices[peripheral.identifier]?.lastSeen = Date.now
        }
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        self.logger.info("Central manager connected to peripheral \"\(peripheral.description)\".")
        self.discoveredDevices[peripheral.identifier]?.device.status = .connecting
        peripheral.discoverServices([])
    }
    
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        self.logger.info("Central manager disconnected from peripheral \"\(peripheral.description)\".")
        self.discoveredDevices[peripheral.identifier]?.device.status = .disconnected
    }
    
    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        self.logger.info("Central manager failed to connect to \"\(peripheral.description)\" because of the following error: \"\(error?.localizedDescription ?? "Unknown error")\".")
        self.discoveredDevices[peripheral.identifier]?.device.status = .disconnected
    }
    
    func centralManager(_ central: CBCentralManager, willRestoreState dict: [String : Any]) {
        self.logger.info("Central manager will restore state: \(dict).")
    }
}
