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
                LazyHStack {
                    OpticalReadingChart(title: "Ambient", color: .blue, data: $device.rawOpticalAmbient)
                    OpticalReadingChart(title: "LED1 - Ambient", color: .secondary, data: $device.rawOpticalLED1MinusAmbient)
                    OpticalReadingChart(title: "LED1", color: .red, data: $device.rawOpticalLED1)
                    OpticalReadingChart(title: "LED2", color: .green, data: $device.rawOpticalLED2)
                    OpticalReadingChart(title: "LED3", color: .yellow, data: $device.rawOpticalLED3)
                }
                .frame(height: 300)
            }
            
            Form {
                Section("Transimpedance amplifier") {
                    HStack {
                        Picker(selection: $device.opticalFrontendConfiguration.tiaResistor1, label: Text("Resistor #1")) {
                            ForEach(OpticalFrontendConfiguration.TIAResistor.allCases, id: \.rawValue) { r in
                                Text(r.description).tag(r)
                            }
                        }
                        .padding(.trailing, 12)
                        
                        Divider()
                        
                        Picker(selection: $device.opticalFrontendConfiguration.tiaResistor1, label: Text("Resistor #2")) {
                            ForEach(OpticalFrontendConfiguration.TIAResistor.allCases, id: \.rawValue) { r in
                                Text(r.description).tag(r)
                            }
                        }
                        .padding(.leading, 8)
                    }
                    
                    HStack {
                        Picker(selection: $device.opticalFrontendConfiguration.tiaCapacitor1, label: Text("Capacitor #1")) {
                            ForEach(OpticalFrontendConfiguration.TIACapacitor.allCases, id: \.rawValue) { r in
                                Text(r.description).tag(r)
                            }
                        }
                        .padding(.trailing, 12)
                        
                        Divider()
                        
                        Picker(selection: $device.opticalFrontendConfiguration.tiaCapacitor2, label: Text("Capacitor #2")) {
                            ForEach(OpticalFrontendConfiguration.TIACapacitor.allCases, id: \.rawValue) { r in
                                Text(r.description).tag(r)
                            }
                        }
                        .padding(.leading, 8)
                    }
                }
                
                Section("Timing") {
                    OpticalTimingView(opticalConfiguration: $device.opticalFrontendConfiguration.wrappedValue)
                        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                    
                    TextField("Window length",
                              value: $device.opticalFrontendConfiguration.totalWindowLength,
                              formatter: TimeInterval.microsecondsFormatter)
                    
                    SingleTimingView(name: "Dynamic PD",
                                     start: $device.opticalFrontendConfiguration.dynamicPowerDown.start,
                                     end: $device.opticalFrontendConfiguration.dynamicPowerDown.end)
                    
                    AmbientTimingConfigurationView(title: "Ambient", phase: $device.opticalFrontendConfiguration.ambientPhase)
                    LEDTimingConfigurationView(title: "LED 1", phase: $device.opticalFrontendConfiguration.LED1Phase)
                    LEDTimingConfigurationView(title: "LED 2", phase: $device.opticalFrontendConfiguration.LED2Phase)
                    LEDTimingConfigurationView(title: "LED 3", phase: $device.opticalFrontendConfiguration.LED3Phase)
                }
            }
            .formStyle(.grouped)
        }
    }
}

struct OpticalConfigurationView_Previews: PreviewProvider {
    static var previews: some View {
        OpticalConfigurationView(device: FakeDevice())
            .previewLayout(.fixed(width: 600, height: 2200))
    }
}

struct LEDTimingConfigurationView: View {
    var title: String
    @Binding var phase: OpticalFrontendConfiguration.LEDPhase
    
    var body: some View {
        Section(header: Text(title).bold()) {
            SingleTimingView(name: "Lighting", start: $phase.led_st, end: $phase.led_end)
            SingleTimingView(name: "Sample", start: $phase.sample_st, end: $phase.sample_end)
            SingleTimingView(name: "Conversion", start: $phase.conv_st, end: $phase.conv_end)
            SingleTimingView(name: "Reset", start: $phase.reset_st, end: $phase.reset_end)
        }
    }
}

struct AmbientTimingConfigurationView: View {
    var title: String
    @Binding var phase: OpticalFrontendConfiguration.AmbientPhase
    
    var body: some View {
        Section(header: Text(title).bold()) {
            SingleTimingView(name: "Sample", start: $phase.sample_st, end: $phase.sample_end)
            SingleTimingView(name: "Conversion", start: $phase.conv_st, end: $phase.conv_end)
            SingleTimingView(name: "Reset", start: $phase.reset_st, end: $phase.reset_end)
        }
    }
}

struct SingleTimingView: View {
    var name: String
    @Binding var start: TimeInterval
    @Binding var end: TimeInterval
    
    var body: some View {
#if os(macOS)
        HStack {
            TextField("\(name) start",
                      value: $start,
                      formatter: TimeInterval.microsecondsFormatter)
            .padding(-8)
            
            Divider()
            
            TextField("\(name) end",
                      value: $end,
                      formatter: TimeInterval.microsecondsFormatter)
            .padding(-8)
        }
#elseif os(iOS)
        HStack {
            HStack {
                Text("\(name) start")
                TextField(name, value: $start, formatter: TimeInterval.microsecondsFormatter)
                    .multilineTextAlignment(.trailing)
                    .foregroundColor(.gray)
            }
            .padding(.trailing, 12)
            
            Divider()
            
            HStack {
                Text("\(name) end")
                TextField(name, value: $start, formatter: TimeInterval.microsecondsFormatter)
                    .multilineTextAlignment(.trailing)
                    .foregroundColor(.gray)
            }
            .padding(.leading, 8)
        }
#endif
    }
}
