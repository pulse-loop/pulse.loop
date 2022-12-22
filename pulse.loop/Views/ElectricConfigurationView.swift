//
//  ElectricConfigurationView.swift
//  pulse.loop
//
//  Created by Riccardo Persello on 22/12/22.
//

import SwiftUI

struct ElectricConfigurationView<Device>: View where Device: DeviceProtocol {
    @ObservedObject var device: Device

    var body: some View {
        Form {
            Section("Transimpedance amplifier") {
                Group {
                    Picker(selection: $device.electricConfiguration.tiaResistor1.value,
                           label: Text("Resistor #1")) {
                        ForEach(TIAResistor.allCases, id: \.rawValue) { r in
                            Text(r.description).tag(r)
                        }
                    }
                    
                    
                    Picker(selection: $device.electricConfiguration.tiaResistor2.value,
                           label: Text("Resistor #2")) {
                        ForEach(TIAResistor.allCases, id: \.rawValue) { r in
                            Text(r.description).tag(r)
                        }
                    }
                    
                    
                    Picker(selection: $device.electricConfiguration.tiaCapacitor1.value,
                           label: Text("Capacitor #1")) {
                        ForEach(TIACapacitor.allCases, id: \.rawValue) { r in
                            Text(r.description).tag(r)
                        }
                    }
                    
                    
                    Picker(selection: $device.electricConfiguration.tiaCapacitor2.value,
                           label: Text("Capacitor #2")) {
                        ForEach(TIACapacitor.allCases, id: \.rawValue) { r in
                            Text(r.description).tag(r)
                        }
                    }
                }
            }
#if os(iOS)
            .pickerStyle(.segmented)
#endif

        }
        #if os(macOS)
        .formStyle(.grouped)
        #endif
    }
}

struct ElectricConfigurationView_Previews: PreviewProvider {
    static var previews: some View {
        let device = FakeDevice()
        device.connect()
        
        return ElectricConfigurationView(device: device)
    }
}
