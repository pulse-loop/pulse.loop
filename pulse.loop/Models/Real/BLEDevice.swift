//
//  BLEDevice.swift
//  pulse.loop
//
//  Created by Riccardo Persello on 05/11/22.
//

import Foundation
import CoreBluetooth
import OSLog
import CharacteristicKit
import Combine

final class BLEDevice: DeviceProtocol, PeripheralModel {
    
    static var requiredAdvertisedServices: [CBUUID]? = [CBUUIDs.pulseLoopIdentifierServiceIdentifier]
    static var servicesToScan: [CBUUID]?
    static var centralManager: CBCentralManager?
    static var centralManagerDelegate: CBCentralManagerDelegate?

    var valueChangeCancellable: AnyCancellable?

    var peripheral: CBPeripheral
    var delegate: PeripheralDelegate<BLEDevice>?

    internal var logger: Logger

    // MARK: Initialisers.
    init(from peripheral: CBPeripheral) {
        self.logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: "Bluetooth Device Model")
        logger.info("Initialising a new device from Core Bluetooth peripheral \"\(peripheral)\".")

        self.peripheral = peripheral

        // Characteristic container structs.
        self.calibrationAlgorithmConfiguration = CalibrationAlgorithmConfiguration()
        self.electricConfiguration = ElectricConfiguration()
        self.timingWindow = TimingWindow()
        self.sensorData = SensorData()
        self.results = ResultsData()

        // Delegate.
        self.initialiseDelegate()
    }

    // MARK: Battery service.

    // MARK: Current time service.

    // MARK: Device information service.

    // MARK: Heart rate service.

    // MARK: Pulse oximeter service.

    // MARK: Firmware upgrade service.

    // MARK: Historic data.
    
    // MARK: Calibration.
    typealias CalibrationAlgorithmConfigurationType = CalibrationAlgorithmConfiguration
    var calibrationAlgorithmConfiguration: CalibrationAlgorithmConfigurationType

    // MARK: Electric configuration.
    typealias ElectricConfigurationType = ElectricConfiguration
    var electricConfiguration: ElectricConfigurationType

    // MARK: Optical frontend configuration.
    typealias TimingWindowType = TimingWindow
    var timingWindow: TimingWindowType

    // MARK: Results.
    typealias ResultsDataType = ResultsData
    var results: ResultsDataType
    
    // MARK: Sensor data.
    typealias SensorDataType = SensorData
    var sensorData: SensorDataType

    // MARK: Settings.

    // MARK: pulse.loop identifier.
    var apiVersion: Int = 0

    // MARK: Additional properties.
    var name: String { peripheral.name ?? "Unnamed device" }
    var dataWindowLength: TimeInterval = 5
}

extension BLEDevice: Equatable {
    static func == (lhs: BLEDevice, rhs: BLEDevice) -> Bool {
        return rhs.peripheral == lhs.peripheral
    }
}
