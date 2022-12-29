//
//  TimingWindowConfigurationForm.swift
//  pulse.loop
//
//  Created by Riccardo Persello on 10/11/22.
//

import SwiftUI

struct TimingWindowConfigurationForm<OpticalWindowConfiguration: TimingWindowProtocol>: View {
    
    enum FormSection: Int, CaseIterable, Equatable, CustomStringConvertible {
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

    
    @State private var currentSection: FormSection = .ambient
    @Binding var windowConfiguration: OpticalWindowConfiguration
    
    var body: some View {
            Section("Timing") {
                Group {
                    TimingWindowGraphView(windowConfiguration: $windowConfiguration)
                        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))

                    TextField("Window length",
                              value: $windowConfiguration.totalWindowLength.value,
                              formatter: Float32.microsecondsFormatter)

                    SingleTimingView(name: "Dynamic PD",
                                     start: $windowConfiguration.dynamicPowerDown.start.value,
                                     end: $windowConfiguration.dynamicPowerDown.end.value)
                }
                
#if os(macOS)
                TabView {
                    Form {
                        AmbientTimingConfigurationView(title: "Ambient", phase: $windowConfiguration.ambientPhase)
                    }
                    .tabItem {
                        Label {
                            Text("Ambient")
                        } icon: {
                            Image(systemName: "a.circle")
                        }
                    }

                    Form {
                        LEDTimingConfigurationView(title: "LED 1", phase: $windowConfiguration.LED1Phase)
                    }
                    .tabItem {
                        Label {
                            Text("LED 1")
                        } icon: {
                            Image(systemName: "1.circle")
                        }
                    }

                    Form {
                        LEDTimingConfigurationView(title: "LED 2", phase: $windowConfiguration.LED2Phase)
                    }
                    .tabItem {
                        Label {
                            Text("LED 2")
                        } icon: {
                            Image(systemName: "2.circle")
                        }
                    }

                    Form {
                        LEDTimingConfigurationView(title: "LED 3", phase: $windowConfiguration.LED3Phase)
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
                    ForEach(FormSection.allCases, id: \.rawValue) { r in
                        Text(r.description).tag(r)
                    }
                }
                .pickerStyle(.segmented)

                switch currentSection {
                case .ambient:
                    AmbientTimingConfigurationView(title: "Ambient", phase: $windowConfiguration.ambientPhase)
                case .led1:
                    LEDTimingConfigurationView(title: "LED 1", phase: $windowConfiguration.LED1Phase)
                case .led2:
                    LEDTimingConfigurationView(title: "LED 2", phase: $windowConfiguration.LED2Phase)
                case .led3:
                    LEDTimingConfigurationView(title: "LED 3", phase: $windowConfiguration.LED3Phase)
                }
#endif
            }
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

struct TimingWindowConfigurationForm_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView(.vertical) {
            LazyVStack {
                TimingWindowConfigurationForm(windowConfiguration: .constant(FakeDevice().timingWindow))
            }
            .padding()
        }
        .previewLayout(.fixed(width: 600, height: 1000))
    }
}
