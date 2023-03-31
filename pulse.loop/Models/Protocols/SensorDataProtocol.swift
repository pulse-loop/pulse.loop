//
//  SensorDataProtocol.swift
//  pulse.loop
//
//  Created by Riccardo Persello on 21/11/22.
//

import Foundation
import CharacteristicKit

protocol SensorDataProtocol: ObservableObject {
    associatedtype AggregatedDataType: GeneralCharacteristicProtocol<RawOpticalData>

    var aggregatedData: AggregatedDataType { get }
}
