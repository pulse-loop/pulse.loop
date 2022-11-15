//
//  BLEDevice.swift
//  pulse.loop
//
//  Created by Riccardo Persello on 05/11/22.
//

import Foundation
import CoreBluetooth
import SwiftUICharts
import OSLog

class BLEDevice: DeviceProtocol {
    
    internal var logger: Logger
    
    // MARK: Initialisers.
    init(from peripheral: CBPeripheral) {
        self.logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: "Bluetooth Device Model")
        logger.info("Initialising a new device from CoreBluetooth peripheral \"\(peripheral)\".")
        
        self.peripheral = peripheral
        self.deviceDelegate = BLEDeviceDelegate(device: self)
                
        peripheral.delegate = self.deviceDelegate
    }
    
    // MARK: Battery service.
    
    // MARK: Current time service.
    
    // MARK: Device information service.
    
    // MARK: Heart rate service.
    
    // MARK: Pulse oximeter service.
    
    // MARK: Firmware upgrade service.
    
    // MARK: Historic data.
    
    // MARK: Optical frontend configuration.
    typealias OpticalFrontendConfigurationType = OpticalFrontendConfiguration
    func getOpticalFrontendConfiguration() -> OpticalFrontendConfigurationType {
        return OpticalFrontendConfiguration()
    }
    
    func setOpticalFrontendConfiguration(_ configuration: OpticalFrontendConfigurationType) {
        
    }
    
    // MARK: Raw sensor data.
    @NotifyingCharacteristic(uuid: CBUUIDs.ambientADCReadingCharacteristicIdentifier)
    var rawOpticalAmbient: LineDataSet = LineDataSet(dataPoints: [])
    @NotifyingCharacteristic(uuid: CBUUIDs.led1MinusAmbientCharacteristicIdentifier)
    var rawOpticalLED1MinusAmbient: LineDataSet = LineDataSet(dataPoints: [])
    @NotifyingCharacteristic(uuid: CBUUIDs.led1ADCReadingCharacteristicIdentifier)
    var rawOpticalLED1: LineDataSet = LineDataSet(dataPoints: [])
    @NotifyingCharacteristic(uuid: CBUUIDs.led2ADCReadingCharacteristicIdentifier)
    var rawOpticalLED2: LineDataSet = LineDataSet(dataPoints: [])
    @NotifyingCharacteristic(uuid: CBUUIDs.led3ADCReadingCharacteristicIdentifier)
    var rawOpticalLED3: LineDataSet = LineDataSet(dataPoints: [])
    
    // MARK: Settings.
    
    // MARK: pulse.loop identifier.
    var apiVersion: Int = 0
    
    // MARK: Additional properties.
    var name: String { peripheral.name ?? "Unnamed device" }
    @Published var status: DeviceStatus = .disconnected
    @Published var dataWindowLength: TimeInterval = 5
    
    // MARK: Internal variables.
    var peripheral: CBPeripheral!
    private var deviceDelegate: CBPeripheralDelegate!
    
    // MARK: Control functions.
    func connect() {
        DeviceManager.shared.connect(to: self)
    }
    
    func disconnect() {
        DeviceManager.shared.disconnect(from: self)
    }
}

protocol CharacteristicWrapper {
    var uuid: CBUUID { get }
}

@propertyWrapper
struct NotifyingCharacteristic<T>: CharacteristicWrapper {
    let uuid: CBUUID
    var wrappedValue: T
    
    init(wrappedValue: T, uuid: CBUUID) {
        self.uuid = uuid
        self.wrappedValue = wrappedValue
    }
}

struct PollingCharacteristic<T>: CharacteristicWrapper {
    let uuid: CBUUID
    var wrappedValue: T
    
    init(wrappedValue: T, uuid: CBUUID) {
        self.uuid = uuid
        self.wrappedValue = wrappedValue
    }
}

extension BLEDevice: Equatable {
    static func == (lhs: BLEDevice, rhs: BLEDevice) -> Bool {
        return rhs.peripheral == lhs.peripheral
    }
}
