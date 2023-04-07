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
            ChartView(
                characteristic: sensorData.rawOpticalData,
                channelFilter: ["Ambient"],
                title: "Ambient"
            )
            .frame(width: 300, height: 320)
            
            ChartView(
                characteristic: sensorData.rawOpticalData,
                channelFilter: ["Green"],
                title: "Green"
            )
            .frame(width: 300, height: 320)
            
            ChartView(
                characteristic: sensorData.rawOpticalData,
                channelFilter: ["Red"],
                title: "Red"
            )
            .frame(width: 300, height: 320)
            
            ChartView(
                characteristic: sensorData.rawOpticalData,
                channelFilter: ["Infrared"],
                title: "Infrared"
            )
            .frame(width: 300, height: 320)
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
