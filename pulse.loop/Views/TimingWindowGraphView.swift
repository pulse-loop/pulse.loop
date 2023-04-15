//
//  TimingWindowGraphView.swift
//  pulse.loop
//
//  Created by Riccardo Persello on 03/11/22.
//

import SwiftUI

// swiftlint:disable:next generic_type_name
struct TimingWindowGraphView<OpticalWindowConfiguration: TimingWindowProtocol>: View {
    @Binding var windowConfiguration: OpticalWindowConfiguration
    var ledColors: [Color] = [.blue.opacity(0.75), .green.opacity(0.75), .red.opacity(0.75), .gray.opacity(0.75)]

    @State var lastScaleValue: CGFloat = 1
    @State var scale: CGFloat = 1

    var body: some View {
        VStack(alignment: .leading) {
            GeometryReader { geometry in
                ScrollView(.horizontal) {
                    TimelineView(.periodic(from: .now, by: 1)) { context in
                        Canvas { context, size in
                            func rectangleForInterval(from start: Float32, to end: Float32) -> Path {
                                let xStart = size.width * CGFloat(start/windowConfiguration.totalWindowLength.value)
                                let xEnd = size.width * CGFloat(end/windowConfiguration.totalWindowLength.value)
                                let rect = CGRect(x: xStart, y: 0, width: xEnd - xStart, height: size.height)
                                return Path(rect)
                            }

                            func rectangleForInterval(from start: Float32, to end: Float32, band: Int) -> Path {
                                let xStart = size.width * CGFloat(start/windowConfiguration.totalWindowLength.value)
                                let xEnd = size.width * CGFloat(end/windowConfiguration.totalWindowLength.value)

                                let bandHeight = size.height / 4
                                let yStart = CGFloat(band) * bandHeight

                                let rect = CGRect(x: xStart, y: yStart, width: xEnd - xStart, height: bandHeight)
                                return Path(rect)
                            }

                            // Fill dynamic power down
                            let dynamicPowerDownPath = rectangleForInterval(
                                from: windowConfiguration.dynamicPowerDown.start.value,
                                to: windowConfiguration.dynamicPowerDown.end.value
                            )

                            context.fill(dynamicPowerDownPath, with: .linearGradient(
                                            .init(stops: [
                                                .init(color: .primary.opacity(0.1), location: 0),
                                                .init(color: .primary.opacity(0.1), location: 0.4),
                                                .init(color: .clear, location: 0.4)
                                            ]),
                                            startPoint: .zero,
                                            endPoint: CGPoint(x: 16, y: 16),
                                            options: .repeat)
                            )

                            // Five horizontal alternate color bands
                            let colors: [Color] = [.clear, .primary.opacity(0.1), .clear, .primary.opacity(0.1)]

                            for bandIndex in 0..<4 {
                                let band = rectangleForInterval(from: .zero,
                                                                to: windowConfiguration.dynamicPowerDown.start.value,
                                                                band: bandIndex)

                                context.fill(band, with: .color(colors[bandIndex]))
                            }

                            // swiftlint:disable line_length

                            // Overlay indicators: lighting
                            let lightingTuples = [
                                (0, 0),
                                (windowConfiguration.LED1Phase.ledStart.value, windowConfiguration.LED1Phase.ledEnd.value),
                                (windowConfiguration.LED2Phase.ledStart.value, windowConfiguration.LED2Phase.ledEnd.value),
                                (windowConfiguration.LED3Phase.ledStart.value, windowConfiguration.LED3Phase.ledEnd.value)
                            ]

                            for tuple in lightingTuples.enumerated() {
                                let rect = rectangleForInterval(from: tuple.element.0, to: tuple.element.1, band: 0)
                                context.fill(rect, with: .color(ledColors[tuple.offset]))
                            }

                            // Overlay indicators: sampling
                            let samplingTuples = [
                                (windowConfiguration.ambientPhase.sampleStart.value, windowConfiguration.ambientPhase.sampleEnd.value),
                                (windowConfiguration.LED1Phase.sampleStart.value, windowConfiguration.LED1Phase.sampleEnd.value),
                                (windowConfiguration.LED2Phase.sampleStart.value, windowConfiguration.LED2Phase.sampleEnd.value),
                                (windowConfiguration.LED3Phase.sampleStart.value, windowConfiguration.LED3Phase.sampleEnd.value)
                            ]

                            for tuple in samplingTuples.enumerated() {
                                let rect = rectangleForInterval(from: tuple.element.0, to: tuple.element.1, band: 1)
                                context.fill(rect, with: .color(ledColors[tuple.offset]))
                            }

                            // Overlay indicators: conversion
                            let conversionTuples = [
                                (windowConfiguration.ambientPhase.convStart.value, windowConfiguration.ambientPhase.convEnd.value),
                                (windowConfiguration.LED1Phase.convStart.value, windowConfiguration.LED1Phase.convEnd.value),
                                (windowConfiguration.LED2Phase.convStart.value, windowConfiguration.LED2Phase.convEnd.value),
                                (windowConfiguration.LED3Phase.convStart.value, windowConfiguration.LED3Phase.convEnd.value)
                            ]

                            for tuple in conversionTuples.enumerated() {
                                let rect = rectangleForInterval(from: tuple.element.0, to: tuple.element.1, band: 2)
                                context.fill(rect, with: .color(ledColors[tuple.offset]))
                            }

                            // Overlay indicators: reset
                            let resetTuples = [
                                (windowConfiguration.ambientPhase.resetStart.value, windowConfiguration.ambientPhase.resetEnd.value),
                                (windowConfiguration.LED1Phase.resetStart.value, windowConfiguration.LED1Phase.resetEnd.value),
                                (windowConfiguration.LED2Phase.resetStart.value, windowConfiguration.LED2Phase.resetEnd.value),
                                (windowConfiguration.LED3Phase.resetStart.value, windowConfiguration.LED3Phase.resetEnd.value)
                            ]

                            for tuple in resetTuples.enumerated() {
                                let rect = rectangleForInterval(from: tuple.element.0, to: tuple.element.1, band: 3)
                                context.fill(rect, with: .color(ledColors[tuple.offset]))
                            }

                            // Overlay text
                            let names = ["LI", "SA", "CNV", "RST"]

                            for nameIndex in 0..<4 {
                                let point = CGPoint(x: 2, y: 2 + size.height / 4 * CGFloat(nameIndex))

                                context.draw(
                                    Text(names[nameIndex])
                                        .font(.system(size: 8).italic().monospaced()),
                                    at: point,
                                    anchor: .topLeading
                                )
                            }
                        }
                        .frame(width: geometry.size.width * scale)
                        .drawingGroup()
                    }
                }
                .overlay(alignment: .topTrailing) {
                    HStack {
                        Button {
                            scale /= 1.2
                            if scale < 1 { scale = 1 }
                        } label: {
                            Label("Zoom in", systemImage: "minus.magnifyingglass")
                        }

                        Button {
                            scale *= 1.2
                        } label: {
                            Label("Zoom out", systemImage: "plus.magnifyingglass")
                        }
                    }
                    .buttonStyle(.borderless)
                    .labelStyle(.iconOnly)
                    .padding(4)
                    .background(in: RoundedRectangle(cornerRadius: 4, style: .continuous))
                    // .backgroundStyle(.thinMaterial)
                    .padding(4)

                }
            }
            .frame(height: 100)

            HStack(spacing: 30) {
                HStack {
                    Circle().fill(ledColors[0]).frame(width: 20)
                    Text("Ambient")
                }

                HStack {
                    Circle().fill(ledColors[1]).frame(width: 20)
                    Text("Green")
                }

                HStack {
                    Circle().fill(ledColors[2]).frame(width: 20)
                    Text("Red")
                }

                HStack {
                    Circle().fill(ledColors[3]).frame(width: 20)
                    Text("Infrared")
                }
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
        }
    }
}

struct TimingWindowGraphViewpreviews: PreviewProvider {
    static var previews: some View {
        let conf = FakeTimingWindow()

        TimingWindowGraphView(windowConfiguration: .constant(conf))
            .previewLayout(.sizeThatFits)
    }
}
