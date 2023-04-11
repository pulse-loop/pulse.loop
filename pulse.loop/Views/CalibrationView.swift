//
//  CalibrationView.swift
//  pulse.loop
//
//  Created by Riccardo Persello on 07/04/23.
//

import SwiftUI

struct CalibrationView<Device: DeviceProtocol>: View {
    @ObservedObject var device: Device

    var body: some View {
        Form {
            ScrollView(.horizontal, showsIndicators: true) {
                ChartStackView(sensorData: device.sensorData)
            }
            
            Section("LED current limits") {
                HStack {
                    LabeledSliderView(value: $device.calibrationAlgorithmConfiguration.led1MinimumCurrent.value, in: 0...100E-3) {
                        Text("LED 1 min\t")
                        Text("\(device.calibrationAlgorithmConfiguration.led1MinimumCurrent.value * 1_000, specifier: "%.2f") mA")
                            .foregroundColor(.secondary)
                    }
                    
                    LabeledSliderView(value: $device.calibrationAlgorithmConfiguration.led1MaximumCurrent.value, in: 0...100E-3) {
                        Text("LED 1 max\t")
                        Text("\(device.calibrationAlgorithmConfiguration.led1MaximumCurrent.value * 1_000, specifier: "%.2f") mA")
                            .foregroundColor(.secondary)
                    }
                }
                
                HStack {
                    LabeledSliderView(value: $device.calibrationAlgorithmConfiguration.led2MinimumCurrent.value, in: 0...100E-3) {
                        Text("LED 2 min\t")
                        Text("\(device.calibrationAlgorithmConfiguration.led2MinimumCurrent.value * 1_000, specifier: "%.2f") mA")
                            .foregroundColor(.secondary)
                    }
                    
                    LabeledSliderView(value: $device.calibrationAlgorithmConfiguration.led2MaximumCurrent.value, in: 0...100E-3) {
                        Text("LED 2 max\t")
                        Text("\(device.calibrationAlgorithmConfiguration.led2MaximumCurrent.value * 1_000, specifier: "%.2f") mA")
                            .foregroundColor(.secondary)
                    }
                }
                
                HStack {
                    LabeledSliderView(value: $device.calibrationAlgorithmConfiguration.led3MinimumCurrent.value, in: 0...100E-3) {
                        Text("LED 3 min\t")
                        Text("\(device.calibrationAlgorithmConfiguration.led3MinimumCurrent.value * 1_000, specifier: "%.2f") mA")
                            .foregroundColor(.secondary)
                    }
                    
                    LabeledSliderView(value: $device.calibrationAlgorithmConfiguration.led3MaximumCurrent.value, in: 0...100E-3) {
                        Text("LED 3 max\t")
                        Text("\(device.calibrationAlgorithmConfiguration.led3MaximumCurrent.value * 1_000, specifier: "%.2f") mA")
                            .foregroundColor(.secondary)
                    }
                }
            }
            
            Section("Offset current limits") {
                HStack {
                    LabeledSliderView(value: $device.calibrationAlgorithmConfiguration.led1MinimumOffsetCurrent.value, in: -7E-6...7E-6) {
                        Text("LED 1 offset min\t")
                        Text("\(device.calibrationAlgorithmConfiguration.led1MinimumOffsetCurrent.value * 1_000_000, specifier: "%.2f") µA")
                            .foregroundColor(.secondary)
                    }
                    
                    LabeledSliderView(value: $device.calibrationAlgorithmConfiguration.led1MaximumOffsetCurrent.value, in: -7E-6...7E-6) {
                        Text("LED 1 offset max\t")
                        Text("\(device.calibrationAlgorithmConfiguration.led1MaximumOffsetCurrent.value * 1_000_000, specifier: "%.2f") µA")
                            .foregroundColor(.secondary)
                    }
                }
                
                HStack {
                    LabeledSliderView(value: $device.calibrationAlgorithmConfiguration.led2MinimumOffsetCurrent.value, in: -7E-6...7E-6) {
                        Text("LED 2 offset min\t")
                        Text("\(device.calibrationAlgorithmConfiguration.led2MinimumOffsetCurrent.value * 1_000_000, specifier: "%.2f") µA")
                            .foregroundColor(.secondary)
                    }
                    
                    LabeledSliderView(value: $device.calibrationAlgorithmConfiguration.led2MaximumOffsetCurrent.value, in: -7E-6...7E-6) {
                        Text("LED 2 offset max\t")
                        Text("\(device.calibrationAlgorithmConfiguration.led2MaximumOffsetCurrent.value * 1_000_000, specifier: "%.2f") µA")
                            .foregroundColor(.secondary)
                    }
                }
                
                HStack {
                    LabeledSliderView(value: $device.calibrationAlgorithmConfiguration.led3MinimumOffsetCurrent.value, in: -7E-6...7E-6) {
                        Text("LED 3 offset min\t")
                        Text("\(device.calibrationAlgorithmConfiguration.led3MinimumOffsetCurrent.value * 1_000_000, specifier: "%.2f") µA")
                            .foregroundColor(.secondary)
                    }
                    
                    LabeledSliderView(value: $device.calibrationAlgorithmConfiguration.led3MaximumOffsetCurrent.value, in: -7E-6...7E-6) {
                        Text("LED 3 offset max\t")
                        Text("\(device.calibrationAlgorithmConfiguration.led3MaximumOffsetCurrent.value * 1_000_000, specifier: "%.2f") µA")
                            .foregroundColor(.secondary)
                    }
                }
            }
            
            Section("ADC setpoints") {
                LabeledSliderView(value: $device.calibrationAlgorithmConfiguration.led1ADCSetpoint.value, in: 0...1.5) {
                    Text("LED 1 ADC setpoint\t")
                    Text("\(device.calibrationAlgorithmConfiguration.led1ADCSetpoint.value, specifier: "%.2f") V")
                        .foregroundColor(.secondary)
                }
                
                LabeledSliderView(value: $device.calibrationAlgorithmConfiguration.led2ADCSetpoint.value, in: 0...1.5) {
                    Text("LED 2 ADC setpoint\t")
                    Text("\(device.calibrationAlgorithmConfiguration.led2ADCSetpoint.value, specifier: "%.2f") V")
                        .foregroundColor(.secondary)
                }
                
                LabeledSliderView(value: $device.calibrationAlgorithmConfiguration.led3ADCSetpoint.value, in: 0...1.5) {
                    Text("LED 3 ADC setpoint\t")
                    Text("\(device.calibrationAlgorithmConfiguration.led3ADCSetpoint.value, specifier: "%.2f") V")
                        .foregroundColor(.secondary)
                }
            }
            
            Section("ADC working thresholds") {
                LabeledSliderView(value: $device.calibrationAlgorithmConfiguration.led1ADCWorkingThreshold.value, in: 0...1.5) {
                    Text("LED 1 ADC WT\t")
                    Text("\(device.calibrationAlgorithmConfiguration.led1ADCWorkingThreshold.value, specifier: "%.2f") V")
                        .foregroundColor(.secondary)
                }
                
                LabeledSliderView(value: $device.calibrationAlgorithmConfiguration.led2ADCWorkingThreshold.value, in: 0...1.5) {
                    Text("LED 2 ADC WT\t")
                    Text("\(device.calibrationAlgorithmConfiguration.led2ADCWorkingThreshold.value, specifier: "%.2f") V")
                        .foregroundColor(.secondary)
                }
                
                LabeledSliderView(value: $device.calibrationAlgorithmConfiguration.led3ADCWorkingThreshold.value, in: 0...1.5) {
                    Text("LED 3 ADC WT\t")
                    Text("\(device.calibrationAlgorithmConfiguration.led3ADCWorkingThreshold.value, specifier: "%.2f") V")
                        .foregroundColor(.secondary)
                }
            }
            
            Section("Offset current setpoints") {
                LabeledSliderView(value: $device.calibrationAlgorithmConfiguration.led1OffsetCurrentSetpoint.value, in: -7E-6...7E-6) {
                    Text("LED 1 OC setpoint\t")
                    Text("\(device.calibrationAlgorithmConfiguration.led1ADCWorkingThreshold.value * 1_000_000, specifier: "%.2f") µA")
                        .foregroundColor(.secondary)
                }
                
                LabeledSliderView(value: $device.calibrationAlgorithmConfiguration.led2OffsetCurrentSetpoint.value, in: -7E-6...7E-6) {
                    Text("LED 2 OC setpoint\t")
                    Text("\(device.calibrationAlgorithmConfiguration.led2ADCWorkingThreshold.value * 1_000_000, specifier: "%.2f") µA")
                        .foregroundColor(.secondary)
                }
                
                LabeledSliderView(value: $device.calibrationAlgorithmConfiguration.led3OffsetCurrentSetpoint.value, in: -7E-6...7E-6) {
                    Text("LED 3 OC setpoint\t")
                    Text("\(device.calibrationAlgorithmConfiguration.led3ADCWorkingThreshold.value * 1_000_000, specifier: "%.2f") µA")
                        .foregroundColor(.secondary)
                }
            }
        }
#if os(macOS)
        .formStyle(.grouped)
#endif
    }
}

struct CalibrationView_Previews: PreviewProvider {
    static var previews: some View {
        let device = FakeDevice()
        device.connect()
        
        return CalibrationView(device: device)
    }
}
