//
//  FakeOpticalFrontendWindow.swift
//  pulse.loop
//
//  Created by Riccardo Persello on 03/11/22.
//

import Foundation

class FakeOpticalFrontendWindow: OpticalFrontendWindowProtocol {
        
    class LEDPhase: LEDPhaseProtocol {
        @Published var led_st: FakeCharacteristic<TimeInterval>
        @Published var led_end: FakeCharacteristic<TimeInterval>
        @Published var sample_st: FakeCharacteristic<TimeInterval>
        @Published var sample_end: FakeCharacteristic<TimeInterval>
        @Published var reset_st: FakeCharacteristic<TimeInterval>
        @Published var reset_end: FakeCharacteristic<TimeInterval>
        @Published var conv_st: FakeCharacteristic<TimeInterval>
        @Published var conv_end: FakeCharacteristic<TimeInterval>
        
        init(led_st: TimeInterval, led_end: TimeInterval, sample_st: TimeInterval, sample_end: TimeInterval, reset_st: TimeInterval, reset_end: TimeInterval, conv_st: TimeInterval, conv_end: TimeInterval) {
            self.led_st = .init(constant: led_st)
            self.led_end = .init(constant: led_end)
            self.sample_st = .init(constant: sample_st)
            self.sample_end = .init(constant: sample_end)
            self.reset_st = .init(constant: reset_st)
            self.reset_end = .init(constant: reset_end)
            self.conv_st = .init(constant: conv_st)
            self.conv_end = .init(constant: conv_end)
        }
    }
    
    class AmbientPhaseType: AmbientPhaseProtocol {
        @Published var sample_st: FakeCharacteristic<TimeInterval>
        @Published var sample_end: FakeCharacteristic<TimeInterval>
        @Published var reset_st: FakeCharacteristic<TimeInterval>
        @Published var reset_end: FakeCharacteristic<TimeInterval>
        @Published var conv_st: FakeCharacteristic<TimeInterval>
        @Published var conv_end: FakeCharacteristic<TimeInterval>
        
        init(sample_st: TimeInterval, sample_end: TimeInterval, reset_st: TimeInterval, reset_end: TimeInterval, conv_st: TimeInterval, conv_end: TimeInterval) {
            self.sample_st = .init(constant: sample_st)
            self.sample_end = .init(constant: sample_end)
            self.reset_st = .init(constant: reset_st)
            self.reset_end = .init(constant: reset_end)
            self.conv_st = .init(constant: conv_st)
            self.conv_end = .init(constant: conv_end)
        }
    }
    
    class DynamicPowerDownPhaseType: DynamicPowerDownPhaseProtocol {
        @Published var start: FakeCharacteristic<TimeInterval>
        @Published var end: FakeCharacteristic<TimeInterval>
        
        init(start: TimeInterval, end: TimeInterval) {
            self.start = .init(constant: start)
            self.end = .init(constant: end)
        }
    }
    
    @Published var ambientPhase: AmbientPhaseType
    @Published var LED1Phase: LEDPhase
    @Published var LED2Phase: LEDPhase
    @Published var LED3Phase: LEDPhase
    @Published var totalWindowLength: FakeCharacteristic<TimeInterval>
    @Published var dynamicPowerDown: DynamicPowerDownPhaseType
    
    init(ambientPhase: AmbientPhaseType, LED1Phase: LEDPhase, LED2Phase: LEDPhase, LED3Phase: LEDPhase, totalWindowLength: TimeInterval, dynamicPowerDown: DynamicPowerDownPhaseType) {
        self.ambientPhase = ambientPhase
        self.LED1Phase = LED1Phase
        self.LED2Phase = LED2Phase
        self.LED3Phase = LED3Phase
        self.totalWindowLength = .init(constant: totalWindowLength)
        self.dynamicPowerDown = dynamicPowerDown
    }
    
    convenience init() {
        self.init(
            ambientPhase: FakeOpticalFrontendWindow.AmbientPhaseType(
                sample_st: TimeInterval(microseconds: 2225),
                sample_end: TimeInterval(microseconds: 2299.75),
                reset_st: TimeInterval(microseconds: 2600),
                reset_end: TimeInterval(microseconds: 2610),
                conv_st: TimeInterval(microseconds: 2300),
                conv_end: TimeInterval(microseconds: 2500)
            ),
            LED1Phase: FakeOpticalFrontendWindow.LEDPhase(
                led_st: TimeInterval(microseconds: 1100),
                led_end: TimeInterval(microseconds: 1400),
                sample_st: TimeInterval(microseconds: 1225),
                sample_end: TimeInterval(microseconds: 1299.75),
                reset_st: TimeInterval(microseconds: 1600),
                reset_end: TimeInterval(microseconds: 1605),
                conv_st: TimeInterval(microseconds: 1300),
                conv_end: TimeInterval(microseconds: 1500)
            ),
            LED2Phase: FakeOpticalFrontendWindow.LEDPhase(
                led_st: TimeInterval(microseconds: 100),
                led_end: TimeInterval(microseconds: 400),
                sample_st: TimeInterval(microseconds: 225),
                sample_end: TimeInterval(microseconds: 299.75),
                reset_st: TimeInterval(microseconds: 600),
                reset_end: TimeInterval(microseconds: 601),
                conv_st: TimeInterval(microseconds: 300),
                conv_end: TimeInterval(microseconds: 500)
            ),
            LED3Phase: FakeOpticalFrontendWindow.LEDPhase(
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
            dynamicPowerDown: FakeOpticalFrontendWindow.DynamicPowerDownPhaseType(
                start: TimeInterval(microseconds: 5000),
                end: TimeInterval(microseconds: 10000)
            )
        )
    }
}
