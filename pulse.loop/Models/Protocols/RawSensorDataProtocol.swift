//
//  RawSensorDataProtocol.swift
//  pulse.loop
//
//  Created by Riccardo Persello on 21/11/22.
//

import Foundation
import CharacteristicKit

protocol RawSensorDataProtocol: ObservableObject {
    associatedtype RawOpticalType: CharacteristicProtocol<Float32>

    var ambient: RawOpticalType { get set }
    var led1MinusAmbient: RawOpticalType { get set }
    var led1: RawOpticalType { get set }
    var led2: RawOpticalType { get set }
    var led3: RawOpticalType { get set }
}
