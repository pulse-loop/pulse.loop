//
//  ChartStackView.swift
//  pulse.loop
//
//  Created by Riccardo Persello on 29/12/22.
//

import SwiftUI

struct ChartStackView<Data: RawSensorDataProtocol>: View {
    @ObservedObject var rawSensorData: Data
    
    var body: some View {
        HStack {
            ChartView(value: rawSensorData.ambient, title: "Ambient", lineColor: .blue, smooth: false)
                .frame(width: 300, height: 320)
            
            ChartView(value: rawSensorData.led1MinusAmbient, title: "LED1 - Ambient", lineColor: .yellow, smooth: false)
                .frame(width: 300, height: 320)
            
            ChartView(value: rawSensorData.led1, title: "LED1", lineColor: .green, smooth: false)
                .frame(width: 300, height: 320)
            
            ChartView(value: rawSensorData.led2, title: "LED2", lineColor: .red, smooth: false)
                .frame(width: 300, height: 320)
            
            ChartView(value: rawSensorData.led3, title: "LED3", lineColor: .gray, smooth: false)
                .frame(width: 300, height: 320)
        }
    }
}

struct ChartStackView_Previews: PreviewProvider {
    static var previews: some View {
        ChartStackView(rawSensorData: FakeDevice().rawSensorData)
    }
}
