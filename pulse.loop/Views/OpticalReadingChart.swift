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
    var data: LineDataSet
    private var chartData: LineChartData {
        
        var data = self.data
        
        data.style = LineStyle(lineColour: ColourStyle(colour: color), lineType: .line, strokeStyle: Stroke(lineWidth: 2))

        return LineChartData(
            dataSets: data,
            metadata: ChartMetadata(
                title: title,
                titleFont: .largeTitle
            ),
            chartStyle: LineChartStyle(
                xAxisGridStyle: GridStyle(numberOfLines: 5),
                yAxisLabelColour: .gray,
                globalAnimation: .default
            )
        )
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
        let dataSet = LineDataSet(dataPoints: [
            .init(value: 100),
            .init(value: 40),
            .init(value: 160)
        ])
        
        return OpticalReadingChart(title: "Title", color: .green, data: dataSet)
            .previewLayout(.sizeThatFits)
    }
}
