//
//  OpticalReadingChart.swift
//  pulse.loop
//
//  Created by Riccardo Persello on 24/10/22.
//

import SwiftUI
import SwiftUICharts

struct OpticalReadingChart: View {
    var title: LocalizedStringKey
    var color: Color = .blue
    var data: [OpticalFrontendReading]
    private var chartData: [DataPoint] {
        let legend = Legend(color: color, label: title)
        return data.map({
            DataPoint(value: $0.value, label: "", legend: legend)
        })
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.title)
                .padding()
            LineChartView(dataPoints: self.chartData)
                .chartStyle(LineChartStyle(showLegends: false))
                .padding()
            .frame(width: 400)
        }
    }
}

struct OpticalReadingChart_Previews: PreviewProvider {
    static var previews: some View {
        let dataSet: [OpticalFrontendReading] = [
            .init(value: 100),
            .init(value: 50),
            .init(value: 350)
        ]
        
        return OpticalReadingChart(title: "Title", color: .green, data: dataSet)
            .previewLayout(.sizeThatFits)
    }
}
