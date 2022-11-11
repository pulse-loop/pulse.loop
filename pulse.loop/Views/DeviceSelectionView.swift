//
//  DeviceSelectionView.swift
//  pulse.loop
//
//  Created by Riccardo Persello on 05/11/22.
//

import SwiftUI

struct DeviceSelectionView: View {
    @ObservedObject var manager: DeviceManager
    @Binding var selectedDevice: any DeviceProtocol
    
    var body: some View {
        List {
            ForEach(manager.discoveredDevices.sorted(by: {$0.value.device.name > $1.value.device.name}), id: \.key) { peripheral in
                DeviceListItem(device: peripheral.value.device, selectedDevice: $selectedDevice)
            }
            
            DeviceListItem(device: FakeDevice(), selectedDevice: $selectedDevice)
        }
        .listStyle(.inset(alternatesRowBackgrounds: true))
        .onAppear {
            manager.scan()
        }
    }
}

struct DeviceSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        DeviceSelectionView(manager: DeviceManager.shared, selectedDevice: .constant(FakeDevice()))
    }
}
