//
//  ChartView.swift
//  pulse.loop
//
//  Created by Riccardo Persello on 18/11/22.
//

import SwiftUI
import CharacteristicKit

struct ChartView<CharacteristicType: CharacteristicProtocol<Float32>>: View {
    typealias DataPoint = (CharacteristicType.T, Date)
    
    @ObservedObject var value: CharacteristicType
    @State var data: [DataPoint] = []
    @State var range: (CharacteristicType.T, CharacteristicType.T) = (.infinity, -.infinity)
    @State var path: Path = Path()
    @State var lastValue: CharacteristicType.T = .zero
    
    let windowLength: TimeInterval
    let title: LocalizedStringKey?
    let lineColor: Color
    let smooth: Bool
    
    var numberFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 3
        
        return formatter
    }
    
    init(value: CharacteristicType,
         title: LocalizedStringKey? = nil,
         lineColor: Color = .red,
         windowLength: TimeInterval = 5,
         smooth: Bool = false
    ) {
        self.value = value
        self.title = title
        self.lineColor = lineColor
        self.windowLength = windowLength
        self.smooth = smooth
    }
    
    private func updateChartWith(value: CharacteristicType.T, size: CGSize) {
        Task {
            // Add data.
            data.append((value, Date.now))
            
            // Remove others.
            for i in 0..<data.count {
                if let (value, date) = data[safe: i] {
                    if date + windowLength < Date.now {
                        data.remove(at: i)
                        
                        // Recompute min/max if needed.
                        if value == self.range.0 {
                            self.range.0 = data.map({$0.0}).min() ?? .infinity
                        } else if value == self.range.1 {
                            self.range.1 = data.map({$0.0}).max() ?? -.infinity
                        }
                    } else {
                        // Break early, as the array is implicitly sorted...
                        break
                    }
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
        
        let y: CGFloat = size.height - CGFloat((dataPoint.0 - min) / clampedYRange) * size.height
        
        return CGPoint(x: x, y: y)
    }
    
    private func buildPath(in size: CGSize) {
        var path = Path()
        path.move(to: getCoordinates(for: data.first ?? (0, Date.now), in: size))
        for point in data {
            let coordinate = getCoordinates(for: point, in: size)
            path.addLine(to: coordinate)
        }
        
        self.path = path
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            if let title {
                Text(title)
                    .font(.largeTitle.weight(.semibold))
            }
            
            Canvas(rendersAsynchronously: true) { context, fullSize in
                
                let leftPadding = 0.0
                var paddedSize = fullSize
                paddedSize.width -= leftPadding
                
                // Add data.
                if self.lastValue != self.value.value || smooth {
                    updateChartWith(value: self.value.value, size: paddedSize)
                }
                
                // Background.
                context.fill(Path(roundedRect: CGRect(origin: .zero, size: fullSize), cornerRadius: 8), with: .color(.gray.opacity(0.1)))
                
                // X markers.
                let seconds: Int = Int(windowLength.rounded(.towardZero))
                var verticalLinePath = Path(.zero)
                verticalLinePath.addLine(to: CGPoint(x: 0, y: paddedSize.height))
                for s in 1..<seconds {
                    let x = (Double(s) / windowLength) * paddedSize.width
                    context.stroke(verticalLinePath.offsetBy(dx: fullSize.width - x, dy: 0), with: .color(.gray), style: StrokeStyle(dash: [2, 2]))
                }
                
                // Y markers.
                let range = Float(self.range.1 - self.range.0)
                guard range.isFinite && range != 0 else { return }
                
                // Calculate the exponent.
                let rangeOrder = powf(10, log10f(range).rounded(.down) - 1)
                
                // Calculate the first and last values that are in range and multiples of 10^exponent, normalised.
                let firstRoundValue = (self.range.0 / rangeOrder).rounded(.up)
                let lastRoundValue = (self.range.1 / rangeOrder).rounded(.down)
                
                // Define the path.
                var horizontalLinePath = Path(.zero)
                horizontalLinePath.addLine(to: CGPoint(x: paddedSize.width, y: 0))
                
                // Draw...
                let stride = Array(Int(firstRoundValue)...Int(lastRoundValue))
                let decimationFactor = Int((Double(stride.count) / 10.0).rounded(.up))
                
                var ticks: Array<Float32> = stride.enumerated().filter({
                    $0.offset % decimationFactor == 0
                }).map({Float32($0.element)})
                
                ticks.removeFirst()
                ticks.removeLast()
                
                ticks.append(self.range.0 / rangeOrder)
                ticks.append(self.range.1 / rangeOrder)
                
                for tick in ticks {
                    let y = getCoordinates(for: (tick * rangeOrder, Date()), in: paddedSize).y
                    context.draw(Text(numberFormatter.string(for: tick * rangeOrder) ?? "").font(.caption), in: .init(origin: CGPoint(x: 0, y: y - 12), size: CGSize(width: 50, height: 20)))
                    context.stroke(horizontalLinePath.offsetBy(dx: leftPadding, dy: y), with: .color(.gray), style: StrokeStyle(dash: [2, 2]))
                }
                
                // Line.
                context.stroke(self.path.offsetBy(dx: leftPadding, dy: 0), with: .color(lineColor), style: StrokeStyle(lineWidth: 2))
            }
            .frame(minWidth: 100)
        }
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        @ObservedObject var device = FakeDevice()
        device.connect()
        
        return TimelineView(.animation) { _ in
            ChartView(value: device.rawSensorData.ambient, title: "Chart", smooth: true)
                .padding()
        }
        .previewLayout(.fixed(width: 600, height: 400))
    }
}
