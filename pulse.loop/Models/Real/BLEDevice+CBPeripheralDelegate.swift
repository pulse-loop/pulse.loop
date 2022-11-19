//
//  BLEDevice+CBPeripheralDelegate.swift
//  pulse.loop
//
//  Created by Riccardo Persello on 05/11/22.
//

import Foundation
import Runtime
import CoreBluetooth
import os

class BLEDeviceDelegate: NSObject, CBPeripheralDelegate {
    internal var logger: Logger
    private var device: BLEDevice
    
    init(device: BLEDevice) {
        self.logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: "Bluetooth Device Delegate")
        self.device = device
    }
    
    func peripheral(_ peripheral: CBPeripheral, didWriteValueFor characteristic: CBCharacteristic, error: Error?) {
        logger.trace("\(characteristic.value?.description ?? "Nothing") written to \(characteristic)")
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        logger.trace("\(characteristic.value?.description ?? "Nothing") read from \(characteristic)")

        let info = try! typeInfo(of: BLEDevice.self)
        if let data = characteristic.value {
            for property in info.properties {
                if let variable = try? property.get(from: self.device) as? any CharacteristicProtocol,
                   variable.uuid == characteristic.uuid {
                    variable.setLocalValue(data: data)
                }
            }
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        logger.debug("Discovered \(peripheral.services?.description ?? "no services").")
        
        guard let services = peripheral.services else { return }
        for service in services {
            peripheral.discoverCharacteristics([], for: service)
        }
        
        DispatchQueue.main.async {
            self.device.status = .connected
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        logger.debug("Discovered \(service.characteristics?.description ?? "no characteristics") in \(service).")
        
        guard let characteristics = service.characteristics else { return }
        
        for characteristic in characteristics {
            if characteristic.properties.contains(.notify) || characteristic.properties.contains(.indicate) {
                peripheral.setNotifyValue(true, for: characteristic)
            }
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateNotificationStateFor characteristic: CBCharacteristic, error: Error?) {
        logger.debug("Updated notification/indication state to \(characteristic.isNotifying) for \(characteristic).")
    }
}
