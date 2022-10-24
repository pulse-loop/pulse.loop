//
//  pulse_loopApp.swift
//  pulse.loop
//
//  Created by Riccardo Persello on 19/08/22.
//

import SwiftUI

@main
struct pulse_loopApp: App {
    @StateObject var manager: DeviceManager = DeviceManager()
    
    var body: some Scene {
        WindowGroup {
            #if os(macOS)
            ContentView()
            #elseif os(iOS)
            Text("No iOS app yet.")
            #endif
        }
    }
}
