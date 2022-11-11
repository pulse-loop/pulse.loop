//
//  pulse_loopApp.swift
//  pulse.loop
//
//  Created by Riccardo Persello on 19/08/22.
//

import SwiftUI

@main
struct pulse_loopApp: App {
    @StateObject var manager: DeviceManager = DeviceManager.shared
    @State var device: any DeviceProtocol = FakeDevice()
    
    var body: some Scene {
        WindowGroup {
            ContentView(device: $device)
                .environmentObject(manager)
        }
    }
}
