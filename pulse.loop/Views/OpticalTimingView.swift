//
//  OpticalTimingView.swift
//  pulse.loop
//
//  Created by Riccardo Persello on 03/11/22.
//

import SwiftUI

struct OpticalTimingView<OpticalConfiguration: OpticalFrontendConfigurationProtocol>: View {
    @ObservedObject var opticalConfiguration: OpticalConfiguration
    var ledColors: [Color] = [.blue.opacity(0.75), .red.opacity(0.75), .green.opacity(0.75), .yellow.opacity(0.75)]
    
    @State var lastScaleValue: CGFloat = 1
    @State var scale: CGFloat = 1
    
    var body: some View {
        VStack(alignment: .leading) {
            GeometryReader { geometry in
                ScrollView(.horizontal) {
                    Canvas { context, size in
                        func rectangleForInterval(from start: TimeInterval, to end: TimeInterval) -> Path {
                            let xStart = size.width * (start/opticalConfiguration.totalWindowLength)
                            let xEnd = size.width * (end/opticalConfiguration.totalWindowLength)
                            let rect = CGRect(x: xStart, y: 0, width: xEnd - xStart, height: size.height)
                            return Path(rect)
                        }
                        
                        func rectangleForInterval(from start: TimeInterval, to end: TimeInterval, band: Int) -> Path {
                            let xStart = size.width * (start/opticalConfiguration.totalWindowLength)
                            let xEnd = size.width * (end/opticalConfiguration.totalWindowLength)
                            
                            let bandHeight = size.height / 4
                            let yStart = CGFloat(band) * bandHeight
                            
                            let rect = CGRect(x: xStart, y: yStart, width: xEnd - xStart, height: bandHeight)
                            return Path(rect)
                        }
                        
                        // Fill dynamic power down
                        let dynamicPowerDownPath = rectangleForInterval(from: opticalConfiguration.dynamicPowerDown.start,
                                                                        to: opticalConfiguration.dynamicPowerDown.end)
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
                        
                        for i in 0..<4 {
                            let band = rectangleForInterval(from: .zero, to: opticalConfiguration.dynamicPowerDown.start, band: i)
                            context.fill(band, with: .color(colors[i]))
                        }
                        
                        // Overlay indicators: lighting
                        let lightingTuples = [
                            (0, 0),
                            (opticalConfiguration.LED1Phase.led_st, opticalConfiguration.LED1Phase.led_end),
                            (opticalConfiguration.LED2Phase.led_st, opticalConfiguration.LED2Phase.led_end),
                            (opticalConfiguration.LED3Phase.led_st, opticalConfiguration.LED3Phase.led_end)
                        ]
                        
                        for tuple in lightingTuples.enumerated() {
                            let rect = rectangleForInterval(from: tuple.element.0, to: tuple.element.1, band: 0)
                            context.fill(rect, with: .color(ledColors[tuple.offset]))
                        }
                        
                        // Overlay indicators: sampling
                        let samplingTuples = [
                            (opticalConfiguration.ambientPhase.sample_st, opticalConfiguration.ambientPhase.sample_end),
                            (opticalConfiguration.LED1Phase.sample_st, opticalConfiguration.LED1Phase.sample_end),
                            (opticalConfiguration.LED2Phase.sample_st, opticalConfiguration.LED2Phase.sample_end),
                            (opticalConfiguration.LED3Phase.sample_st, opticalConfiguration.LED3Phase.sample_end)
                        ]
                        
                        for tuple in samplingTuples.enumerated() {
                            let rect = rectangleForInterval(from: tuple.element.0, to: tuple.element.1, band: 1)
                            context.fill(rect, with: .color(ledColors[tuple.offset]))
                        }
                        
                        // Overlay indicators: conversion
                        let conversionTuples = [
                            (opticalConfiguration.ambientPhase.conv_st, opticalConfiguration.ambientPhase.conv_end),
                            (opticalConfiguration.LED1Phase.conv_st, opticalConfiguration.LED1Phase.conv_end),
                            (opticalConfiguration.LED2Phase.conv_st, opticalConfiguration.LED2Phase.conv_end),
                            (opticalConfiguration.LED3Phase.conv_st, opticalConfiguration.LED3Phase.conv_end)
                        ]
                        
                        for tuple in conversionTuples.enumerated() {
                            let rect = rectangleForInterval(from: tuple.element.0, to: tuple.element.1, band: 2)
                            context.fill(rect, with: .color(ledColors[tuple.offset]))
                        }
                        
                        // Overlay indicators: reset
                        let resetTuples = [
                            (opticalConfiguration.ambientPhase.reset_st, opticalConfiguration.ambientPhase.reset_end),
                            (opticalConfiguration.LED1Phase.reset_st, opticalConfiguration.LED1Phase.reset_end),
                            (opticalConfiguration.LED2Phase.reset_st, opticalConfiguration.LED2Phase.reset_end),
                            (opticalConfiguration.LED3Phase.reset_st, opticalConfiguration.LED3Phase.reset_end)
                        ]
                        
                        for tuple in resetTuples.enumerated() {
                            let rect = rectangleForInterval(from: tuple.element.0, to: tuple.element.1, band: 3)
                            context.fill(rect, with: .color(ledColors[tuple.offset]))
                        }
                        
                        // Overlay text
                        let names = ["LI", "SA", "CNV", "RST"]
                        
                        for i in 0..<4 {
                            let point = CGPoint(x: 2, y: 2 + size.height / 4 * CGFloat(i))
                            context.draw(Text(names[i]).font(.system(size: 8).italic().monospaced()), at: point, anchor: .topLeading)
                        }
                    }
                    .frame(width: geometry.size.width * scale)
                }
                .overlay(alignment: .topTrailing) {
                    HStack {
                        Button {
                            scale = scale / 1.2
                            if scale < 1 { scale = 1 }
                        } label: {
                            Label("Zoom in", systemImage: "minus.magnifyingglass")
                        }

                        Button {
                            scale = scale * 1.2
                        } label: {
                            Label("Zoom out", systemImage: "plus.magnifyingglass")
                        }
                    }
                    .buttonStyle(.borderless)
                    .labelStyle(.iconOnly)
                    .padding(4)
                    .background(in: RoundedRectangle(cornerRadius: 4, style: .continuous))
                    .backgroundStyle(.thinMaterial)
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
                    Text("LED 1")
                }
                
                HStack {
                    Circle().fill(ledColors[2]).frame(width: 20)
                    Text("LED 2")
                }
                 
                HStack {
                    Circle().fill(ledColors[3]).frame(width: 20)
                    Text("LED 3")
                }
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
        }
    }
}

struct OpticalTimingView_Previews: PreviewProvider {
    static var previews: some View {
        let conf = FakeOpticalFrontendConfiguration(
            ambientPhase: FakeOpticalFrontendConfiguration.AmbientPhase(
                sample_st: TimeInterval(microseconds: 2225),
                sample_end: TimeInterval(microseconds: 2299.75),
                reset_st: TimeInterval(microseconds: 2600),
                reset_end: TimeInterval(microseconds: 2610),
                conv_st: TimeInterval(microseconds: 2300),
                conv_end: TimeInterval(microseconds: 2500)
            ),
            LED1Phase: FakeOpticalFrontendConfiguration.LEDPhase(
                led_st: TimeInterval(microseconds: 1100),
                led_end: TimeInterval(microseconds: 1400),
                sample_st: TimeInterval(microseconds: 1225),
                sample_end: TimeInterval(microseconds: 1299.75),
                reset_st: TimeInterval(microseconds: 1600),
                reset_end: TimeInterval(microseconds: 1605),
                conv_st: TimeInterval(microseconds: 1300),
                conv_end: TimeInterval(microseconds: 1500)
            ),
            LED2Phase: FakeOpticalFrontendConfiguration.LEDPhase(
                led_st: TimeInterval(microseconds: 100),
                led_end: TimeInterval(microseconds: 400),
                sample_st: TimeInterval(microseconds: 225),
                sample_end: TimeInterval(microseconds: 299.75),
                reset_st: TimeInterval(microseconds: 600),
                reset_end: TimeInterval(microseconds: 601),
                conv_st: TimeInterval(microseconds: 300),
                conv_end: TimeInterval(microseconds: 500)
            ),
            LED3Phase: FakeOpticalFrontendConfiguration.LEDPhase(
                led_st: TimeInterval(microseconds: 3100),
                led_end: TimeInterval(microseconds: 3400),
                sample_st: TimeInterval(microseconds: 3225),
                sample_end: TimeInterval(microseconds: 3299.75),
                reset_st: TimeInterval(microseconds: 3600),
                reset_end: TimeInterval(microseconds: 3630),
                conv_st: TimeInterval(microseconds: 3300),
                conv_end: TimeInterval(microseconds: 3500)
            ),
            totalWindowLength: TimeInterval(microseconds: 10000),
            dynamicPowerDown: FakeOpticalFrontendConfiguration.DynamicPowerDownPhase(
                start: TimeInterval(microseconds: 5000),
                end: TimeInterval(microseconds: 10000)
            ),
            tiaCapacitor1: .C_17_5_pF,
            tiaCapacitor2: .C_10_pF,
            tiaResistor1: .R_1_MΩ,
            tiaResistor2: .R_25_kΩ
        )
        
        OpticalTimingView(opticalConfiguration: conf)
            .previewLayout(.sizeThatFits)
    }
}
