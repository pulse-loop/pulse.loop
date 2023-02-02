//
//  ChartStackView.swift
//  pulse.loop
//
//  Created by Riccardo Persello on 29/12/22.
//

import SwiftUI

struct ChartStackView<SensorData: RawSensorDataProtocol>: View {
    @ObservedObject var rawSensorData: SensorData
    var device = FakeDevice()
    
    init(rawSensorData: SensorData, device: FakeDevice = FakeDevice()) {
        self.rawSensorData = rawSensorData
        self.device = device
        
        device.connect()
    }
    
    var body: some View {
        HStack {
            OldChartView(value: device.rawSensorData.aggregatedData)
//            OldChartView(value: rawSensorData.aggregatedData, title: "Ambient", lineColor: .blue, smooth: false)
                .frame(width: 300, height: 320)
//
//            OldChartView(value: rawSensorData.led1MinusAmbient, title: "LED1 - Ambient", lineColor: .yellow, smooth: false)
//                .frame(width: 300, height: 320)
//
//            OldChartView(value: rawSensorData.led1, title: "LED1", lineColor: .green, smooth: false)
//                .frame(width: 300, height: 320)
//
//            OldChartView(value: rawSensorData.led2, title: "LED2", lineColor: .red, smooth: false)
//                .frame(width: 300, height: 320)
//
//            OldChartView(value: rawSensorData.led3, title: "LED3", lineColor: .gray, smooth: false)
//                .frame(width: 300, height: 320)
        }
    }
}

struct ChartStackView_Previews: PreviewProvider {
    static var previews: some View {
        ChartStackView(rawSensorData: FakeDevice().rawSensorData)
    }
}
