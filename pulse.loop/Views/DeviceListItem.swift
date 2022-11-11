//
//  DeviceListItem.swift
//  pulse.loop
//
//  Created by Riccardo Persello on 11/11/22.
//

import SwiftUI

struct DeviceListItem<Device: DeviceProtocol>: View {
    @ObservedObject var device: Device
    @Binding var selectedDevice: any DeviceProtocol
    
    private var realDevice: Bool {
        device is BLEDevice
    }
    
    private var selected: Bool {
        if let selectedDevice = selectedDevice as? Device {
            return selectedDevice == device
        } else {
            return false
        }
    }
    
    var body: some View {
        HStack {
            Image(systemName: realDevice ? "bolt.heart" : "circle.hexagonpath")
                .font(.system(size: 50, weight: .light))
                .foregroundColor(.accentColor)
            
            VStack(alignment: .leading) {
                Text(device.name)
                    .font(.title)
                Text(realDevice ? "Bluetooth device" : "Simulator")
                    .foregroundColor(.gray)
            }
            Spacer()
            if selected {
                HStack(spacing: 8) {
                    if device.status != .connected {
                        ProgressView()
                            .controlSize(.small)
                    }
                    Text(device.status.description.capitalized)
                        .font(.system(.body).bold())
                }
            } else {
                Button("Select") {
                    selectedDevice.disconnect()
                    selectedDevice = device
                    selectedDevice.connect()
                }
                #if os(iOS)
                .buttonStyle(.borderedProminent)
                #endif
            }
        }
        .padding()
    }
}

struct DeviceListItem_Previews: PreviewProvider {
    static var previews: some View {
        DeviceListItem(device: FakeDevice(), selectedDevice: .constant(FakeDevice()))
            .previewLayout(.sizeThatFits)
    }
}
