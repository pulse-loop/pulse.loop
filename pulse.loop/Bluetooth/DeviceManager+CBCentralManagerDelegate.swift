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
        
        self.logger.info("Central manager discovered peripheral \"\(peripheral.description)\" (\(RSSI)), with advertisement data \(advertisementData.description).")
        
        self.discoveredPeripherals.insert(BLEDevice(from: peripheral))
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        self.logger.info("Central manager connected to peripheral \"\(peripheral.description)\".")
    }
    
    func centralManager(_ central: CBCentralManager, willRestoreState dict: [String : Any]) {
        self.logger.info("Central manager will restore state: \(dict).")
    }
}
