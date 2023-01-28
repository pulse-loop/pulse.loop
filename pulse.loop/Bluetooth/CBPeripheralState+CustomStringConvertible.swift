//
//  CBPeripheralState+CustomStringConvertible.swift
//  pulse.loop
//
//  Created by Riccardo Persello on 28/01/23.
//

import Foundation
import CoreBluetooth

extension CBPeripheralState: CustomStringConvertible {
    public var description: String {
        switch self {
        case .disconnected: return "disconnected"
        case .connected: return "connected"
        case .connecting: return "connecting"
        case .disconnecting: return "disconnecting"
        @unknown default: return "unknown"
        }
    }
}
