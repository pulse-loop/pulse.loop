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
        List {
            HStack {
                ChartView(
                    characteristic: sensorData.filteredOpticalData,
                    channelFilter: ["Green DC"],
                    title: "Green DC"
                )
                .frame(height: 320)
                
                ChartView(
                    characteristic: sensorData.filteredOpticalData,
                    channelFilter: ["Green AC"],
                    title: "Green AC"
                )
                .frame(height: 320)
            }
            
            HStack {
                ChartView(
                    characteristic: sensorData.filteredOpticalData,
                    channelFilter: ["Red DC"],
                    title: "Red DC"
                )
                .frame(height: 320)
                
                ChartView(
                    characteristic: sensorData.filteredOpticalData,
                    channelFilter: ["Red AC"],
                    title: "Red AC"
                )
                .frame(height: 320)
            }
            
            HStack {
                ChartView(
                    characteristic: sensorData.filteredOpticalData,
                    channelFilter: ["Infrared DC"],
                    title: "Infrared DC"
                )
                .frame(height: 320)
                
                ChartView(
                    characteristic: sensorData.filteredOpticalData,
                    channelFilter: ["Infrared AC"],
                    title: "Infrared AC"
                )
                .frame(height: 320)
            }
        }
    }
}

struct ResultsView_Previews: PreviewProvider {
    static var previews: some View {
        ResultsView(sensorData: FakeSensorData())
    }
}
