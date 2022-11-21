//
//  OpticalConfigurationForm.swift
//  pulse.loop
//
//  Created by Riccardo Persello on 10/11/22.
//

import SwiftUI

enum GNAH: Int, CaseIterable, Equatable, CustomStringConvertible {
    case ambient
    case led1
    case led2
    case led3
    
    var description: String {
        switch self {
        case .ambient: return "Ambient"
        case .led1: return "LED 1"
        case .led2: return "LED 2"
        case .led3: return "LED 3"
        }
    }
}

struct OpticalConfigurationForm<OpticalConfiguration: OpticalFrontendConfigurationProtocol>: View {
    
    @State var currentSection: GNAH = .ambient
    @Binding var opticalConfiguration: OpticalConfiguration
    
    var body: some View {
        Form {
            Section("Transimpedance amplifier") {
                
                Group {
                    Picker(selection: $opticalConfiguration.tiaResistor1.value, label: Text("Resistor #1")) {
                        ForEach(TIAResistor.allCases, id: \.rawValue) { r in
                            Text(r.description).tag(r)
                        }
                    }
                    
                    
                    Picker(selection: $opticalConfiguration.tiaResistor2.value, label: Text("Resistor #2")) {
                        ForEach(TIAResistor.allCases, id: \.rawValue) { r in
                            Text(r.description).tag(r)
                        }
                    }
                    
                    
                    Picker(selection: $opticalConfiguration.tiaCapacitor1.value, label: Text("Capacitor #1")) {
                        ForEach(TIACapacitor.allCases, id: \.rawValue) { r in
                            Text(r.description).tag(r)
                        }
                    }
                    
                    
                    Picker(selection: $opticalConfiguration.tiaCapacitor2.value, label: Text("Capacitor #2")) {
                        ForEach(TIACapacitor.allCases, id: \.rawValue) { r in
                            Text(r.description).tag(r)
                        }
                    }
                }
            }
#if os(iOS)
            .pickerStyle(.segmented)
#endif
            
            Section("Timing") {
                Group {
                    OpticalTimingView(opticalConfiguration: opticalConfiguration)
                        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))

                    TextField("Window length",
                              value: $opticalConfiguration.totalWindowLength.value,
                              formatter: TimeInterval.microsecondsFormatter)

                    SingleTimingView(name: "Dynamic PD",
                                     start: $opticalConfiguration.dynamicPowerDown.start.value,
                                     end: $opticalConfiguration.dynamicPowerDown.end.value)
                }
                
#if os(macOS)
                TabView {
                    Form {
                        AmbientTimingConfigurationView(title: "Ambient", phase: $opticalConfiguration.ambientPhase)
                    }
                    .tabItem {
                        Label {
                            Text("Ambient")
                        } icon: {
                            Image(systemName: "a.circle")
                        }
                    }

                    Form {
                        LEDTimingConfigurationView(title: "LED 1", phase: $opticalConfiguration.LED1Phase)
                    }
                    .tabItem {
                        Label {
                            Text("LED 1")
                        } icon: {
                            Image(systemName: "1.circle")
                        }
                    }

                    Form {
                        LEDTimingConfigurationView(title: "LED 2", phase: $opticalConfiguration.LED2Phase)
                    }
                    .tabItem {
                        Label {
                            Text("LED 2")
                        } icon: {
                            Image(systemName: "2.circle")
                        }
                    }

                    Form {
                        LEDTimingConfigurationView(title: "LED 3", phase: $opticalConfiguration.LED3Phase)
                    }
                    .tabItem {
                        Label {
                            Text("LED 3")
                        } icon: {
                            Image(systemName: "3.circle")
                        }
                    }
                }
#elseif os(iOS)
                Picker(selection: $currentSection, label: Text("Section")) {
                    ForEach(GNAH.allCases, id: \.rawValue) { r in
                        Text(r.description).tag(r)
                    }
                }
                .pickerStyle(.segmented)

                switch currentSection {
                case .ambient:
                    AmbientTimingConfigurationView(title: "Ambient", phase: $opticalConfiguration.ambientPhase)
                case .led1:
                    LEDTimingConfigurationView(title: "LED 1", phase: $opticalConfiguration.LED1Phase)
                case .led2:
                    LEDTimingConfigurationView(title: "LED 2", phase: $opticalConfiguration.LED2Phase)
                case .led3:
                    LEDTimingConfigurationView(title: "LED 3", phase: $opticalConfiguration.LED3Phase)
                }
#endif
            }
        }
#if os(macOS)
        .formStyle(.grouped)
#endif
    }
}

struct LEDTimingConfigurationView<Phase: LEDPhaseProtocol>: View {
    var title: String
    @Binding var phase: Phase
    
    var body: some View {
        Section(header: Text(title + " parameters").bold()) {
            SingleTimingView(name: "Lighting", start: $phase.led_st.value, end: $phase.led_end.value)
            SingleTimingView(name: "Sample", start: $phase.sample_st.value, end: $phase.sample_end.value)
            SingleTimingView(name: "Conversion", start: $phase.conv_st.value, end: $phase.conv_end.value)
            SingleTimingView(name: "Reset", start: $phase.reset_st.value, end: $phase.reset_end.value)
        }
    }
}

struct AmbientTimingConfigurationView<Phase: AmbientPhaseProtocol>: View {
    var title: String
    @Binding var phase: Phase
    
    var body: some View {
        Section(header: Text(title + " parameters").bold()) {
            SingleTimingView(name: "Sample", start: $phase.sample_st.value, end: $phase.sample_end.value)
            SingleTimingView(name: "Conversion", start: $phase.conv_st.value, end: $phase.conv_end.value)
            SingleTimingView(name: "Reset", start: $phase.reset_st.value, end: $phase.reset_end.value)
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
