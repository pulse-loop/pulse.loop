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
    
        Form {
            Section("Transimpedance amplifier") {
                HStack {
                    Picker(selection: $opticalConfiguration.tiaResistor1, label: Text("Resistor #1")) {
                        ForEach(TIAResistor.allCases, id: \.rawValue) { r in
                            Text(r.description).tag(r)
                        }
                    }
                    .padding(.trailing, 12)
                    
                    Divider()
                    
                    Picker(selection: $opticalConfiguration.tiaResistor1, label: Text("Resistor #2")) {
                        ForEach(TIAResistor.allCases, id: \.rawValue) { r in
                            Text(r.description).tag(r)
                        }
                    }
                    .padding(.leading, 8)
                }
                
                HStack {
                    Picker(selection: $opticalConfiguration.tiaCapacitor1, label: Text("Capacitor #1")) {
                        ForEach(TIACapacitor.allCases, id: \.rawValue) { r in
                            Text(r.description).tag(r)
                        }
                    }
                    .padding(.trailing, 12)
                    
                    Divider()
                    
                    Picker(selection: $opticalConfiguration.tiaCapacitor2, label: Text("Capacitor #2")) {
                        ForEach(TIACapacitor.allCases, id: \.rawValue) { r in
                            Text(r.description).tag(r)
                        }
                    }
                    .padding(.leading, 8)
                }
            }
            
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
        .formStyle(.grouped)
    }
}


struct OpticalConfigurationForm_Previews: PreviewProvider {
    static var previews: some View {
        OpticalConfigurationForm(opticalConfiguration: .constant(FakeDevice().opticalFrontendConfiguration))
            .previewLayout(.fixed(width: 600, height: 1300))
    }
}
