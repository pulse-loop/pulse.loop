//
//  ChartStackView.swift
//  pulse.loop
//
//  Created by Riccardo Persello on 29/12/22.
//

import SwiftUI

struct ChartStackView<SensorData: RawSensorDataProtocol>: View {
    @ObservedObject var rawSensorData: SensorData
    
    init(rawSensorData: SensorData, device: any DeviceProtocol = FakeDevice()) {
        self.rawSensorData = rawSensorData
    }
    
    var body: some View {
        HStack {
            ChartView(
                value: rawSensorData.aggregatedData,
                dataSets: [.ambient],
                title: "Ambient"
            )
            .frame(width: 300, height: 320)
            
            ChartView(
                value: rawSensorData.aggregatedData,
                dataSets: [.led1],
                title: "LED 1"
            )
            .frame(width: 300, height: 320)
            
            ChartView(
                value: rawSensorData.aggregatedData,
                dataSets: [.led2],
                title: "LED 2"
            )
            .frame(width: 300, height: 320)
            
            ChartView(
                value: rawSensorData.aggregatedData,
                dataSets: [.led3],
                title: "LED 3"
            )
            .frame(width: 300, height: 320)
        }
    }
}

struct ChartStackView_Previews: PreviewProvider {
    static var previews: some View {
        let device = FakeDevice()
        device.connect()
        
        return ChartStackView(rawSensorData: device.rawSensorData)
    }
}
