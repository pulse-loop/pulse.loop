//
//  FakeOpticalFrontendWindow.swift
//  pulse.loop
//
//  Created by Riccardo Persello on 03/11/22.
//

import Foundation
import CharacteristicKit

class FakeOpticalFrontendWindow: OpticalFrontendWindowProtocol {
        
    class LEDPhase: LEDPhaseProtocol {
        @Published var led_st: FakeCharacteristic<Float32>
        @Published var led_end: FakeCharacteristic<Float32>
        @Published var sample_st: FakeCharacteristic<Float32>
        @Published var sample_end: FakeCharacteristic<Float32>
        @Published var reset_st: FakeCharacteristic<Float32>
        @Published var reset_end: FakeCharacteristic<Float32>
        @Published var conv_st: FakeCharacteristic<Float32>
        @Published var conv_end: FakeCharacteristic<Float32>
        
        init(led_st: Float32, led_end: Float32, sample_st: Float32, sample_end: Float32, reset_st: Float32, reset_end: Float32, conv_st: Float32, conv_end: Float32) {
            self.led_st = FakeCharacteristic(constant: led_st)
            self.led_end = FakeCharacteristic(constant: led_end)
            self.sample_st = FakeCharacteristic(constant: sample_st)
            self.sample_end = FakeCharacteristic(constant: sample_end)
            self.reset_st = FakeCharacteristic(constant: reset_st)
            self.reset_end = FakeCharacteristic(constant: reset_end)
            self.conv_st = FakeCharacteristic(constant: conv_st)
            self.conv_end = FakeCharacteristic(constant: conv_end)
        }
    }
    
    class AmbientPhaseType: AmbientPhaseProtocol {
        @Published var sample_st: FakeCharacteristic<Float32>
        @Published var sample_end: FakeCharacteristic<Float32>
        @Published var reset_st: FakeCharacteristic<Float32>
        @Published var reset_end: FakeCharacteristic<Float32>
        @Published var conv_st: FakeCharacteristic<Float32>
        @Published var conv_end: FakeCharacteristic<Float32>
        
        init(sample_st: Float32, sample_end: Float32, reset_st: Float32, reset_end: Float32, conv_st: Float32, conv_end: Float32) {
            self.sample_st = .init(constant: sample_st)
            self.sample_end = .init(constant: sample_end)
            self.reset_st = .init(constant: reset_st)
            self.reset_end = .init(constant: reset_end)
            self.conv_st = .init(constant: conv_st)
            self.conv_end = .init(constant: conv_end)
        }
    }
    
    class DynamicPowerDownPhaseType: DynamicPowerDownPhaseProtocol {
        @Published var start: FakeCharacteristic<Float32>
        @Published var end: FakeCharacteristic<Float32>
        
        init(start: Float32, end: Float32) {
            self.start = .init(constant: start)
            self.end = .init(constant: end)
        }
    }
    
    @Published var ambientPhase: AmbientPhaseType
    @Published var LED1Phase: LEDPhase
    @Published var LED2Phase: LEDPhase
    @Published var LED3Phase: LEDPhase
    @Published var totalWindowLength: FakeCharacteristic<Float32>
    @Published var dynamicPowerDown: DynamicPowerDownPhaseType
    
    init(ambientPhase: AmbientPhaseType, LED1Phase: LEDPhase, LED2Phase: LEDPhase, LED3Phase: LEDPhase, totalWindowLength: Float32, dynamicPowerDown: DynamicPowerDownPhaseType) {
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
                sample_st: Float32(microseconds: 2225),
                sample_end: Float32(microseconds: 2299.75),
                reset_st: Float32(microseconds: 2600),
                reset_end: Float32(microseconds: 2610),
                conv_st: Float32(microseconds: 2300),
                conv_end: Float32(microseconds: 2500)
            ),
            LED1Phase: FakeOpticalFrontendWindow.LEDPhase(
                led_st: Float32(microseconds: 1100),
                led_end: Float32(microseconds: 1400),
                sample_st: Float32(microseconds: 1225),
                sample_end: Float32(microseconds: 1299.75),
                reset_st: Float32(microseconds: 1600),
                reset_end: Float32(microseconds: 1605),
                conv_st: Float32(microseconds: 1300),
                conv_end: Float32(microseconds: 1500)
            ),
            LED2Phase: FakeOpticalFrontendWindow.LEDPhase(
                led_st: Float32(microseconds: 100),
                led_end: Float32(microseconds: 400),
                sample_st: Float32(microseconds: 225),
                sample_end: Float32(microseconds: 299.75),
                reset_st: Float32(microseconds: 600),
                reset_end: Float32(microseconds: 601),
                conv_st: Float32(microseconds: 300),
                conv_end: Float32(microseconds: 500)
            ),
            LED3Phase: FakeOpticalFrontendWindow.LEDPhase(
                led_st: Float32(microseconds: 3100),
                led_end: Float32(microseconds: 3400),
                sample_st: Float32(microseconds: 3225),
                sample_end: Float32(microseconds: 3299.75),
                reset_st: Float32(microseconds: 3600),
                reset_end: Float32(microseconds: 3630),
                conv_st: Float32(microseconds: 3300),
                conv_end: Float32(microseconds: 3500)
            ),
            totalWindowLength: Float32(microseconds: 10000),
            dynamicPowerDown: FakeOpticalFrontendWindow.DynamicPowerDownPhaseType(
                start: Float32(microseconds: 5000),
                end: Float32(microseconds: 10000)
            )
        )
    }
}
