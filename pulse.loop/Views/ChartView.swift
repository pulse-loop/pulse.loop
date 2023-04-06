//
//  ChartView.swift
//  pulse.loop
//
//  Created by Riccardo Persello on 18/11/22.
//

import SwiftUI
import CharacteristicKit
import Combine

struct ChannelSpecifier: Hashable {
    let name: String
    let color: Color
}

protocol PlottableData {
    typealias Value = Float
    func getChannels() -> [(specifier: ChannelSpecifier, lastValue: Value)]
}

struct ChartView<T, CharacteristicType: GeneralCharacteristicProtocol<T>>: View where T: PlottableData {
    typealias DataPoint = (value: T.Value, timestamp: TimeInterval)

    var characteristic: CharacteristicType
    var windowLength: TimeInterval = 5
    var channelFilter: [String]?
    var title: LocalizedStringKey?
    
    @State private var channels: [ChannelSpecifier : [DataPoint]] = [ : ]
    @State private var range: (min: T.Value, max: T.Value)?
    @State private var size: CGSize = .zero

    private var numberFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 3

        return formatter
    }

    private func update() {
        for channel in characteristic.value.getChannels() {
            if let channelFilter {
                if !channelFilter.contains(channel.specifier.name) {
                    continue
                }
            }
            
            // Create new channel if it does not exist.
            if channels[channel.specifier] == nil {
                channels[channel.specifier] = []
            }
            
            // Insert new data into the array.
            channels[channel.specifier]?.append((channel.lastValue, CACurrentMediaTime()))
            
            // Remove eventual old data.
            channels[channel.specifier]?.removeAll(where: { (value, timestamp) in
                timestamp + self.windowLength < CACurrentMediaTime()
            })
            
            // Recompute minimums and maximums.
            channels[channel.specifier]?.forEach({ (value, timestamp) in
                if let range {
                    self.range?.max = value > range.max ? value : range.max
                    self.range?.min = value < range.min ? value : range.min
                } else {
                    self.range = (value, value)
                }
            })

        }
    }

    private func getCoordinates(for dataPoint: DataPoint, in size: CGSize) -> CGPoint {
        guard let range,
              range.max - range.min > 0 else {
            return CGPoint.zero
        }
        
        let startPointTime: TimeInterval = CACurrentMediaTime() - windowLength
        let datePointTimeInterval = dataPoint.1 - startPointTime
        let x: CGFloat = datePointTimeInterval / windowLength * size.width

        var (min, max) = range
        let yRange = max - min
        let clampedYRange: Float
        min -= (yRange / T.Value(exactly: 10)!)
        max += (yRange / T.Value(exactly: 10)!)
        clampedYRange = max - min

        let y: CGFloat = size.height - CGFloat((dataPoint.value - min) / clampedYRange) * size.height

        return CGPoint(x: x, y: y)
    }

    private func buildPath(from data: [DataPoint]) -> Path {
        var path = Path()
        if let first = data.first {
            path.move(to: getCoordinates(for: first, in: self.size))
        } else {
            path.move(to: .zero)
        }

        for point in data {
            path.addLine(to: getCoordinates(for: point, in: self.size))
        }

        return path
    }

    var body: some View {
        VStack(alignment: .leading) {
            if let title {
                Text(title)
                    .font(.largeTitle.weight(.semibold))
            }

            Canvas(rendersAsynchronously: false) { context, fullSize in
                DispatchQueue.main.async {
                    self.size = fullSize
                }

                let leftPadding = 0.0
                var paddedSize = fullSize
                paddedSize.width -= leftPadding

                // Background.
                context.fill(
                    Path(
                        roundedRect: CGRect(origin: .zero, size: fullSize),
                        cornerRadius: 8
                    ),
                    with: .color(.gray.opacity(0.1))
                )

                // X markers.
                let seconds: Int = Int(windowLength.rounded(.towardZero))
                var verticalLinePath = Path(.zero)
                verticalLinePath.addLine(to: CGPoint(x: 0, y: paddedSize.height))
                for s in 1..<seconds {
                    let x = (Double(s) / windowLength) * paddedSize.width

                    context.stroke(
                        verticalLinePath.offsetBy(dx: fullSize.width - x, dy: 0),
                        with: .color(.gray),
                        style: StrokeStyle(dash: [2, 2])
                    )
                }

                // Y markers.
                let range = Float((self.range?.max ?? 1) - (self.range?.min ?? 0))
                guard range.isFinite && range != 0 else { return }

                // Calculate the exponent.
                let rangeOrder = powf(10, log10f(range).rounded(.down) - 1)

                // Calculate the first and last values that are in range and multiples of 10^exponent, normalised.
                let firstRoundValue = (Float(self.range?.min ?? 0) / rangeOrder).rounded(.up)
                let lastRoundValue = (Float(self.range?.max ?? 1) / rangeOrder).rounded(.down)

                // Define the path.
                var horizontalLinePath = Path(.zero)
                horizontalLinePath.addLine(to: CGPoint(x: paddedSize.width, y: 0))

                // Draw...
                let stride = Array(Int(firstRoundValue)...Int(lastRoundValue))
                let decimationFactor = Int((Double(stride.count) / 10.0).rounded(.up))

                var ticks: [Float32] = stride.enumerated().filter({
                    $0.offset % decimationFactor == 0
                }).map({Float32($0.element)})

                ticks.removeFirst()
                ticks.removeLast()

                ticks.append(Float(self.range?.min ?? 0) / rangeOrder)
                ticks.append(Float(self.range?.max ?? 1) / rangeOrder)

                for tick in ticks {
                    let y = getCoordinates(for: (tick * rangeOrder, CACurrentMediaTime()), in: paddedSize).y

                    context.draw(
                        Text(numberFormatter.string(for: tick * rangeOrder) ?? "").font(.caption),
                        in: .init(origin: CGPoint(x: 0, y: y - 12), size: CGSize(width: 50, height: 20))
                    )

                    context.stroke(
                        horizontalLinePath.offsetBy(dx: leftPadding, dy: y),
                        with: .color(.gray),
                        style: StrokeStyle(dash: [2, 2])
                    )
                }

                // Lines.
                for channel in self.channels {
                    let path = buildPath(from: channel.value)
                    
                    context.stroke(path, with: .color(channel.key.color), style: StrokeStyle(lineWidth: 2))
                }
            }
            .onReceive(self.characteristic.objectWillChange) { _ in
                self.update()
            }
        }
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        let device = FakeDevice()
        device.connect()

        return TimelineView(.animation) { _ in
            ChartView(characteristic: device.sensorData.aggregatedData, windowLength: 3, title: "Title")
                .padding()
        }
        .previewLayout(.fixed(width: 400, height: 300))
    }
}
