//
//  BLEDevice+CBPeripheralDelegate.swift
//  pulse.loop
//
//  Created by Riccardo Persello on 05/11/22.
//

import Foundation
import SwiftUICharts
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
        logger.debug("\(characteristic.value?.description ?? "Nothing") written to \(characteristic)")
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        logger.debug("\(characteristic.value?.description ?? "Nothing") read from \(characteristic)")
        
        // Build a notifying characteristic map. Should be done only once!
        let info = try! typeInfo(of: BLEDevice.self)
        let notifyingCharacteristicsMap: [CBUUID: PropertyInfo] = info.properties.filter({
            if let x = try? $0.get(from: self.device), x is CharacteristicWrapper {
                return true
            }
            
            return false
        }).reduce(into: [CBUUID: PropertyInfo]()) { partialResult, val in
            let variable = try! val.get(from: self.device) as! CharacteristicWrapper
            partialResult[variable.uuid] = val
        }

        // Get the property name, get its contents, mutate them, and then put it back in place via `NSObject` methods.
        if let propertyInfo = notifyingCharacteristicsMap[characteristic.uuid],
           let data = characteristic.value {
            
            guard var value = (try? propertyInfo.get(from: self.device)) as? NotifyingCharacteristic<LineDataSet> else { return }
            value.wrappedValue.dataPoints.append(
                LineChartDataPoint(
                    value: Double(data.withUnsafeBytes( {$0.load(as: Float32.self)} )),
                    date: Date.now
                )
            )
            
            value.wrappedValue.dataPoints.removeAll(where: {$0.date!.addingTimeInterval(self.device.dataWindowLength) < Date.now})
            
            try! propertyInfo.set(value: value, on: &self.device)
            
            // Do not notify, frequency might be too high, causing lags in SwiftUI.
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        logger.debug("Discovered \(peripheral.services?.description ?? "no services").")
        
        guard let services = peripheral.services else { return }
        for service in services {
            peripheral.discoverCharacteristics([], for: service)
        }
        
        self.device.status = .connected
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        logger.debug("Discovered \(service.characteristics?.description ?? "no characteristics") in \(service).")
        
        guard let characteristics = service.characteristics else { return }
        
//        let chartingCharacteristicsMap: [CBUUID: String] = Mirror(reflecting: self).children
//            .filter({$0.value is NotifyingCharacteristic<LineDataSet>})
//            .reduce(into: [CBUUID: String](), { partialResult, val in
//                let nc = val.value as! NotifyingCharacteristic<LineDataSet>
//                partialResult[nc.uuid] = val.label!
//            })
        
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
