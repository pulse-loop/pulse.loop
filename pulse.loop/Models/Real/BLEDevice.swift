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

class BLEDevice: NSObject, DeviceProtocol {

    internal var logger: Logger
    
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
    @Published var rawOpticalAmbient: LineDataSet = LineDataSet(dataPoints: [])
    @Published var rawOpticalLED1MinusAmbient: LineDataSet = LineDataSet(dataPoints: [])
    @Published var rawOpticalLED1: LineDataSet = LineDataSet(dataPoints: [])
    @Published var rawOpticalLED2: LineDataSet = LineDataSet(dataPoints: [])
    @Published var rawOpticalLED3: LineDataSet = LineDataSet(dataPoints: [])
    
    // MARK: Settings.
    
    // MARK: pulse.loop identifier.
    var apiVersion: Int = 0
        
    // MARK: Additional properties.
    var name: String {
        peripheral.name ?? "Unnamed device"
    }
    @Published var status: DeviceStatus = .disconnected
    @Published var dataWindowLength: TimeInterval = 5
        
    // MARK: Internal variables.
    var peripheral: CBPeripheral
    let realTimeVariablesMap: [CBUUID: ReferenceWritableKeyPath<BLEDevice, LineDataSet>] = [
        CBUUIDs.ambientADCReadingCharacteristicIdentifier: \.rawOpticalAmbient,
        CBUUIDs.led1MinusAmbientCharacteristicIdentifier: \.rawOpticalLED1MinusAmbient,
        CBUUIDs.led1ADCReadingCharacteristicIdentifier: \.rawOpticalLED1,
        CBUUIDs.led2ADCReadingCharacteristicIdentifier: \.rawOpticalLED2,
        CBUUIDs.led3ADCReadingCharacteristicIdentifier: \.rawOpticalLED3
    ]
    
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
