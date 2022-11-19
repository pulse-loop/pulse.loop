//
//  ChartView.swift
//  pulse.loop
//
//  Created by Riccardo Persello on 18/11/22.
//

import SwiftUI

struct ChartView<CharacteristicType: CharacteristicProtocol<Float32>>: View {
    typealias DataPoint = (CharacteristicType.T, Date)
    
    @ObservedObject var value: CharacteristicType
    @State var data: [DataPoint] = []
    @State var range: (CharacteristicType.T, CharacteristicType.T) = (.infinity, -.infinity)
    @State var path: Path = Path()
    @State var size: CGSize = .zero
    @State var lastValue: CharacteristicType.T = .zero
    let windowLength: TimeInterval = 5
    
    init(value: CharacteristicType) {
        self.value = value
    }
    
    private func updateChartWith(value: CharacteristicType.T, size: CGSize) {
        Task {
            // Add data.
            data.append((value, Date.now))
            
            // Remove others.
            for i in 0..<data.count {
                let (value, date) = data[i]
                if date + windowLength < Date.now {
                    data.remove(at: i)
                    
                    // Recompute min/max if needed.
                    if value == self.range.0 {
                        self.range.0 = data.map({$0.0}).min() ?? .infinity
                    } else if value == self.range.1 {
                        self.range.1 = data.map({$0.0}).max() ?? -.infinity
                    }
                } else {
                    // Break early, the array is implicitly sorted...
                    break
                }
            }
            
            // Update range.
            var (min, max) = self.range
            min = value < min ? value : min
            max = value > max ? value : max
            self.range = (min, max)
            
            // Update path.
            self.buildPath(in: size)
            
            // Set last value.
            self.lastValue = value
        }
    }
    
    private func getCoordinates(for dataPoint: DataPoint, in size: CGSize) -> CGPoint {
        let datePointTimeInterval: TimeInterval = windowLength - Date.now.timeIntervalSince(dataPoint.1)
        let x: CGFloat = datePointTimeInterval / windowLength * size.width
        
        var (min, max) = self.range
        let yRange = max - min
        let clampedYRange: CharacteristicType.T
        if yRange.isFinite && yRange != 0 {
            min = min - yRange * 0.1
            max = max + yRange * 0.1
            clampedYRange = max - min
        } else {
            clampedYRange = 1
        }
        
        let y: CGFloat = CGFloat((dataPoint.0 - min) / clampedYRange) * size.height
        
        return CGPoint(x: x, y: y)
    }
    
    private func buildPath(in size: CGSize) {
        var path = Path()
        for point in data {
            let coordinate = getCoordinates(for: point, in: size)
            path.addLine(to: coordinate)
        }
        
        self.path = path
    }
    
    var body: some View {
        Canvas(rendersAsynchronously: true) { context, size in
            if self.lastValue != self.value.value {
                updateChartWith(value: self.value.value, size: size)
            }
            
            DispatchQueue.main.async {
                self.size = size
            }
            context.stroke(self.path, with: .color(.red))
        }
        .frame(minWidth: 100)
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        @ObservedObject var device = FakeDevice()
        device.connect()
        
        return TimelineView(.animation) { _ in
            ChartView(value: device.rawOpticalAmbient)
        }
        .previewLayout(.fixed(width: 600, height: 400))
    }
}
