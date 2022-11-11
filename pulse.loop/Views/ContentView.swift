//
//  ContentView.swift
//  pulse.loop
//
//  Created by Riccardo Persello on 19/08/22.
//

import SwiftUI

struct ContentView: View {
    @State private var columnVisibility = NavigationSplitViewVisibility.all
    @State private var devicePopoverPresented: Bool = false
    
    @Binding var device: any DeviceProtocol
    @EnvironmentObject var deviceManager: DeviceManager
    
    var body: some View {
        NavigationSplitView(
            columnVisibility: $columnVisibility,
            sidebar: {
                List {
                    NavigationLink(destination: {
                        if let device = device as? FakeDevice {
                            OpticalConfigurationView(device: device)
                        } else if let device = device as? BLEDevice {
                            OpticalConfigurationView(device: device)
                        }
                    }, label: {
                        Label("Optical configuration", systemImage: "lightbulb")
                    })
                    
                    NavigationLink(destination: {
                        EmptyView()
                    }, label: {
                        Label("Processing configuration", systemImage: "dial.min")
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
                            DeviceSelectionView(manager: deviceManager, selectedDevice: $device)
                                .frame(minWidth: 400, minHeight: 480)
                        }
                    }
                }
            },
            detail: {
                Text("No section selected")
                    .font(.title)
            }
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(device: .constant(FakeDevice()))
    }
}
