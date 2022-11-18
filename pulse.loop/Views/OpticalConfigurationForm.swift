//
//  OpticalConfigurationForm.swift
//  pulse.loop
//
//  Created by Riccardo Persello on 10/11/22.
//

import SwiftUI

struct OpticalConfigurationForm<OpticalConfiguration: OpticalFrontendConfigurationProtocol>: View {
    @Binding var opticalConfiguration: OpticalConfiguration
    
    var body: some View {
        
        Group {
            Section("Transimpedance amplifier") {
                
                Picker(selection: $opticalConfiguration.tiaResistor1, label: Text("Resistor #1")) {
                    ForEach(TIAResistor.allCases, id: \.rawValue) { r in
                        Text(r.description).tag(r)
                    }
                }
                
                
                Picker(selection: $opticalConfiguration.tiaResistor1, label: Text("Resistor #2")) {
                    ForEach(TIAResistor.allCases, id: \.rawValue) { r in
                        Text(r.description).tag(r)
                    }
                }
                
                
                Picker(selection: $opticalConfiguration.tiaCapacitor1, label: Text("Capacitor #1")) {
                    ForEach(TIACapacitor.allCases, id: \.rawValue) { r in
                        Text(r.description).tag(r)
                    }
                }
                
                
                Picker(selection: $opticalConfiguration.tiaCapacitor2, label: Text("Capacitor #2")) {
                    ForEach(TIACapacitor.allCases, id: \.rawValue) { r in
                        Text(r.description).tag(r)
                    }
                }
            }
            #if os(iOS)
            .pickerStyle(.segmented)
            #endif
            
            Section("Timing") {
                OpticalTimingView(opticalConfiguration: $opticalConfiguration.wrappedValue)
                    .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                
                TextField("Window length",
                          value: $opticalConfiguration.totalWindowLength,
                          formatter: TimeInterval.microsecondsFormatter)
                
                SingleTimingView(name: "Dynamic PD",
                                 start: $opticalConfiguration.dynamicPowerDown.start,
                                 end: $opticalConfiguration.dynamicPowerDown.end)
                
                AmbientTimingConfigurationView(title: "Ambient", phase: $opticalConfiguration.ambientPhase)
                LEDTimingConfigurationView(title: "LED 1", phase: $opticalConfiguration.LED1Phase)
                LEDTimingConfigurationView(title: "LED 2", phase: $opticalConfiguration.LED2Phase)
                LEDTimingConfigurationView(title: "LED 3", phase: $opticalConfiguration.LED3Phase)
            }
        }
    }
}

struct LEDTimingConfigurationView<Phase: LEDPhaseProtocol>: View {
    var title: String
    @Binding var phase: Phase
    
    var body: some View {
        Section(header: Text(title).bold()) {
            SingleTimingView(name: "Lighting", start: $phase.led_st, end: $phase.led_end)
            SingleTimingView(name: "Sample", start: $phase.sample_st, end: $phase.sample_end)
            SingleTimingView(name: "Conversion", start: $phase.conv_st, end: $phase.conv_end)
            SingleTimingView(name: "Reset", start: $phase.reset_st, end: $phase.reset_end)
        }
    }
}

struct AmbientTimingConfigurationView<Phase: AmbientPhaseProtocol>: View {
    var title: String
    @Binding var phase: Phase
    
    var body: some View {
        Section(header: Text(title).bold()) {
            SingleTimingView(name: "Sample", start: $phase.sample_st, end: $phase.sample_end)
            SingleTimingView(name: "Conversion", start: $phase.conv_st, end: $phase.conv_end)
            SingleTimingView(name: "Reset", start: $phase.reset_st, end: $phase.reset_end)
        }
    }
}

struct OpticalConfigurationForm_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView(.vertical) {
            LazyVStack {
                OpticalConfigurationForm(opticalConfiguration: .constant(FakeDevice().getOpticalFrontendConfiguration()))
            }
            .padding()
        }
        .previewLayout(.fixed(width: 600, height: 1000))
    }
}
