//
//  FakeOpticalFrontendConfiguration.swift
//  pulse.loop
//
//  Created by Riccardo Persello on 03/11/22.
//

import Foundation

class FakeOpticalFrontendConfiguration: OpticalFrontendConfigurationProtocol {
        
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
    @Published var tiaCapacitor1: FakeCharacteristic<TIACapacitor>
    @Published var tiaCapacitor2: FakeCharacteristic<TIACapacitor>
    @Published var tiaResistor1: FakeCharacteristic<TIAResistor>
    @Published var tiaResistor2: FakeCharacteristic<TIAResistor>
    
    init(ambientPhase: AmbientPhaseType, LED1Phase: LEDPhase, LED2Phase: LEDPhase, LED3Phase: LEDPhase, totalWindowLength: TimeInterval, dynamicPowerDown: DynamicPowerDownPhaseType, tiaCapacitor1: TIACapacitor, tiaCapacitor2: TIACapacitor, tiaResistor1: TIAResistor, tiaResistor2: TIAResistor) {
        self.ambientPhase = ambientPhase
        self.LED1Phase = LED1Phase
        self.LED2Phase = LED2Phase
        self.LED3Phase = LED3Phase
        self.totalWindowLength = .init(constant: totalWindowLength)
        self.dynamicPowerDown = dynamicPowerDown
        self.tiaCapacitor1 = .init(constant: tiaCapacitor1)
        self.tiaCapacitor2 = .init(constant: tiaCapacitor2)
        self.tiaResistor1 = .init(constant: tiaResistor1)
        self.tiaResistor2 = .init(constant: tiaResistor2)
    }
}
