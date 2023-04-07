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
            
            Section("Currents") {
                LabeledSliderView(value: $device.calibrationAlgorithmConfiguration.led1MinimumCurrent.value) {
                    EmptyView()
                }
                
                // TODO: All currents.
            }
            
            // TODO: Slider for everything, except for alpha.
        }
    }
}

struct CalibrationView_Previews: PreviewProvider {
    static var previews: some View {
        let device = FakeDevice()
        device.connect()
        
        return CalibrationView(device: device)
    }
}
