//
//  FakeDevice.swift
//  pulse.loop
//
//  Created by Riccardo Persello on 24/10/22.
//

import Foundation

class FakeDevice: DeviceProtocol {
    
    // MARK: Battery service.
    
    // MARK: Current time service.
    
    // MARK: Device information service.
    
    // MARK: Heart rate service.
    
    // MARK: Pulse oximeter service.
    
    // MARK: Firmware upgrade service.
    
    // MARK: Historic data.
    
    // MARK: Optical frontend configuration.
    typealias OpticalFrontendWindowType = FakeOpticalFrontendWindow
    var opticalFrontendWindow: OpticalFrontendWindowType = OpticalFrontendWindowType()
        
    // MARK: Raw sensor data.
    typealias OpticalFrontendRawSensorDataType = FakeOpticalFrontendRawSensorData
    var rawData: OpticalFrontendRawSensorDataType = OpticalFrontendRawSensorDataType()
    
    // MARK: Settings.
    
    // MARK: pulse.loop identifier.
    @Published var apiVersion: Int = 1
    
    // MARK: Additional properties.
    var name: String = "Fake Device"
    var status: DeviceStatus = .connected
    @Published var dataWindowLength: TimeInterval = 5
    
    // MARK: Internal variables.
    private var updateTimer: DispatchSourceTimer?
    private var counter: Float = 0
    
    // MARK: Control functions.
    func connect() {
        let queue = DispatchQueue(label: "FakeDevice", qos: .userInteractive)
        self.updateTimer = DispatchSource.makeTimerSource(queue: queue)
        self.updateTimer?.schedule(deadline: .now(), repeating: .milliseconds(100))
        self.updateTimer?.setEventHandler { [weak self] in
            guard let self else { return }
            
            let new = sinf(self.counter) * 100
            self.counter += 0.1
            
            self.rawData.ambient.setLocalValue(value: new)
            self.rawData.led1MinusAmbient.setLocalValue(value: new)
            self.rawData.led1.setLocalValue(value: new)
            self.rawData.led2.setLocalValue(value: new)
            self.rawData.led3.setLocalValue(value: new)
            
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
