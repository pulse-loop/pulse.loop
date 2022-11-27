//
//  Characteristic.swift
//  pulse.loop
//
//  Created by Riccardo Persello on 18/11/22.
//

import Foundation
import CoreBluetooth
import Runtime
import os

protocol CharacteristicContainer {}

extension CharacteristicContainer {
    func getCharacteristics() -> [CBUUID: any CharacteristicProtocol] {
        var variableMap: [CBUUID: any CharacteristicProtocol] = [:]
        let info = try! typeInfo(of: Self.self)
        for property in info.properties {
            if let variable = try? property.get(from: self) as? any CharacteristicProtocol {
                variableMap[variable.uuid] = variable
            } else if let variable = try? property.get(from: self) as? any CharacteristicContainer {
                variableMap.merge(variable.getCharacteristics(), uniquingKeysWith: { (current, _) in
                    current
                })
            }
        }
        
        return variableMap
    }
}

protocol CharacteristicProtocol<T>: ObservableObject, Equatable {
    associatedtype T: Equatable
    
    var value: T { get set }
    var uuid: CBUUID { get }
    var type: Any.Type { get }
    
    func refreshValue()
    func setLocalValue(data: Data)
    func setLocalValue(value: T)
}

extension CharacteristicProtocol {
    var type: Any.Type {
        return T.self
    }
}

class FakeCharacteristic<T: Equatable>: CharacteristicProtocol {
    @Published var value: T
    let uuid: CBUUID = CBUUID()
    
    init(constant: T) {
        self.value = constant
    }
    
    func refreshValue() {}
    
    func setLocalValue(data: Data) {
        DispatchQueue.main.async {
            self.value = data.withUnsafeBytes({$0.load(as: T.self)})
        }
    }
    
    func setLocalValue(value: T) {
        DispatchQueue.main.async {
            self.value = value
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
    let maximumPollingInterval: TimeInterval = 1
    var lastReadingTime: Date
    
    private let logger: Logger

    init(initialValue: T, peripheral: CBPeripheral, uuid: CBUUID) {
        self.internalValue = initialValue
        self.peripheral = peripheral
        self.uuid = uuid
        self.characteristic = Self.discoverCharacteristic(from: uuid, on: peripheral)
        self.lastReadingTime = Date.now
        
        self.logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: "Characteristic \(uuid)")
        
        self.refreshValue()
    }
    
    private static func discoverCharacteristic(from uuid: CBUUID, on peripheral: CBPeripheral) -> CBCharacteristic? {
        return (peripheral.services?.compactMap({ service in
            service.characteristics?.first(where: { characteristic in
                characteristic.uuid == uuid
            })
        }).first)
    }

    func refreshValue() {
        logger.trace("Read request.")
        if let characteristic {
            peripheral.readValue(for: characteristic)
        } else {
            self.characteristic = Self.discoverCharacteristic(from: self.uuid, on: self.peripheral)
            
            // Retry at most another time.
            if let characteristic {
                peripheral.readValue(for: characteristic)
            }
        }
    }

    private func write(value: T) {
        if let csc = value as? CustomStringConvertible {
            logger.trace("Write request for value \(csc.description)")
        } else {
            logger.trace("Write request.")
        }
        
        if let characteristic {
            self.internalValue = value
            let size = MemoryLayout.size(ofValue: self.internalValue)
            peripheral.writeValue(Data(bytes: &self.internalValue, count: size), for: characteristic, type: .withResponse)
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
        
        if let csc = self.internalValue as? CustomStringConvertible {
            logger.trace("Local value set to \(csc.description)")
        } else {
            logger.trace("Local value set.")
        }
                
        DispatchQueue.main.async {
            self.objectWillChange.send()
        }
    }
    
    func setLocalValue(value: T) {
        self.internalValue = value
        
        if let csc = self.internalValue as? CustomStringConvertible {
            logger.trace("Local value set to \(csc.description)")
        } else {
            logger.trace("Local value set.")
        }
        
        DispatchQueue.main.async {
            self.objectWillChange.send()
        }
    }

    var notifying: Bool {
        return characteristic?.isNotifying ?? false
    }

    var value: T {
        get {
            if !notifying && abs(lastReadingTime.timeIntervalSinceNow) > self.maximumPollingInterval {
                lastReadingTime = Date.now
                refreshValue()
            }
            return internalValue
        }
        set {
            if self.internalValue != newValue {
                write(value: newValue)
            }
        }
    }
}
