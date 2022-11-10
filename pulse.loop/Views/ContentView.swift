//
//  ContentView.swift
//  pulse.loop
//
//  Created by Riccardo Persello on 19/08/22.
//

import SwiftUI

struct ContentView: View {
    @State private var columnVisibility = NavigationSplitViewVisibility.all
    @State private var device = FakeDevice()
    var body: some View {
        NavigationSplitView(
            columnVisibility: $columnVisibility,
            sidebar: {
                List {
                    NavigationLink(destination: {
                        OpticalConfigurationView(device: device)
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
                            
                        } label: {
                            Label("Devices", systemImage: "antenna.radiowaves.left.and.right")
                        }
                        .popover(isPresented: .constant(true)) {
                            NavigationStack {
                                DeviceSelectionView()
                            }
                            .frame(width: 360, height: 480)
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
        ContentView()
    }
}
