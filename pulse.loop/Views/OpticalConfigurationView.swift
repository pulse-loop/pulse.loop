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
                    ChartView(value: device.rawOpticalAmbient, title: "Ambient", lineColor: .blue, smooth: true)
                        .frame(width: 300, height: 320)
                    
                    ChartView(value: device.rawOpticalLED1MinusAmbient, title: "LED1 - Ambient", lineColor: .yellow, smooth: true)
                        .frame(width: 300, height: 320)

                    ChartView(value: device.rawOpticalLED1, title: "LED1", lineColor: .red, smooth: true)
                        .frame(width: 300, height: 320)

                    ChartView(value: device.rawOpticalLED2, title: "LED2", lineColor: .green, smooth: true)
                        .frame(width: 300, height: 320)

                    ChartView(value: device.rawOpticalLED3, title: "LED3", lineColor: .gray, smooth: true)
                        .frame(width: 300, height: 320)
                }
                .padding()
            }
            
            ScrollView(.vertical) {
                LazyVStack {
                    OpticalConfigurationForm(opticalConfiguration: opticalConfiguration)
                        .navigationTitle("Optical configuration")
                }
                .padding()
            }
        }
    }
}

struct OpticalConfigurationView_Previews: PreviewProvider {
    static var previews: some View {
        let device = FakeDevice()
        device.connect()
        
        return OpticalConfigurationView(device: device)
            .previewLayout(.fixed(width: 600, height: 1000))
    }
}
