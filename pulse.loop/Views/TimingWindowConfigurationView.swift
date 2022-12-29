//
//  TimingWindowConfigurationView.swift
//  pulse.loop
//
//  Created by Riccardo Persello on 24/10/22.
//

import SwiftUI
import Charts

struct ChartStackView<Data: RawSensorDataProtocol>: View {
    @ObservedObject var rawSensorData: Data
    
    var body: some View {
        HStack {
            ChartView(value: rawSensorData.ambient, title: "Ambient", lineColor: .blue, smooth: false)
                .frame(width: 300, height: 320)
            
            ChartView(value: rawSensorData.led1MinusAmbient, title: "LED1 - Ambient", lineColor: .yellow, smooth: false)
                .frame(width: 300, height: 320)
            
            ChartView(value: rawSensorData.led1, title: "LED1", lineColor: .green, smooth: false)
                .frame(width: 300, height: 320)
            
            ChartView(value: rawSensorData.led2, title: "LED2", lineColor: .red, smooth: false)
                .frame(width: 300, height: 320)
            
            ChartView(value: rawSensorData.led3, title: "LED3", lineColor: .gray, smooth: false)
                .frame(width: 300, height: 320)
        }
    }
}

struct TimingWindowConfigurationView<Device>: View where Device: DeviceProtocol {
    @ObservedObject var device: Device
    
    var body: some View {
#if os(iOS)
        Form {
            ScrollView(.horizontal) {
                ChartStackView(rawSensorData: device.rawSensorData)
                .padding()
            }
            
            TimingWindowConfigurationForm(windowConfiguration: $device.timingWindow)
        }
#elseif os(macOS)
        ScrollView(.vertical) {
            ScrollView(.horizontal) {
                ChartStackView(rawSensorData: device.rawSensorData)
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
