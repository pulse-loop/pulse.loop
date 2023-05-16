//
//  TimingWindowConfigurationView.swift
//  pulse.loop
//
//  Created by Riccardo Persello on 24/10/22.
//

import SwiftUI
import Charts

struct TimingWindowConfigurationView<Device>: View where Device: DeviceProtocol {
    @ObservedObject var device: Device

    var body: some View {
        #if os(iOS)
        Form {
            ScrollView(.horizontal) {
                ChartStackView(sensorData: device.sensorData)
                    .padding()
            }

            TimingWindowConfigurationForm(windowConfiguration: $device.timingWindow)
        }
        #elseif os(macOS)
        ScrollView(.vertical) {
            ScrollView(.horizontal) {
                ChartStackView(sensorData: device.sensorData)
                    .padding()
            }

            Form {
                TimingWindowConfigurationForm(windowConfiguration: $device.timingWindow)
            }
            .formStyle(.grouped)
        }
        #endif
    }
}

struct TimingWindowConfigurationView_Previews: PreviewProvider {
    static var previews: some View {
        let device = FakeDevice()
        device.connect()

        return TimingWindowConfigurationView(device: device)
            .previewLayout(.fixed(width: 600, height: 1000))
    }
}
