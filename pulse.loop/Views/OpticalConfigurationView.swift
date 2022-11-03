//
//  OpticalConfigurationView.swift
//  pulse.loop
//
//  Created by Riccardo Persello on 24/10/22.
//

import SwiftUI
import Charts

struct OpticalConfigurationView<Device>: View where Device: DeviceProtocol {
    @ObservedObject var device: Device
    
    var body: some View {
        VStack {
            ScrollView(.horizontal) {
                HStack {
                    OpticalReadingChart(title: "Ambient", color: .blue, data: $device.rawOpticalAmbient)
                    OpticalReadingChart(title: "LED1 - Ambient", color: .secondary, data: $device.rawOpticalLED1MinusAmbient)
                    OpticalReadingChart(title: "LED1", color: .red, data: $device.rawOpticalLED1)
                    OpticalReadingChart(title: "LED2", color: .green, data: $device.rawOpticalLED2)
                    OpticalReadingChart(title: "LED3", color: .yellow, data: $device.rawOpticalLED3)
                }
                .frame(height: 300)
            }
            
            
            Form {
                HStack {
                    Picker(selection: .constant(1), label: Text("Resistor #1")) {
                        ForEach(OpticalFrontendConfiguration.TIAResistor.allCases, id: \.rawValue) { r in
                            Text(r.description).tag(r.rawValue)
                        }
                    }
                    
                    Picker(selection: .constant(1), label: Text("Resistor #2")) {
                        ForEach(OpticalFrontendConfiguration.TIAResistor.allCases, id: \.rawValue) { r in
                            Text(r.description).tag(r.rawValue)
                        }
                    }
                }
                
                HStack {
                    Picker(selection: .constant(1), label: Text("Capacitor #1")) {
                        ForEach(OpticalFrontendConfiguration.TIACapacitor.allCases, id: \.rawValue) { r in
                            Text(r.description).tag(r.rawValue)
                        }
                    }
                    
                    Picker(selection: .constant(1), label: Text("Capacitor #2")) {
                        ForEach(OpticalFrontendConfiguration.TIACapacitor.allCases, id: \.rawValue) { r in
                            Text(r.description).tag(r.rawValue)
                        }
                    }
                }
                
                let conf = OpticalFrontendConfiguration(
                    ambientPhase: OpticalFrontendConfiguration.AmbientPhase(
                        sample_st: TimeInterval(microseconds: 2225),
                        sample_end: TimeInterval(microseconds: 2299.75),
                        reset_st: TimeInterval(microseconds: 2600),
                        reset_end: TimeInterval(microseconds: 2610),
                        conv_st: TimeInterval(microseconds: 2300),
                        conv_end: TimeInterval(microseconds: 2500)
                    ),
                    LED1Phase: OpticalFrontendConfiguration.LEDPhase(
                        led_st: TimeInterval(microseconds: 1100),
                        led_end: TimeInterval(microseconds: 1400),
                        sample_st: TimeInterval(microseconds: 1225),
                        sample_end: TimeInterval(microseconds: 1299.75),
                        reset_st: TimeInterval(microseconds: 1600),
                        reset_end: TimeInterval(microseconds: 1605),
                        conv_st: TimeInterval(microseconds: 1300),
                        conv_end: TimeInterval(microseconds: 1500)
                    ),
                    LED2Phase: OpticalFrontendConfiguration.LEDPhase(
                        led_st: TimeInterval(microseconds: 100),
                        led_end: TimeInterval(microseconds: 400),
                        sample_st: TimeInterval(microseconds: 225),
                        sample_end: TimeInterval(microseconds: 299.75),
                        reset_st: TimeInterval(microseconds: 600),
                        reset_end: TimeInterval(microseconds: 601),
                        conv_st: TimeInterval(microseconds: 300),
                        conv_end: TimeInterval(microseconds: 500)
                    ),
                    LED3Phase: OpticalFrontendConfiguration.LEDPhase(
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
                    dynamicPowerDown: OpticalFrontendConfiguration.DynamicPowerDownPhase(
                        start: TimeInterval(microseconds: 5000),
                        end: TimeInterval(microseconds: 10000)
                    )
                )
                
                OpticalTimingView(opticalConfiguration: conf)
                    .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
            }
            .formStyle(.grouped)
        }
    }
}

struct OpticalConfigurationView_Previews: PreviewProvider {
    static var previews: some View {
        OpticalConfigurationView(device: FakeDevice())
    }
}
