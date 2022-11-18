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
    
    func setLocalValue(value: Data)
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
    
    func setLocalValue(value: Data) {
        self.value = value.withUnsafeBytes({$0.load(as: T.self)})
        self.objectWillChange.send()
    }
}

class Characteristic<T>: CharacteristicProtocol {
    private var internalValue: T
    private let peripheral: CBPeripheral
    private var characteristic: CBCharacteristic?
    let uuid: CBUUID

    init(initialValue: T, peripheral: CBPeripheral, uuid: CBUUID) {
        self.internalValue = initialValue
        self.peripheral = peripheral
        self.uuid = uuid
        self.characteristic = Self.discoverCharacteristic(from: uuid, on: peripheral)
    }
    
    private static func discoverCharacteristic(from uuid: CBUUID, on peripheral: CBPeripheral) -> CBCharacteristic? {
        return (peripheral.services?.compactMap({ service in
            service.characteristics?.first(where: { characteristic in
                characteristic.uuid == uuid
            })
        }).first)
    }

    private func requestRead() {
        if let characteristic {
            peripheral.readValue(for: characteristic)
        } else {
            self.characteristic = Self.discoverCharacteristic(from: self.uuid, on: self.peripheral)
        }
    }

    private func requestWrite(value: T) {
        if let characteristic {
            self.internalValue = value
            peripheral.writeValue(Data(bytes: &self.internalValue, count: 1), for: characteristic, type: .withResponse)
        } else {
            self.characteristic = Self.discoverCharacteristic(from: self.uuid, on: self.peripheral)
        }
    }
    
    func setLocalValue(value: Data) {
        self.internalValue = value.withUnsafeBytes({$0.load(as: T.self)})
        
        DispatchQueue.main.async {
            self.objectWillChange.send()
        }
    }

    var notifying: Bool {
        return characteristic?.isNotifying ?? false
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
