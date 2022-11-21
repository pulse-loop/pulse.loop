//
//  OpticalFrontendRawSensorData.swift
//  pulse.loop
//
//  Created by Riccardo Persello on 21/11/22.
//

import Foundation
import CoreBluetooth

class OpticalFrontendRawSensorData: OpticalFrontendRawSensorDataProtocol, CharacteristicContainer {
    var ambient: Characteristic<Float32>
    var led1MinusAmbient: Characteristic<Float32>
    var led1: Characteristic<Float32>
    var led2: Characteristic<Float32>
    var led3: Characteristic<Float32>
    
    init(for peripheral: CBPeripheral) {
        self.ambient = .init(initialValue: 0, peripheral: peripheral, uuid: CBUUIDs.ambientADCReadingCharacteristicIdentifier)
        self.led1MinusAmbient = .init(initialValue: 0, peripheral: peripheral, uuid: CBUUIDs.led1MinusAmbientCharacteristicIdentifier)
        self.led1 = .init(initialValue: 0, peripheral: peripheral, uuid: CBUUIDs.led1ADCReadingCharacteristicIdentifier)
        self.led2 = .init(initialValue: 0, peripheral: peripheral, uuid: CBUUIDs.led2ADCReadingCharacteristicIdentifier)
        self.led3 = .init(initialValue: 0, peripheral: peripheral, uuid: CBUUIDs.led3ADCReadingCharacteristicIdentifier)
    }
}
