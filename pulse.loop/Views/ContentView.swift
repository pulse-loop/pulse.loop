//
//  ContentView.swift
//  pulse.loop
//
//  Created by Riccardo Persello on 19/08/22.
//

import SwiftUI

struct ContentView: View {

    @State private var devicePopoverPresented: Bool = false

    @Binding var device: any DeviceProtocol

    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: {
                    if let device = device as? FakeDevice {
                        TimingWindowConfigurationView(device: device)
                            .navigationTitle("Window configuration")
                    } else if let device = device as? BLEDevice {
                        TimingWindowConfigurationView(device: device)
                            .navigationTitle("Window configuration")
                    }
                }, label: {
                    Label("Window configuration", systemImage: "timeline.selection")
                })

                NavigationLink(destination: {
                    if let device = device as? FakeDevice {
                        ElectricConfigurationView(device: device)
                            .navigationTitle("Electric configuration")
                    } else if let device = device as? BLEDevice {
                        ElectricConfigurationView(device: device)
                            .navigationTitle("Electric configuration")
                    }
                }, label: {
                    Label("Electric configuration", systemImage: "alternatingcurrent")
                })

                NavigationLink(destination: {
                    EmptyView()
                        .navigationTitle("Algorithm configuration")
                }, label: {
                    Label("Algorithm configuration", systemImage: "function")
                })
            }
            .navigationTitle("pulse.loop")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        devicePopoverPresented.toggle()
                    } label: {
                        Label("Devices", systemImage: "antenna.radiowaves.left.and.right")
                    }
                    .popover(isPresented: $devicePopoverPresented) {
                        DeviceSelectionView(selectedDevice: $device)
                            .frame(minWidth: 400, minHeight: 480)
                    }
                }
            }
            .listStyle(.sidebar)

            Text("No section selected")
                .font(.title)
        }
    }
}

struct ContentViewpreviews: PreviewProvider {
    static var previews: some View {
        ContentView(device: .constant(FakeDevice()))
    }
}
