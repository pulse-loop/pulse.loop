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
        let opticalConfiguration: Binding<Device.OpticalFrontendConfigurationType> = Binding {
            self.device.getOpticalFrontendConfiguration()
        } set: { value, transaction in
            self.device.setOpticalFrontendConfiguration(value)
        }
        
        return VStack {
            ScrollView(.horizontal) {
                HStack {
                    OpticalReadingChart(title: "Ambient", color: .blue, data: $device.rawOpticalAmbient)
                    OpticalReadingChart(title: "LED1 - Ambient", color: .secondary, data: $device.rawOpticalLED1MinusAmbient)
                    OpticalReadingChart(title: "LED1", color: .red, data: $device.rawOpticalLED1)
                    OpticalReadingChart(title: "LED2", color: .green, data: $device.rawOpticalLED2)
                    OpticalReadingChart(title: "LED3", color: .yellow, data: $device.rawOpticalLED3)
                }
                .frame(height: 300)
                .drawingGroup()
            }
            
            OpticalConfigurationForm(opticalConfiguration: opticalConfiguration)
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

struct OpticalConfigurationView_Previews: PreviewProvider {
    static var previews: some View {
        OpticalConfigurationView(device: FakeDevice())
            .previewLayout(.fixed(width: 600, height: 2200))
    }
}
