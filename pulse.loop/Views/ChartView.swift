//
//  ChartView.swift
//  pulse.loop
//
//  Created by Riccardo Persello on 18/11/22.
//

import SwiftUI
import CharacteristicKit
import Combine

struct ChartView<CharacteristicType: GeneralCharacteristicProtocol<AggregatedData>>: View {

    // swiftlint:disable identifier_name

    enum DataSets {
        case ambient
        case led1
        case led2
        case led3
    }

    typealias DataPoint = (Float32, CFTimeInterval)

    var value: CharacteristicType

    var dataSets: [DataSets] = [.ambient, .led1, .led2, .led3]

    @State private var ambientData: [DataPoint] = []
    @State private var led1Data: [DataPoint] = []
    @State private var led2Data: [DataPoint] = []
    @State private var led3Data: [DataPoint] = []

    @State private var ambientLowerThreshold: [DataPoint] = []
    @State private var led1LowerThreshold: [DataPoint] = []
    @State private var led2LowerThreshold: [DataPoint] = []
    @State private var led3LowerThreshold: [DataPoint] = []

    @State private var ambientUpperThreshold: [DataPoint] = []
    @State private var led1UpperThreshold: [DataPoint] = []
    @State private var led2UpperThreshold: [DataPoint] = []
    @State private var led3UpperThreshold: [DataPoint] = []

    @State private var paths: [WritableKeyPath<Self, State<[DataPoint]>>: Path] = [:]
    @State private var pathCaches: [WritableKeyPath<Self, State<[DataPoint]>>: [CGPoint]] = [:]
    @State private var pathCacheUpdates: [WritableKeyPath<Self, State<[DataPoint]>>: CFTimeInterval] = [:]

    @State private var range: (Float32, Float32) = (.infinity, -.infinity)
    @State private var size: CGSize = .zero

    var windowLength: TimeInterval = 5
    var title: LocalizedStringKey?

    private var numberFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 3

