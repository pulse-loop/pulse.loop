//
//  Characteristic.swift
//  pulse.loop
//
//  Created by Riccardo Persello on 18/11/22.
//

import Foundation
import CoreBluetooth

protocol CharacteristicProtocol<T>: ObservableObject, Equatable {
    associatedtype T: Equatable
    
    var value: T { get }
    var uuid: CBUUID { get }
    var type: Any.Type { get }
    
    func setLocalValue(data: Data)
    func setLocalValue(value: T)
}

extension CharacteristicProtocol {
    var type: Any.Type {
        return T.self
    }
}

class FakeCharacteristic<T: Equatable>: CharacteristicProtocol {
    var value: T
    let uuid: CBUUID = CBUUID()
    
    init(constant: T) {
        self.value = constant
    }
    
    func setLocalValue(data: Data) {
        self.value = data.withUnsafeBytes({$0.load(as: T.self)})
        
        DispatchQueue.main.async {
            self.objectWillChange.send()
        }
    }
    
    func setLocalValue(value: T) {
        self.value = value
        
        DispatchQueue.main.async {
            self.objectWillChange.send()
        }
    }
    
    static func == (lhs: FakeCharacteristic<T>, rhs: FakeCharacteristic<T>) -> Bool {
        return lhs.value == rhs.value
    }
}

class Characteristic<T: Equatable>: CharacteristicProtocol {
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
    
    static func == (lhs: Characteristic<T>, rhs: Characteristic<T>) -> Bool {
        return lhs.value == rhs.value
    }
    
    func setLocalValue(data: Data) {
        // Padding.
        let requiredPadding = MemoryLayout<T>.size - data.count
        var paddedData = Data(count: requiredPadding)
        paddedData.append(data)
        self.internalValue = paddedData.withUnsafeBytes({$0.load(as: T.self)})
        
        DispatchQueue.main.async {
            self.objectWillChange.send()
        }
    }
    
    func setLocalValue(value: T) {
        self.value = value
        
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