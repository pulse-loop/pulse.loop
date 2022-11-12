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
    typealias OpticalFrontendConfigurationType = FakeOpticalFrontendConfiguration
    private var opticalFrontendConfiguration: OpticalFrontendConfigurationType
    
    func getOpticalFrontendConfiguration() -> OpticalFrontendConfigurationType {
        return self.opticalFrontendConfiguration
    }
    
    func setOpticalFrontendConfiguration(_ configuration: OpticalFrontendConfigurationType) {
        self.opticalFrontendConfiguration = configuration
    }
    
    // MARK: Raw sensor data.
    var rawOpticalAmbient: [OpticalSensorReading] = []
    var rawOpticalLED1MinusAmbient: [OpticalSensorReading] = []
    var rawOpticalLED1: [OpticalSensorReading] = []
    var rawOpticalLED2: [OpticalSensorReading] = []
    var rawOpticalLED3: [OpticalSensorReading] = []
    
    // MARK: Settings.
    
    // MARK: pulse.loop identifier.
    @Published var apiVersion: Int = 1
    
    // MARK: Additional properties.
    var name: String = "Fake Device"
    var status: DeviceStatus = .connected
    @Published var dataWindowLength: TimeInterval = 10
    
    // MARK: Internal variables.
    private var updateTimer: DispatchSourceTimer?

    // MARK: Initialisers.
    init() {
        self.opticalFrontendConfiguration = FakeOpticalFrontendConfiguration(
            ambientPhase: FakeOpticalFrontendConfiguration.AmbientPhaseType(
                sample_st: TimeInterval(microseconds: 2225),
                sample_end: TimeInterval(microseconds: 2299.75),
                reset_st: TimeInterval(microseconds: 2600),
                reset_end: TimeInterval(microseconds: 2610),
                conv_st: TimeInterval(microseconds: 2300),
                conv_end: TimeInterval(microseconds: 2500)
            ),
            LED1Phase: FakeOpticalFrontendConfiguration.LEDPhase(
                led_st: TimeInterval(microseconds: 1100),
                led_end: TimeInterval(microseconds: 1400),
                sample_st: TimeInterval(microseconds: 1225),
                sample_end: TimeInterval(microseconds: 1299.75),
                reset_st: TimeInterval(microseconds: 1600),
                reset_end: TimeInterval(microseconds: 1605),
                conv_st: TimeInterval(microseconds: 1300),
                conv_end: TimeInterval(microseconds: 1500)
            ),
            LED2Phase: FakeOpticalFrontendConfiguration.LEDPhase(
                led_st: TimeInterval(microseconds: 100),
                led_end: TimeInterval(microseconds: 400),
                sample_st: TimeInterval(microseconds: 225),
                sample_end: TimeInterval(microseconds: 299.75),
                reset_st: TimeInterval(microseconds: 600),
                reset_end: TimeInterval(microseconds: 601),
                conv_st: TimeInterval(microseconds: 300),
                conv_end: TimeInterval(microseconds: 500)
            ),
            LED3Phase: FakeOpticalFrontendConfiguration.LEDPhase(
                led_st: TimeInterval(microseconds: 3100),
                led_end: TimeInterval(microseconds: 3400),
                sample_st: TimeInterval(microseconds: 3225),
                sample_end: TimeInterval(microseconds: 3299.75),
                reset_st: TimeInterval(microseconds: 3600),
                reset_end: TimeInterval(microseconds: 3630),
                conv_st: TimeInterval(microseconds: 3300),
                conv_end: TimeInterval(microseconds: 3500)
            ),
            totalWindowLength: TimeInterval(microseconds: 10000),
            dynamicPowerDown: FakeOpticalFrontendConfiguration.DynamicPowerDownPhaseType(
                start: TimeInterval(microseconds: 5000),
                end: TimeInterval(microseconds: 10000)
            ),
            tiaCapacitor1: .C_10_pF,
            tiaCapacitor2: .C_17_5_pF,
            tiaResistor1: .R_100_kΩ,
            tiaResistor2: .R_1_MΩ
        )
    }
    
    // MARK: Control functions.
    func connect() {
        let queue = DispatchQueue(label: Bundle.main.bundleIdentifier! + "FakeDevice.timer")
        self.updateTimer = DispatchSource.makeTimerSource(queue: queue)
        self.updateTimer?.schedule(deadline: .now(), repeating: .milliseconds(100))
        self.updateTimer?.setEventHandler { [weak self] in
            guard let self else { return }
            self.rawOpticalAmbient.append(OpticalSensorReading(Int32.random(in: 0...100)))
            self.rawOpticalLED1MinusAmbient.append(OpticalSensorReading(Int32.random(in: 0...100)))
            self.rawOpticalLED1.append(OpticalSensorReading(Int32.random(in: 0...100)))
            self.rawOpticalLED2.append(OpticalSensorReading(Int32.random(in: 0...100)))
            self.rawOpticalLED3.append(OpticalSensorReading(Int32.random(in: 0...100)))
            
            self.rawOpticalAmbient.removeAll(where: {$0.date.addingTimeInterval(self.dataWindowLength) < Date.now})
            self.rawOpticalLED1MinusAmbient.removeAll(where: {$0.date.addingTimeInterval(self.dataWindowLength) < Date.now})
            self.rawOpticalLED1.removeAll(where: {$0.date.addingTimeInterval(self.dataWindowLength) < Date.now})
            self.rawOpticalLED2.removeAll(where: {$0.date.addingTimeInterval(self.dataWindowLength) < Date.now})
            self.rawOpticalLED3.removeAll(where: {$0.date.addingTimeInterval(self.dataWindowLength) < Date.now})
            
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

extension FakeDevice: Equatable {
    static func == (lhs: FakeDevice, rhs: FakeDevice) -> Bool {
        true
    }
}