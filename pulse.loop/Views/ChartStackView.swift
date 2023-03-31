//
//  ChartStackView.swift
//  pulse.loop
//
//  Created by Riccardo Persello on 29/12/22.
//

import SwiftUI

struct ChartStackView<SensorData: SensorDataProtocol>: View {
    @ObservedObject var sensorData: SensorData

    init(sensorData: SensorData, device: any DeviceProtocol = FakeDevice()) {
        self.sensorData = sensorData
    }

    var body: some View {
        HStack {
//            ChartView(
//                value: sensorData.aggregatedData,
//                dataSets: [.ambient],
//                title: "Ambient"
//            )
//            .frame(width: 300, height: 320)
//
//            ChartView(
//                value: sensorData.aggregatedData,
//                dataSets: [.led1],
//                title: "LED 1"
//            )
//            .frame(width: 300, height: 320)
//
//            ChartView(
//                value: sensorData.aggregatedData,
//                dataSets: [.led2],
//                title: "LED 2"
//            )
//            .frame(width: 300, height: 320)
//
//            ChartView(
//                value: sensorData.aggregatedData,
//                dataSets: [.led3],
//                title: "LED 3"
//            )
//            .frame(width: 300, height: 320)
        }
    }
}

struct ChartStackViewpreviews: PreviewProvider {
    static var previews: some View {
        let device = FakeDevice()
        device.connect()

        return ChartStackView(sensorData: device.sensorData)
    }
}
