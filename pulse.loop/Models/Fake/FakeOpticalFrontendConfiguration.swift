//
//  FakeOpticalFrontendConfiguration.swift
//  pulse.loop
//
//  Created by Riccardo Persello on 03/11/22.
//

import Foundation

class FakeOpticalFrontendConfiguration: OpticalFrontendConfigurationProtocol {
        
    class LEDPhase: LEDPhaseProtocol {
        @Published var led_st: TimeInterval
        @Published var led_end: TimeInterval
        @Published var sample_st: TimeInterval
        @Published var sample_end: TimeInterval
        @Published var reset_st: TimeInterval
        @Published var reset_end: TimeInterval
        @Published var conv_st: TimeInterval
        @Published var conv_end: TimeInterval
        
        init(led_st: TimeInterval, led_end: TimeInterval, sample_st: TimeInterval, sample_end: TimeInterval, reset_st: TimeInterval, reset_end: TimeInterval, conv_st: TimeInterval, conv_end: TimeInterval) {
            self.led_st = led_st
            self.led_end = led_end
            self.sample_st = sample_st
            self.sample_end = sample_end
            self.reset_st = reset_st
            self.reset_end = reset_end
            self.conv_st = conv_st
            self.conv_end = conv_end
        }
    }
    
    class AmbientPhase: AmbientPhaseProtocol {
        @Published var sample_st: TimeInterval
        @Published var sample_end: TimeInterval
        @Published var reset_st: TimeInterval
        @Published var reset_end: TimeInterval
        @Published var conv_st: TimeInterval
        @Published var conv_end: TimeInterval
        
        init(sample_st: TimeInterval, sample_end: TimeInterval, reset_st: TimeInterval, reset_end: TimeInterval, conv_st: TimeInterval, conv_end: TimeInterval) {
            self.sample_st = sample_st
            self.sample_end = sample_end
            self.reset_st = reset_st
            self.reset_end = reset_end
            self.conv_st = conv_st
            self.conv_end = conv_end
        }
    }
    
    class DynamicPowerDownPhase: DynamicPowerDownPhaseProtocol {
        @Published var start: TimeInterval
        @Published var end: TimeInterval
        
        init(start: TimeInterval, end: TimeInterval) {
            self.start = start
            self.end = end
        }
    }
    
    @Published var ambientPhase: AmbientPhase
    @Published var LED1Phase: LEDPhase
    @Published var LED2Phase: LEDPhase
    @Published var LED3Phase: LEDPhase
    @Published var totalWindowLength: TimeInterval
    @Published var dynamicPowerDown: DynamicPowerDownPhase
    @Published var tiaCapacitor1: TIACapacitor
    @Published var tiaCapacitor2: TIACapacitor
    @Published var tiaResistor1: TIAResistor
    @Published var tiaResistor2: TIAResistor
    
    init(ambientPhase: AmbientPhase, LED1Phase: LEDPhase, LED2Phase: LEDPhase, LED3Phase: LEDPhase, totalWindowLength: TimeInterval, dynamicPowerDown: DynamicPowerDownPhase, tiaCapacitor1: TIACapacitor, tiaCapacitor2: TIACapacitor, tiaResistor1: TIAResistor, tiaResistor2: TIAResistor) {
        self.ambientPhase = ambientPhase
        self.LED1Phase = LED1Phase
        self.LED2Phase = LED2Phase
        self.LED3Phase = LED3Phase
        self.totalWindowLength = totalWindowLength
        self.dynamicPowerDown = dynamicPowerDown
        self.tiaCapacitor1 = tiaCapacitor1
        self.tiaCapacitor2 = tiaCapacitor2
        self.tiaResistor1 = tiaResistor1
        self.tiaResistor2 = tiaResistor2
    }
}
