//
//  OpticalReadingChart.swift
//  pulse.loop
//
//  Created by Riccardo Persello on 24/10/22.
//

import SwiftUI
import Charts

struct OpticalReadingChart: View {
    var title: String
    var color: Color = .blue
    var timeInterval: TimeInterval = 10
    @Binding var data: [OpticalSensorReading]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.largeTitle)
            Chart(data.filter({ item in
                (Date.now.advanced(by: -timeInterval)...Date.now).contains(item.date)
            })) {
                LineMark(
                    x: .value("Time", $0.date),
                    y: .value("Value", $0.value)
                )
            }
            .foregroundColor(color.opacity(0.7))
        }
        .padding()
        .frame(minWidth: 300)
    }
}

struct OpticalReadingChart_Previews: PreviewProvider {
    static var previews: some View {
        OpticalReadingChart(title: "Title", color: .green, data: .constant([.init(0), .init(1), .init(2)]))
    }
}
