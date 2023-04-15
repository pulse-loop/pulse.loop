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
                        Text("Green min\t")
                        Text("\(device.calibrationAlgorithmConfiguration.led1MinimumCurrent.value * 1_000, specifier: "%.2f") mA")
                            .foregroundColor(.secondary)
                    }
                    
                    LabeledSliderView(value: $device.calibrationAlgorithmConfiguration.led1MaximumCurrent.value, in: 0...100E-3) {
                        Text("Green max\t")
                        Text("\(device.calibrationAlgorithmConfiguration.led1MaximumCurrent.value * 1_000, specifier: "%.2f") mA")
                            .foregroundColor(.secondary)
                    }
                }
                
                HStack {
                    LabeledSliderView(value: $device.calibrationAlgorithmConfiguration.led2MinimumCurrent.value, in: 0...100E-3) {
                        Text("Red min\t")
                        Text("\(device.calibrationAlgorithmConfiguration.led2MinimumCurrent.value * 1_000, specifier: "%.2f") mA")
                            .foregroundColor(.secondary)
                    }
                    
                    LabeledSliderView(value: $device.calibrationAlgorithmConfiguration.led2MaximumCurrent.value, in: 0...100E-3) {
                        Text("Red max\t")
                        Text("\(device.calibrationAlgorithmConfiguration.led2MaximumCurrent.value * 1_000, specifier: "%.2f") mA")
                            .foregroundColor(.secondary)
                    }
                }
                
                HStack {
                    LabeledSliderView(value: $device.calibrationAlgorithmConfiguration.led3MinimumCurrent.value, in: 0...100E-3) {
                        Text("Infrared min\t")
                        Text("\(device.calibrationAlgorithmConfiguration.led3MinimumCurrent.value * 1_000, specifier: "%.2f") mA")
                            .foregroundColor(.secondary)
                    }
                    
                    LabeledSliderView(value: $device.calibrationAlgorithmConfiguration.led3MaximumCurrent.value, in: 0...100E-3) {
                        Text("Infrared max\t")
                        Text("\(device.calibrationAlgorithmConfiguration.led3MaximumCurrent.value * 1_000, specifier: "%.2f") mA")
                            .foregroundColor(.secondary)
                    }
                }
            }
            
            Section("Offset current limits") {
                HStack {
                    LabeledSliderView(value: $device.calibrationAlgorithmConfiguration.led1MinimumOffsetCurrent.value, in: -7E-6...7E-6) {
                        Text("Green offset min\t")
                        Text("\(device.calibrationAlgorithmConfiguration.led1MinimumOffsetCurrent.value * 1_000_000, specifier: "%.2f") µA")
                            .foregroundColor(.secondary)
                    }
                    
                    LabeledSliderView(value: $device.calibrationAlgorithmConfiguration.led1MaximumOffsetCurrent.value, in: -7E-6...7E-6) {
                        Text("Green offset max\t")
                        Text("\(device.calibrationAlgorithmConfiguration.led1MaximumOffsetCurrent.value * 1_000_000, specifier: "%.2f") µA")
                            .foregroundColor(.secondary)
                    }
                }
                
                HStack {
                    LabeledSliderView(value: $device.calibrationAlgorithmConfiguration.led2MinimumOffsetCurrent.value, in: -7E-6...7E-6) {
                        Text("Red offset min\t")
                        Text("\(device.calibrationAlgorithmConfiguration.led2MinimumOffsetCurrent.value * 1_000_000, specifier: "%.2f") µA")
                            .foregroundColor(.secondary)
                    }
                    
                    LabeledSliderView(value: $device.calibrationAlgorithmConfiguration.led2MaximumOffsetCurrent.value, in: -7E-6...7E-6) {
                        Text("Red offset max\t")
                        Text("\(device.calibrationAlgorithmConfiguration.led2MaximumOffsetCurrent.value * 1_000_000, specifier: "%.2f") µA")
                            .foregroundColor(.secondary)
                    }
                }
                
                HStack {
                    LabeledSliderView(value: $device.calibrationAlgorithmConfiguration.led3MinimumOffsetCurrent.value, in: -7E-6...7E-6) {
                        Text("Infrared offset min\t")
                        Text("\(device.calibrationAlgorithmConfiguration.led3MinimumOffsetCurrent.value * 1_000_000, specifier: "%.2f") µA")
                            .foregroundColor(.secondary)
                    }
                    
                    LabeledSliderView(value: $device.calibrationAlgorithmConfiguration.led3MaximumOffsetCurrent.value, in: -7E-6...7E-6) {
                        Text("Infrared offset max\t")
                        Text("\(device.calibrationAlgorithmConfiguration.led3MaximumOffsetCurrent.value * 1_000_000, specifier: "%.2f") µA")
                            .foregroundColor(.secondary)
                    }
                }
            }
            
            Section("ADC setpoints") {
                LabeledSliderView(value: $device.calibrationAlgorithmConfiguration.led1ADCSetpoint.value, in: 0...1.5) {
                    Text("Green ADC setpoint\t")
                    Text("\(device.calibrationAlgorithmConfiguration.led1ADCSetpoint.value, specifier: "%.2f") V")
                        .foregroundColor(.secondary)
                }
                
                LabeledSliderView(value: $device.calibrationAlgorithmConfiguration.led2ADCSetpoint.value, in: 0...1.5) {
                    Text("Red ADC setpoint\t")
                    Text("\(device.calibrationAlgorithmConfiguration.led2ADCSetpoint.value, specifier: "%.2f") V")
                        .foregroundColor(.secondary)
                }
                
                LabeledSliderView(value: $device.calibrationAlgorithmConfiguration.led3ADCSetpoint.value, in: 0...1.5) {
                    Text("Infrared ADC setpoint\t")
                    Text("\(device.calibrationAlgorithmConfiguration.led3ADCSetpoint.value, specifier: "%.2f") V")
                        .foregroundColor(.secondary)
                }
            }
            
            Section("ADC working thresholds") {
                LabeledSliderView(value: $device.calibrationAlgorithmConfiguration.led1ADCWorkingThreshold.value, in: 0...1.5) {
                    Text("Green ADC WT\t")
                    Text("\(device.calibrationAlgorithmConfiguration.led1ADCWorkingThreshold.value, specifier: "%.2f") V")
                        .foregroundColor(.secondary)
                }
                
                LabeledSliderView(value: $device.calibrationAlgorithmConfiguration.led2ADCWorkingThreshold.value, in: 0...1.5) {
                    Text("Red ADC WT\t")
                    Text("\(device.calibrationAlgorithmConfiguration.led2ADCWorkingThreshold.value, specifier: "%.2f") V")
                        .foregroundColor(.secondary)
                }
                
                LabeledSliderView(value: $device.calibrationAlgorithmConfiguration.led3ADCWorkingThreshold.value, in: 0...1.5) {
                    Text("Infrared ADC WT\t")
                    Text("\(device.calibrationAlgorithmConfiguration.led3ADCWorkingThreshold.value, specifier: "%.2f") V")
                        .foregroundColor(.secondary)
                }
            }
            
            Section("Offset current setpoints") {
                LabeledSliderView(value: $device.calibrationAlgorithmConfiguration.led1OffsetCurrentSetpoint.value, in: -7E-6...7E-6) {
                    Text("Green OC setpoint\t")
                    Text("\(device.calibrationAlgorithmConfiguration.led1OffsetCurrentSetpoint.value * 1_000_000, specifier: "%.2f") µA")
                        .foregroundColor(.secondary)
                }
                
                LabeledSliderView(value: $device.calibrationAlgorithmConfiguration.led2OffsetCurrentSetpoint.value, in: -7E-6...7E-6) {
                    Text("Red OC setpoint\t")
                    Text("\(device.calibrationAlgorithmConfiguration.led2OffsetCurrentSetpoint.value * 1_000_000, specifier: "%.2f") µA")
                        .foregroundColor(.secondary)
                }
                
                LabeledSliderView(value: $device.calibrationAlgorithmConfiguration.led3OffsetCurrentSetpoint.value, in: -7E-6...7E-6) {
                    Text("Infrared OC setpoint\t")
                    Text("\(device.calibrationAlgorithmConfiguration.led3OffsetCurrentSetpoint.value * 1_000_000, specifier: "%.2f") µA")
                        .foregroundColor(.secondary)
                }
            }
            
            Section("Alpha") {
                LabeledSliderView(value: $device.calibrationAlgorithmConfiguration.led1Alpha.value, in: 0...30E3) {
                    Text("Green α\t")
                    Text("\(device.calibrationAlgorithmConfiguration.led1Alpha.value, specifier: "%.2f")")
                        .foregroundColor(.secondary)
                }
                
                LabeledSliderView(value: $device.calibrationAlgorithmConfiguration.led2Alpha.value, in: 0...2E3) {
                    Text("Red α\t")
                    Text("\(device.calibrationAlgorithmConfiguration.led2Alpha.value, specifier: "%.2f")")
                        .foregroundColor(.secondary)
                }
                
                LabeledSliderView(value: $device.calibrationAlgorithmConfiguration.led3Alpha.value, in: 0...2E3) {
                    Text("Infrared α\t")
                    Text("\(device.calibrationAlgorithmConfiguration.led3Alpha.value, specifier: "%.2f")")
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
