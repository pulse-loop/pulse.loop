//
//  DeviceSelectionView.swift
//  pulse.loop
//
//  Created by Riccardo Persello on 05/11/22.
//

import SwiftUI

struct DeviceSelectionView: View {
    @Binding var selectedDevice: any DeviceProtocol
    @State var devices: [BLEDevice] = []

    var body: some View {
        List {
            ForEach(devices.sorted(by: {$0.name > $1.name}), id: \.peripheral) { peripheral in
                DeviceListItem(device: peripheral, selectedDevice: $selectedDevice)
            }

            DeviceListItem(device: FakeDevice(), selectedDevice: $selectedDevice)
        }
        #if os(macOS)
        .listStyle(.inset(alternatesRowBackgrounds: true))
        #endif
        .task {
            if let stream = BLEDevice.discover() {
                for await list in stream {
                    devices = list
                }
            }
        }
        .navigationTitle("Devices")
    }
}

struct DeviceSelectionViewpreviews: PreviewProvider {
    static var previews: some View {
        Text("AAA")
            .popover(isPresented: .constant(true)) {
                DeviceSelectionView(selectedDevice: .constant(FakeDevice()))
            }
    }
}
