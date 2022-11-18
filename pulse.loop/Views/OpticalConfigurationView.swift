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
                TimelineView(.animation) { _ in
                    HStack {
                        Text("\(device.rawOpticalAmbient.value)")
                        Text("\(device.rawOpticalLED1MinusAmbient.value)")
                        Text("\(device.rawOpticalLED1.value)")
                        Text("\(device.rawOpticalLED2.value)")
                        Text("\(device.rawOpticalLED3.value)")
//                        OpticalReadingChart(title: "Ambient", color: .blue, data: device.rawOpticalAmbient)
//                        OpticalReadingChart(title: "LED1 - Ambient", color: .secondary, data: device.rawOpticalLED1MinusAmbient)
//                        OpticalReadingChart(title: "LED1", color: .red, data: device.rawOpticalLED1)
//                        OpticalReadingChart(title: "LED2", color: .green, data: device.rawOpticalLED2)
//                        OpticalReadingChart(title: "LED3", color: .yellow, data: device.rawOpticalLED3)
                    }
                    .drawingGroup()
                }
            }
            
            OpticalConfigurationForm(opticalConfiguration: opticalConfiguration)
                .navigationTitle("Optical configuration")
        }
    }
}

struct OpticalConfigurationView_Previews: PreviewProvider {
    static var previews: some View {
        let device = FakeDevice()
        device.connect()
        
        return OpticalConfigurationView(device: device)
            .previewLayout(.fixed(width: 600, height: 2200))
    }
}
