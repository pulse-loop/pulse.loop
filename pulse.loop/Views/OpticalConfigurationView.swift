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
                HStack {
                    OpticalReadingChart(title: "Red", color: .red, data: $device.redSensorData)
                    OpticalReadingChart(title: "Green", color: .green, data: $device.greenSensorData)
                    OpticalReadingChart(title: "Infrared", color: .black, data: $device.infraredSensorData)
                    OpticalReadingChart(title: "Ambient", color: .cyan, data: $device.ambientSensorData)
                }
            }
            
            List {
                Text("Parameters")
                Text("Parameters")
                Text("Parameters")
                Text("Parameters")
                Text("Parameters")
            }
            .listStyle(.inset(alternatesRowBackgrounds: true))
        }
    }
}

struct OpticalConfigurationView_Previews: PreviewProvider {
    static var previews: some View {
        OpticalConfigurationView(device: FakeDevice())
    }
}
