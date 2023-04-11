//
//  ResultsView.swift
//  pulse.loop
//
//  Created by Riccardo Persello on 11/04/23.
//

import SwiftUI

struct ResultsView<SensorData: SensorDataProtocol>: View {
    @ObservedObject var sensorData: SensorData

    init(sensorData: SensorData) {
        self.sensorData = sensorData
    }

    var body: some View {
        HStack {
            ChartView(
                characteristic: sensorData.filteredOpticalData,
                channelFilter: ["Green DC", "Red DC", "Infrared DC"],
                title: "DC"
            )
            .frame(width: 300, height: 320)
            
            ChartView(
                characteristic: sensorData.filteredOpticalData,
                channelFilter: ["Green AC", "Red AC", "Infrared AC"],
                title: "AC"
            )
            .frame(width: 300, height: 320)
        }
    }
}

struct ResultsView_Previews: PreviewProvider {
    static var previews: some View {
        ResultsView(sensorData: FakeSensorData())
    }
}
