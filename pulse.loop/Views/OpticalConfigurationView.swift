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
                    OpticalReadingChart(title: "Ambient", color: .secondary, data: $device.rawOpticalAmbient)
                    OpticalReadingChart(title: "LED1 - Ambient", color: .blue, data: $device.rawOpticalLED1MinusAmbient)
                    OpticalReadingChart(title: "LED1", color: .green, data: $device.rawOpticalLED1)
                    OpticalReadingChart(title: "LED2", color: .red, data: $device.rawOpticalLED2)
                    OpticalReadingChart(title: "LED3", color: .yellow, data: $device.rawOpticalLED3)
                }
                .frame(height: 300)
            }
            
            
            Form {
                HStack {
                    Picker(selection: .constant(1), label: Text("Resistor #1")) {
                        ForEach(OpticalFrontendConfiguration.TIAResistor.allCases, id: \.rawValue) { r in
                            Text(r.description).tag(r.rawValue)
                        }
                    }
                    
                    Picker(selection: .constant(1), label: Text("Resistor #2")) {
                        ForEach(OpticalFrontendConfiguration.TIAResistor.allCases, id: \.rawValue) { r in
                            Text(r.description).tag(r.rawValue)
                        }
                    }
                }
                
                HStack {
                    Picker(selection: .constant(1), label: Text("Capacitor #1")) {
                        ForEach(OpticalFrontendConfiguration.TIACapacitor.allCases, id: \.rawValue) { r in
                            Text(r.description).tag(r.rawValue)
                        }
                    }
                    
                    Picker(selection: .constant(1), label: Text("Capacitor #2")) {
                        ForEach(OpticalFrontendConfiguration.TIACapacitor.allCases, id: \.rawValue) { r in
                            Text(r.description).tag(r.rawValue)
                        }
                    }
                }
            }
            .formStyle(.grouped)
        }
    }
}

struct OpticalConfigurationView_Previews: PreviewProvider {
    static var previews: some View {
        OpticalConfigurationView(device: FakeDevice())
    }
}