        return formatter
    }

    private func updateAggregated(data: CharacteristicType.T) {
        if dataSets.contains(.ambient) {
            updateDataset(from: data, source: \.ambientReading, destination: \._ambientData)
            updateDataset(from: data, source: \.ambientLowerThreshold, destination: \._ambientLowerThreshold)
            updateDataset(from: data, source: \.ambientUpperThreshold, destination: \._ambientUpperThreshold)
        }

        if dataSets.contains(.led1) {
            updateDataset(from: data, source: \.led1Reading, destination: \._led1Data)
            updateDataset(from: data, source: \.led1LowerThreshold, destination: \._led1LowerThreshold)
            updateDataset(from: data, source: \.led1UpperThreshold, destination: \._led1UpperThreshold)
        }

        if dataSets.contains(.led2) {
            updateDataset(from: data, source: \.led2Reading, destination: \._led2Data)
            updateDataset(from: data, source: \.led2LowerThreshold, destination: \._led2LowerThreshold)
            updateDataset(from: data, source: \.led2UpperThreshold, destination: \._led2UpperThreshold)
        }

        if dataSets.contains(.led3) {
            updateDataset(from: data, source: \.led3Reading, destination: \._led3Data)
            updateDataset(from: data, source: \.led3LowerThreshold, destination: \._led3LowerThreshold)
            updateDataset(from: data, source: \.led3UpperThreshold, destination: \._led3UpperThreshold)
        }
    }

    private func updateDataset(from aggregated: CharacteristicType.T,
                               source: KeyPath<CharacteristicType.T, Int32>,
                               destination: WritableKeyPath<Self, State<[DataPoint]>>) {
        // Add data.
        let newDataPoint = Float(aggregated[keyPath: source]) / 1_000_000
        self[keyPath: destination]
            .wrappedValue
            .append((newDataPoint, CACurrentMediaTime()))

        // Remove others.
        for i in 0..<self[keyPath: destination].wrappedValue.count {
            if let (_, date) = self[keyPath: destination].wrappedValue[safe: i] {
                if date + windowLength < CACurrentMediaTime() {
                    if self[keyPath: destination].wrappedValue.indices.contains(i) {
                        self[keyPath: destination].wrappedValue.remove(at: i)
                    }
                } else {
                    // Break early, as the array is implicitly sorted...
                    break
                }
            }
        }

        // Update range.

        // TODO: Range across different datasets!
        var (min, max) = self.range
        min = newDataPoint < min ? newDataPoint : min
        max = newDataPoint > max ? newDataPoint : max
        self.range = (min, max)

        // Update path cache.
        self.updatePathCache(dataPoints: destination)

        // Create path.
        if let cache = self.pathCaches[destination] {
            paths[destination] = self.buildPath(in: self.size, from: cache)
        }
    }

    private func getCoordinates(for dataPoint: DataPoint, in size: CGSize) -> CGPoint {
        let startPointTime: TimeInterval = CACurrentMediaTime() - windowLength
        let datePointTimeInterval = dataPoint.1 - startPointTime
        let x: CGFloat = datePointTimeInterval / windowLength * size.width

        var (min, max) = self.range
        let yRange = max - min
        let clampedYRange: Float32
        if yRange.isFinite && yRange != 0 {
            min -= (yRange / 10)
            max += (yRange / 10)
            clampedYRange = max - min
        } else {
            clampedYRange = 1
        }

        let y: CGFloat = size.height - CGFloat((dataPoint.0 - min) / clampedYRange) * size.height

        return CGPoint(x: x, y: y)
    }

    private func buildPath(in size: CGSize, from cache: [CGPoint]) -> Path {
        var path = Path()
        path.move(to: cache.first ?? .zero)

        for point in cache {
            path.addLine(to: point)
        }

        return path
    }

    private func updatePathCache(dataPoints: WritableKeyPath<Self, State<[DataPoint]>>) {

        let targetCount = self[keyPath: dataPoints].wrappedValue.count
        var result: [CGPoint] = []

        if let oldCache = self.pathCaches[dataPoints] {
            if oldCache.count >= targetCount {
                result = Array(oldCache.dropFirst(oldCache.count - (targetCount - 1)))
            } else {
                result = oldCache
            }
        }

        // Shift all points to the left.
        let elapsedTime = CACurrentMediaTime() - self.pathCacheUpdates[dataPoints, default: 0]
        let shift = elapsedTime / windowLength * self.size.width
        result = result.map { CGPoint(x: $0.x - shift, y: $0.y) }
        self.pathCacheUpdates[dataPoints] = CACurrentMediaTime()

        // Add new point.
        result.append(
            self.getCoordinates(
                for: self[keyPath: dataPoints].wrappedValue.last ?? (0, CACurrentMediaTime()), in: self.size
            )
        )

        self.pathCaches[dataPoints] = result
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
                let range = Float(self.range.1 - self.range.0)
                guard range.isFinite && range != 0 else { return }

                // Calculate the exponent.
                let rangeOrder = powf(10, log10f(range).rounded(.down) - 1)

                // Calculate the first and last values that are in range and multiples of 10^exponent, normalised.
                let firstRoundValue = (Float(self.range.0) / rangeOrder).rounded(.up)
                let lastRoundValue = (Float(self.range.1) / rangeOrder).rounded(.down)

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

                ticks.append(Float(self.range.0) / rangeOrder)
                ticks.append(Float(self.range.1) / rangeOrder)

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
                let pathsKeyPaths = [\Self._ambientData, \Self._led1Data, \Self._led2Data, \Self._led3Data]
                let colors: [Color] = [.blue, .green, .red, .gray]

                for (keyPath, color) in zip(pathsKeyPaths, colors) {
                    if let path = self.paths[keyPath] {
                        context.stroke(
                            path.offsetBy(dx: leftPadding, dy: 0),
                            with: .color(color),
                            style: StrokeStyle(lineWidth: 2)
                        )
                    }
                }

                // Areas.
                let areasKeyPaths: [(WritableKeyPath<Self, State<[DataPoint]>>,
                                     WritableKeyPath<Self, State<[DataPoint]>>)] = [
                                        (\Self._ambientLowerThreshold, \Self._ambientUpperThreshold),
                                        (\Self._led1LowerThreshold, \Self._led1UpperThreshold),
                                        (\Self._led2LowerThreshold, \Self._led2UpperThreshold),
                                        (\Self._led3LowerThreshold, \Self._led3UpperThreshold)
                                     ]

                for (keyPaths, color) in zip(areasKeyPaths, colors) {
                    if let lower = self.paths[keyPaths.0],
                       let upper = self.paths[keyPaths.1] {
                        context.stroke(lower,
                                       with: .color(color.opacity(0.5)),
                                       style: StrokeStyle(lineWidth: 2, dash: [10, 10]))
                        context.stroke(upper,
                                       with: .color(color.opacity(0.5)),
                                       style: StrokeStyle(lineWidth: 2, dash: [10, 10]))
                    }
                }
            }
            .onReceive(self.value.objectWillChange) { _ in
                updateAggregated(data: self.value.value)
            }
        }
    }
}

struct ChartViewpreviews: PreviewProvider {
    static var previews: some View {
        let device = FakeDevice()
        device.connect()

        return TimelineView(.animation) { _ in
            ChartView(value: device.rawSensorData.aggregatedData, dataSets: [.led2], windowLength: 3, title: "Chart")
                .padding()
        }
        .previewLayout(.fixed(width: 400, height: 300))
    }
}
