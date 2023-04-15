//
//  ResultsView.swift
//  pulse.loop
//
//  Created by Riccardo Persello on 11/04/23.
//

import SwiftUI

struct ResultsView<SensorData: SensorDataProtocol,
                   ResultsData: ResultsDataProtocol>: View {
    
    @ObservedObject var sensorData: SensorData
    @ObservedObject var resultsData: ResultsData
    
    var body: some View {
        ScrollView(.vertical) {
            Form {
                Section("Filtered data") {
                    ScrollView(.horizontal) {
                        HStack {
                            VStack {
                                ChartView(
                                    characteristic: sensorData.filteredOpticalData,
                                    channelFilter: ["Green DC"],
                                    title: "Green DC"
                                )
                                .frame(width: 300, height: 320)
                                
                                ChartView(
                                    characteristic: sensorData.filteredOpticalData,
                                    channelFilter: ["Green AC"],
                                    title: "Green AC"
                                )
                                .frame(width: 300, height: 320)
                            }
                            
                            VStack {
                                ChartView(
                                    characteristic: sensorData.filteredOpticalData,
                                    channelFilter: ["Red DC"],
                                    title: "Red DC"
                                )
                                .frame(width: 300, height: 320)
                                
                                ChartView(
                                    characteristic: sensorData.filteredOpticalData,
                                    channelFilter: ["Red AC"],
                                    title: "Red AC"
                                )
                                .frame(width: 300, height: 320)
                            }
                            
                            VStack {
                                ChartView(
                                    characteristic: sensorData.filteredOpticalData,
                                    channelFilter: ["Infrared DC"],
                                    title: "Infrared DC"
                                )
                                .frame(width: 300, height: 320)
                                
                                ChartView(
                                    characteristic: sensorData.filteredOpticalData,
                                    channelFilter: ["Infrared AC"],
                                    title: "Infrared AC"
                                )
                                .frame(width: 300, height: 320)
                            }
                        }
                    }
                }
                
                Section("Results") {
                    ScrollView(.horizontal) {
                        HStack {
                            ChartView(
                                characteristic: resultsData.bloodOxygen,
                                title: "Blood Oxygen"
                            )
                            .frame(width: 300, height: 320)
                            ChartView(
                                characteristic: resultsData.heartRate,
                                title: "Heart Rate"
                            )
                            .frame(width: 300, height: 320)
                            ChartView(
                                characteristic: resultsData.led1PerfusionIndex,
                                title: "Green PI"
                            )
                            .frame(width: 300, height: 320)
                            ChartView(
                                characteristic: resultsData.led2PerfusionIndex,
                                title: "Red PI"
                            )
                            .frame(width: 300, height: 320)
                            ChartView(
                                characteristic: resultsData.led3PerfusionIndex,
                                title: "Infrared PI"
                            )
                            .frame(width: 300, height: 320)
                        }
                    }
                    
                    Text("SpO2: \(resultsData.bloodOxygen.value, specifier: "%.1f")%")
                    Text("\(resultsData.heartRate.value, specifier: "%.1f") BPM")
                    Text("Wrist \(resultsData.wristPresence.value ? "" : "not ")detected")
                }
            }
        }
        .padding()
    }
}

struct ResultsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            EmptyView()
            ResultsView(sensorData: FakeSensorData(), resultsData: FakeResultsData())
        }
    }
}
