//
//  BLEDevice+CBPeripheralDelegate.swift
//  pulse.loop
//
//  Created by Riccardo Persello on 05/11/22.
//

import Foundation
import CoreBluetooth

extension BLEDevice: CBPeripheralDelegate {
    func peripheral(_ peripheral: CBPeripheral, didWriteValueFor characteristic: CBCharacteristic, error: Error?) {
        logger.debug("\(characteristic.value?.description ?? "Nothing") written to \(characteristic)")
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        logger.debug("\(characteristic.value?.description ?? "Nothing") read from \(characteristic)")
        
        objectWillChange.send()
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        logger.debug("Discovered \(peripheral.services?.description ?? "no services").")
        
        guard let services = peripheral.services else { return }
        for service in services {
            peripheral.discoverCharacteristics([], for: service)
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        logger.debug("Discovered \(service.characteristics?.description ?? "no characteristics") in \(service).")
    }
}
