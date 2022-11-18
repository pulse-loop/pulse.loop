//
//  Characteristic.swift
//  pulse.loop
//
//  Created by Riccardo Persello on 18/11/22.
//

import Foundation
import CoreBluetooth

protocol CharacteristicProtocol<T>: ObservableObject {
    associatedtype T
    
    var value: T { get set }
    var uuid: CBUUID { get }
    var type: Any.Type { get }
}

extension CharacteristicProtocol {
    var type: Any.Type {
        return T.self
    }
}

class FakeCharacteristic<T>: CharacteristicProtocol {
    @Published var value: T
    let uuid: CBUUID = CBUUID()
    
    init(constant: T) {
        self.value = constant
    }
}

class Characteristic<T>: CharacteristicProtocol {
    private var internalValue: T
    private let peripheral: CBPeripheral
    private let characteristic: CBCharacteristic
    let uuid: CBUUID

    init(initialValue: T, peripheral: CBPeripheral?, uuid: CBUUID) {
        self.internalValue = initialValue
        self.peripheral = peripheral!
        self.uuid = uuid
        self.characteristic = (peripheral!.services?.compactMap({ service in
            service.characteristics?.first(where: { characteristic in
                characteristic.uuid == uuid
            })
        }).first)!
    }

    private func requestRead() {
        peripheral.readValue(for: self.characteristic)
    }

    private func requestWrite(value: T) {
        self.internalValue = value
        peripheral.writeValue(Data(bytes: &self.internalValue, count: 1), for: self.characteristic, type: .withResponse)
    }

    func setLocalValue(value: Data) {
        self.internalValue = value.withUnsafeBytes({$0.load(as: T.self)})
        self.objectWillChange.send()
    }

    var notifying: Bool {
        return characteristic.isNotifying
    }

    var value: T {
        get {
            requestRead()
            return internalValue
        }
        set {
            requestWrite(value: newValue)
        }
    }
}
