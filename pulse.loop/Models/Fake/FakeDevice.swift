//
//  FakeDevice.swift
//  pulse.loop
//
//  Created by Riccardo Persello on 24/10/22.
//

import Foundation

class FakeDevice: DeviceProtocol {
    @Published var rawOpticalAmbient: [OpticalSensorReading] = []
    @Published var rawOpticalLED1MinusAmbient: [OpticalSensorReading] = []
    @Published var rawOpticalLED1: [OpticalSensorReading] = []
    @Published var rawOpticalLED2: [OpticalSensorReading] = []
    @Published var rawOpticalLED3: [OpticalSensorReading] = []
    @Published var opticalFrontendConfiguration: FakeOpticalFrontendConfiguration
    @Published var apiVersion: Int = 1

    init() {
        self.opticalFrontendConfiguration = FakeOpticalFrontendConfiguration(
            ambientPhase: FakeOpticalFrontendConfiguration.AmbientPhase(
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
            dynamicPowerDown: FakeOpticalFrontendConfiguration.DynamicPowerDownPhase(
                start: TimeInterval(microseconds: 5000),
                end: TimeInterval(microseconds: 10000)
            ),
            tiaCapacitor1: .C_10_pF,
            tiaCapacitor2: .C_17_5_pF,
            tiaResistor1: .R_100_kΩ,
            tiaResistor2: .R_1_MΩ
        )
        
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { _ in
            self.rawOpticalAmbient.append(OpticalSensorReading(Int32.random(in: 0...100)))
            self.rawOpticalLED1MinusAmbient.append(OpticalSensorReading(Int32.random(in: 0...100)))
            self.rawOpticalLED1.append(OpticalSensorReading(Int32.random(in: 0...100)))
            self.rawOpticalLED2.append(OpticalSensorReading(Int32.random(in: 0...100)))
            self.rawOpticalLED3.append(OpticalSensorReading(Int32.random(in: 0...100)))
        })
    }
}
