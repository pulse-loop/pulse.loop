//
//  OpticalReadingChart.swift
//  pulse.loop
//
//  Created by Riccardo Persello on 24/10/22.
//

import SwiftUI
import SwiftUICharts

struct OpticalReadingChart: View {
    var title: String
    var color: Color = .blue
    @Binding var data: [OpticalSensorReading]
    var chartData: LineChartData {
        let dataSet = LineDataSet(
            dataPoints: data.map({
                LineChartDataPoint(
                    value: Double($0.value),
                    date: $0.date
                )
            }),
            style: LineStyle(lineColour: ColourStyle(colour: color))
        )
        
        
        let data = LineChartData(
            dataSets: dataSet,
            metadata: ChartMetadata(
                title: title,
                titleFont: .largeTitle
            ),
            chartStyle: LineChartStyle(
                xAxisGridStyle: GridStyle(numberOfLines: 5),
                yAxisLabelColour: .gray
            )
        )
        
        return data
    }
    
    var body: some View {
        LineChart(chartData: chartData)
            .xAxisGrid(chartData: chartData)
            .yAxisGrid(chartData: chartData)
            .yAxisLabels(chartData: chartData)
            .headerBox(chartData: chartData)
            .padding()
            .frame(minWidth: 300)
    }
}

struct OpticalReadingChart_Previews: PreviewProvider {
    static var previews: some View {
        OpticalReadingChart(title: "Title", color: .green, data: .constant([.init(300), .init(150), .init(200)]))
            .previewLayout(.sizeThatFits)
    }
}
