//
//  ContentView.swift
//  pulse.loop
//
//  Created by Riccardo Persello on 19/08/22.
//

import SwiftUI

struct ContentView: View {
    @State private var columnVisibility = NavigationSplitViewVisibility.all
    var body: some View {
        NavigationSplitView(
            columnVisibility: $columnVisibility,
            sidebar: {
                List {
                    NavigationLink(destination: {
                        OpticalConfigurationView(device: FakeDevice())
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
            },
            detail: {
                
            }
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
