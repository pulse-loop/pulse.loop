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
            
            Section("LED currents") {
                LabeledSliderView(value: $device.electricConfiguration.led1Current.value, in: 0...100) {
                    Text("LED 1\t") +
                    Text("\(device.electricConfiguration.led1Current.value, specifier: "%.2f") mA")
                        .foregroundColor(.secondary)
                }
                
                LabeledSliderView(value: $device.electricConfiguration.led2Current.value, in: 0...100) {
                    Text("LED 1\t") +
                    Text("\(device.electricConfiguration.led2Current.value, specifier: "%.2f") mA")
                        .foregroundColor(.secondary)
                }
                
                LabeledSliderView(value: $device.electricConfiguration.led3Current.value, in: 0...100) {
                    Text("LED 1\t") +
                    Text("\(device.electricConfiguration.led3Current.value, specifier: "%.2f") mA")
                        .foregroundColor(.secondary)
                }
            }
            
            Section("Offset currents") {
                LabeledSliderView(value: $device.electricConfiguration.ambientOffsetCurrent.value, in: -7...7) {
                    Text("Ambient\t") +
                    Text("\(device.electricConfiguration.ambientOffsetCurrent.value, specifier: "%.2f") µA")
                        .foregroundColor(.secondary)
                }
                
                LabeledSliderView(value: $device.electricConfiguration.led1OffsetCurrent.value, in: -7...7) {
                    Text("LED 1\t") +
                    Text("\(device.electricConfiguration.led1OffsetCurrent.value, specifier: "%.2f") µA")
                        .foregroundColor(.secondary)
                }
                
                LabeledSliderView(value: $device.electricConfiguration.led2OffsetCurrent.value, in: -7...7) {
                    Text("LED 2\t") +
                    Text("\(device.electricConfiguration.led2OffsetCurrent.value, specifier: "%.2f") µA")
                        .foregroundColor(.secondary)
                }
                
                LabeledSliderView(value: $device.electricConfiguration.led3OffsetCurrent.value, in: -7...7) {
                    Text("LED 3\t") +
                    Text("\(device.electricConfiguration.led3OffsetCurrent.value, specifier: "%.2f") µA")
                        .foregroundColor(.secondary)
                }
            }
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
