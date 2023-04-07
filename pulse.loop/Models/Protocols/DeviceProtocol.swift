//
//  DeviceProtocol.swift
//  pulse.loop
//
//  Created by Riccardo Persello on 24/10/22.
//

import Foundation
import CharacteristicKit
import CoreBluetooth

protocol DeviceProtocol: GenericPeripheralModel, Equatable {

    // MARK: Battery service.

    // MARK: Current time service.

    // MARK: Device information service.

    // MARK: Heart rate service.

    // MARK: Pulse oximeter service.

    // MARK: Firmware upgrade service.

    // MARK: Historic data.
    
    // MARK: Calibration.
    associatedtype CalibrationAlgorithmConfigurationType: CalibrationAlgorithmConfigurationProtocol
    var calibrationAlgorithmConfiguration: CalibrationAlgorithmConfigurationType { get set }

    // MARK: Electric configuration.
    associatedtype ElectricConfigurationType: ElectricConfigurationProtocol
    var electricConfiguration: ElectricConfigurationType { get set }

    // MARK: Optical frontend configuration.
    associatedtype TimingWindowType: TimingWindowProtocol
    var timingWindow: TimingWindowType { get set }

    // MARK: Sensor data.
    associatedtype SensorDataType: SensorDataProtocol
    var sensorData: SensorDataType { get }

    // MARK: Settings.

    // MARK: pulse.loop identifier.
    var apiVersion: Int { get }

    // MARK: Additional properties.
    var name: String { get }
    var dataWindowLength: TimeInterval { get set }
}
