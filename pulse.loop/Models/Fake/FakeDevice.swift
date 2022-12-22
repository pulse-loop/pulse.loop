//
//  FakeDevice.swift
//  pulse.loop
//
//  Created by Riccardo Persello on 24/10/22.
//

import Foundation
import CharacteristicKit
import CoreBluetooth

final class FakeDevice: DeviceProtocol, MockPeripheralModel {
    
    // MARK: Battery service.
    
    // MARK: Current time service.
    
    // MARK: Device information service.
    
    // MARK: Heart rate service.
    
    // MARK: Pulse oximeter service.
    
    // MARK: Firmware upgrade service.
    
    // MARK: Historic data.
    
    // MARK: Electric configuration.
    typealias ElectricConfigurationType = FakeElectricConfiguration
    var electricConfiguration: ElectricConfigurationType = ElectricConfigurationType()
    
    // MARK: Optical frontend configuration.
    typealias TimingWindowType = FakeTimingWindow
    var timingWindow: TimingWindowType = TimingWindowType()
        
    // MARK: Raw sensor data.
    typealias RawSensorDataType = FakeRawSensorData
    var rawSensorData: RawSensorDataType = RawSensorDataType()
    
    // MARK: Settings.
    
    // MARK: pulse.loop identifier.
    @Published var apiVersion: Int = 1
    
    // MARK: Additional properties.
    var name: String = "Fake Device"
    var status: PeripheralStatus = .connected
    @Published var dataWindowLength: TimeInterval = 5
    
    // MARK: Internal variables.
    private var updateTimer: DispatchSourceTimer?
    private var counter: Float = 0
//    var delegate: PeripheralDelegate<FakeDevice>?
//    var peripheral: CBPeripheral?
    
    // MARK: Control functions.
    func connect() {
        let queue = DispatchQueue(label: "FakeDevice", qos: .userInteractive)
        self.updateTimer = DispatchSource.makeTimerSource(queue: queue)
        self.updateTimer?.schedule(deadline: .now(), repeating: .milliseconds(100))
        self.updateTimer?.setEventHandler { [weak self] in
            guard let self else { return }
            
            let new = sinf(self.counter) * 100
            self.counter += 0.1
            
            self.rawSensorData.ambient.setLocalValue(value: new)
            self.rawSensorData.led1MinusAmbient.setLocalValue(value: new)
            self.rawSensorData.led1.setLocalValue(value: new)
            self.rawSensorData.led2.setLocalValue(value: new)
            self.rawSensorData.led3.setLocalValue(value: new)
            
            DispatchQueue.main.async {
                self.objectWillChange.send()
            }
        }
        
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
