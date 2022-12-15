//
//  OpticalFrontendRawSensorData.swift
//  pulse.loop
//
//  Created by Riccardo Persello on 21/11/22.
//

import Foundation
import CoreBluetooth
import CharacteristicKit

class OpticalFrontendRawSensorData: OpticalFrontendRawSensorDataProtocol, CharacteristicContainer {
    var ambient: Characteristic<Float32>
    var led1MinusAmbient: Characteristic<Float32>
    var led1: Characteristic<Float32>
    var led2: Characteristic<Float32>
    var led3: Characteristic<Float32>
    
    init() {
        self.ambient = Characteristic(initialValue: 0, uuid: CBUUIDs.ambientADCReadingCharacteristicIdentifier)
        self.led1MinusAmbient = Characteristic(initialValue: 0, uuid: CBUUIDs.led1MinusAmbientCharacteristicIdentifier)
        self.led1 = Characteristic(initialValue: 0, uuid: CBUUIDs.led1ADCReadingCharacteristicIdentifier)
        self.led2 = Characteristic(initialValue: 0, uuid: CBUUIDs.led2ADCReadingCharacteristicIdentifier)
        self.led3 = Characteristic(initialValue: 0, uuid: CBUUIDs.led3ADCReadingCharacteristicIdentifier)
    }
}
