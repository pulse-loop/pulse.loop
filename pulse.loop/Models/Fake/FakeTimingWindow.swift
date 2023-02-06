//
//  FakeTimingWindow.swift
//  pulse.loop
//
//  Created by Riccardo Persello on 03/11/22.
//

import Foundation
import CharacteristicKit

// swiftlint:disable nesting

class FakeTimingWindow: TimingWindowProtocol {

    class LEDPhase: LEDPhaseProtocol {
        typealias TimeIntervalType = MockCharacteristic<Float32>

        @Published var ledStart: TimeIntervalType
        @Published var ledEnd: TimeIntervalType
        @Published var sampleStart: TimeIntervalType
        @Published var sampleEnd: TimeIntervalType
        @Published var resetStart: TimeIntervalType
        @Published var resetEnd: TimeIntervalType
        @Published var convStart: TimeIntervalType
        @Published var convEnd: TimeIntervalType

        init(
            ledStart: Float32,
            ledEnd: Float32,
            sampleStart: Float32,
            sampleEnd: Float32,
            resetStart: Float32,
            resetEnd: Float32,
            convStart: Float32,
            convEnd: Float32
        ) {
            self.ledStart = TimeIntervalType(constant: ledStart)
            self.ledEnd = TimeIntervalType(constant: ledEnd)
            self.sampleStart = TimeIntervalType(constant: sampleStart)
            self.sampleEnd = TimeIntervalType(constant: sampleEnd)
            self.resetStart = TimeIntervalType(constant: resetStart)
            self.resetEnd = TimeIntervalType(constant: resetEnd)
            self.convStart = TimeIntervalType(constant: convStart)
            self.convEnd = TimeIntervalType(constant: convEnd)
        }
    }

    class AmbientPhaseType: AmbientPhaseProtocol {
        typealias TimeIntervalType = MockCharacteristic<Float32>

        @Published var sampleStart: TimeIntervalType
        @Published var sampleEnd: TimeIntervalType
        @Published var resetStart: TimeIntervalType
        @Published var resetEnd: TimeIntervalType
        @Published var convStart: TimeIntervalType
        @Published var convEnd: TimeIntervalType

        init(
            sampleStart: Float32,
            sampleEnd: Float32,
            resetStart: Float32,
            resetEnd: Float32,
            convStart: Float32,
            convEnd: Float32
        ) {
            self.sampleStart = TimeIntervalType(constant: sampleStart)
            self.sampleEnd = TimeIntervalType(constant: sampleEnd)
            self.resetStart = TimeIntervalType(constant: resetStart)
            self.resetEnd = TimeIntervalType(constant: resetEnd)
            self.convStart = TimeIntervalType(constant: convStart)
            self.convEnd = TimeIntervalType(constant: convEnd)
        }
    }

    class DynamicPowerDownPhaseType: DynamicPowerDownPhaseProtocol {
        typealias TimeIntervalType = MockCharacteristic<Float32>

        @Published var start: TimeIntervalType
        @Published var end: TimeIntervalType

        init(start: Float32, end: Float32) {
            self.start = .init(constant: start)
            self.end = .init(constant: end)
        }
    }

    typealias TimeIntervalType = MockCharacteristic<Float32>

    @Published var ambientPhase: AmbientPhaseType
    @Published var LED1Phase: LEDPhase
    @Published var LED2Phase: LEDPhase
    @Published var LED3Phase: LEDPhase
    @Published var totalWindowLength: TimeIntervalType
    @Published var dynamicPowerDown: DynamicPowerDownPhaseType

    init(
        ambientPhase: AmbientPhaseType,
        LED1Phase: LEDPhase,
        LED2Phase: LEDPhase,
        LED3Phase: LEDPhase,
        totalWindowLength: Float32,
        dynamicPowerDown: DynamicPowerDownPhaseType
    ) {
        self.ambientPhase = ambientPhase
        self.LED1Phase = LED1Phase
        self.LED2Phase = LED2Phase
        self.LED3Phase = LED3Phase
        self.totalWindowLength = TimeIntervalType(constant: totalWindowLength)
        self.dynamicPowerDown = dynamicPowerDown
    }

    convenience init() {
        self.init(
            ambientPhase: FakeTimingWindow.AmbientPhaseType(
                sampleStart: Float32(microseconds: 2225),
                sampleEnd: Float32(microseconds: 2299.75),
                resetStart: Float32(microseconds: 2600),
                resetEnd: Float32(microseconds: 2610),
                convStart: Float32(microseconds: 2300),
                convEnd: Float32(microseconds: 2500)
            ),
            LED1Phase: FakeTimingWindow.LEDPhase(
                ledStart: Float32(microseconds: 1100),
                ledEnd: Float32(microseconds: 1400),
                sampleStart: Float32(microseconds: 1225),
                sampleEnd: Float32(microseconds: 1299.75),
                resetStart: Float32(microseconds: 1600),
                resetEnd: Float32(microseconds: 1605),
                convStart: Float32(microseconds: 1300),
                convEnd: Float32(microseconds: 1500)
            ),
            LED2Phase: FakeTimingWindow.LEDPhase(
                ledStart: Float32(microseconds: 100),
                ledEnd: Float32(microseconds: 400),
                sampleStart: Float32(microseconds: 225),
                sampleEnd: Float32(microseconds: 299.75),
                resetStart: Float32(microseconds: 600),
                resetEnd: Float32(microseconds: 601),
                convStart: Float32(microseconds: 300),
                convEnd: Float32(microseconds: 500)
            ),
            LED3Phase: FakeTimingWindow.LEDPhase(
                ledStart: Float32(microseconds: 3100),
                ledEnd: Float32(microseconds: 3400),
                sampleStart: Float32(microseconds: 3225),
                sampleEnd: Float32(microseconds: 3299.75),
                resetStart: Float32(microseconds: 3600),
                resetEnd: Float32(microseconds: 3630),
                convStart: Float32(microseconds: 3300),
                convEnd: Float32(microseconds: 3500)
            ),
            totalWindowLength: Float32(microseconds: 10000),
            dynamicPowerDown: FakeTimingWindow.DynamicPowerDownPhaseType(
                start: Float32(microseconds: 5000),
                end: Float32(microseconds: 10000)
            )
        )
    }
}
