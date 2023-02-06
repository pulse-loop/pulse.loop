//
//  pulse_loopApp.swift
//  pulse.loop
//
//  Created by Riccardo Persello on 19/08/22.
//

import SwiftUI

// swiftlint:disable type_name

@main
struct pulse_loopApp: App {
    @State private var device: any DeviceProtocol = FakeDevice()

    init() {
        self.device.connect()
    }

    var body: some Scene {
        WindowGroup {
            ContentView(device: $device)
        }
    }
}
