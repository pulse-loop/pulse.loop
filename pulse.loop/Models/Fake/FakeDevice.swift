//
//  FakeDevice.swift
//  pulse.loop
//
//  Created by Riccardo Persello on 24/10/22.
//

import Foundation
import CharacteristicKit
import CoreBluetooth
import Combine

final class FakeDevice: DeviceProtocol, MockPeripheralModel {
    var valueChangeCancellable: AnyCancellable?

    var state: CBPeripheralState = .connected

    // MARK: Battery service.

    // MARK: Current time service.

    // MARK: Device information service.

    // MARK: Heart rate service.

    // MARK: Pulse oximeter service.

    // MARK: Firmware upgrade service.

    // MARK: Historic data.

    // MARK: Calibration.
    typealias CalibrationAlgorithmConfigurationType = FakeCalibrationAlgorithmConfiguration
    var calibrationAlgorithmConfiguration: CalibrationAlgorithmConfigurationType = FakeCalibrationAlgorithmConfiguration()
    
    // MARK: Electric configuration.
    typealias ElectricConfigurationType = FakeElectricConfiguration
    var electricConfiguration: ElectricConfigurationType = ElectricConfigurationType()

    // MARK: Optical frontend configuration.
    typealias TimingWindowType = FakeTimingWindow
    var timingWindow: TimingWindowType = TimingWindowType()

    // MARK: Sensor data.
    typealias SensorDataType = FakeSensorData
    var sensorData: SensorDataType = SensorDataType()

    // MARK: Settings.

    // MARK: pulse.loop identifier.
    @Published var apiVersion: Int = 1

    // MARK: Additional properties.
    var name: String = "Fake Device"
    @Published var dataWindowLength: TimeInterval = 5

    // MARK: Internal variables.
    private var updateTimer: DispatchSourceTimer?
    private var counter: Float = 0

    // MARK: Control functions.

    // swiftlint:disable all
    func connect() {
        let queue = DispatchQueue(label: "FakeDevice", qos: .userInteractive)
        self.updateTimer = DispatchSource.makeTimerSource(queue: queue)
        self.updateTimer?.schedule(deadline: .now(), repeating: .milliseconds(50))
        self.updateTimer?.setEventHandler { [weak self] in
            guard let self else { return }

            func generateModulatedSineWave(phase: Float32,
                                           frequency: Float32,
                                           envelopePhase: Float32,
                                           envelopeAmplitude: Float32,
                                           envelopeOffset: Float32,
                                           envelopeFrequency: Float32) -> (Int32, Int32, Int32) {

                let envelope = envelopeOffset + envelopeAmplitude * sinf((self.counter * envelopeFrequency) + envelopePhase)
                let value = envelope * sinf((self.counter * frequency) + phase)

                return (Int32(envelope * 1_000_000), Int32(-envelope * 1_000_000), Int32(value * 1_000_000))
            }

            // Aggregated data generator.
            var newPoint = RawOpticalData()
            (_,
             _,
             newPoint.ambientReading) = generateModulatedSineWave(phase: 0,
                                                                  frequency: 10,
                                                                  envelopePhase: 0,
                                                                  envelopeAmplitude: 10,
                                                                  envelopeOffset: 5,
                                                                  envelopeFrequency: 1)

            (_,
             _,
             newPoint.led1Reading) = generateModulatedSineWave(phase: 4,
                                                               frequency: 5,
                                                               envelopePhase: -1,
                                                               envelopeAmplitude: 2,
                                                               envelopeOffset: 0,
                                                               envelopeFrequency: 2)

            (_,
             _,
             newPoint.led2Reading) = generateModulatedSineWave(phase: 2,
                                                               frequency: 40,
                                                               envelopePhase: -4,
                                                               envelopeAmplitude: 15,
                                                               envelopeOffset: -5,
                                                               envelopeFrequency: 3)

            (_,
             _,
             newPoint.led3Reading) = generateModulatedSineWave(phase: 6,
                                                               frequency: 3,
                                                               envelopePhase: -7,
                                                               envelopeAmplitude: 5,
                                                               envelopeOffset: -1,
                                                               envelopeFrequency: 8)

            self.counter += 0.01

            DispatchQueue.main.async {
                self.sensorData.rawOpticalData.value = newPoint
                self.objectWillChange.send()
            }
        }

        // swiftlint:enable all

        self.updateTimer?.resume()
    }

    func disconnect() {
        self.updateTimer?.cancel()
        self.updateTimer = nil
    }
}

extension FakeDevice {
    static func == (lhs: FakeDevice, rhs: FakeDevice) -> Bool {
        true
    }
}
