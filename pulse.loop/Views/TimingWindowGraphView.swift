//
//  TimingWindowGraphView.swift
//  pulse.loop
//
//  Created by Riccardo Persello on 03/11/22.
//

import SwiftUI

struct TimingWindowGraphView<OpticalWindowConfiguration: TimingWindowProtocol>: View {
    @Binding var windowConfiguration: OpticalWindowConfiguration
    var ledColors: [Color] = [.blue.opacity(0.75), .green.opacity(0.75), .red.opacity(0.75), .gray.opacity(0.75)]
    
    @State var lastScaleValue: CGFloat = 1
    @State var scale: CGFloat = 1
    
    var body: some View {
        VStack(alignment: .leading) {
            GeometryReader { geometry in
                ScrollView(.horizontal) {
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
                        let dynamicPowerDownPath = rectangleForInterval(from: windowConfiguration.dynamicPowerDown.start.value,
                                                                        to: windowConfiguration.dynamicPowerDown.end.value)
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
                            let band = rectangleForInterval(from: .zero, to: windowConfiguration.dynamicPowerDown.start.value, band: i)
                            context.fill(band, with: .color(colors[i]))
                        }
                        
                        // Overlay indicators: lighting
                        let lightingTuples = [
                            (0, 0),
                            (windowConfiguration.LED1Phase.led_st.value, windowConfiguration.LED1Phase.led_end.value),
                            (windowConfiguration.LED2Phase.led_st.value, windowConfiguration.LED2Phase.led_end.value),
                            (windowConfiguration.LED3Phase.led_st.value, windowConfiguration.LED3Phase.led_end.value)
                        ]
                        
                        for tuple in lightingTuples.enumerated() {
                            let rect = rectangleForInterval(from: tuple.element.0, to: tuple.element.1, band: 0)
                            context.fill(rect, with: .color(ledColors[tuple.offset]))
                        }
                        
                        // Overlay indicators: sampling
                        let samplingTuples = [
                            (windowConfiguration.ambientPhase.sample_st.value, windowConfiguration.ambientPhase.sample_end.value),
                            (windowConfiguration.LED1Phase.sample_st.value, windowConfiguration.LED1Phase.sample_end.value),
                            (windowConfiguration.LED2Phase.sample_st.value, windowConfiguration.LED2Phase.sample_end.value),
                            (windowConfiguration.LED3Phase.sample_st.value, windowConfiguration.LED3Phase.sample_end.value)
                        ]
                        
                        for tuple in samplingTuples.enumerated() {
                            let rect = rectangleForInterval(from: tuple.element.0, to: tuple.element.1, band: 1)
                            context.fill(rect, with: .color(ledColors[tuple.offset]))
                        }
                        
                        // Overlay indicators: conversion
                        let conversionTuples = [
                            (windowConfiguration.ambientPhase.conv_st.value, windowConfiguration.ambientPhase.conv_end.value),
                            (windowConfiguration.LED1Phase.conv_st.value, windowConfiguration.LED1Phase.conv_end.value),
                            (windowConfiguration.LED2Phase.conv_st.value, windowConfiguration.LED2Phase.conv_end.value),
                            (windowConfiguration.LED3Phase.conv_st.value, windowConfiguration.LED3Phase.conv_end.value)
                        ]
                        
                        for tuple in conversionTuples.enumerated() {
                            let rect = rectangleForInterval(from: tuple.element.0, to: tuple.element.1, band: 2)
                            context.fill(rect, with: .color(ledColors[tuple.offset]))
                        }
                        
                        // Overlay indicators: reset
                        let resetTuples = [
                            (windowConfiguration.ambientPhase.reset_st.value, windowConfiguration.ambientPhase.reset_end.value),
                            (windowConfiguration.LED1Phase.reset_st.value, windowConfiguration.LED1Phase.reset_end.value),
                            (windowConfiguration.LED2Phase.reset_st.value, windowConfiguration.LED2Phase.reset_end.value),
                            (windowConfiguration.LED3Phase.reset_st.value, windowConfiguration.LED3Phase.reset_end.value)
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
                    .drawingGroup()
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
                    //.backgroundStyle(.thinMaterial)
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

struct TimingWindowGraphView_Previews: PreviewProvider {
    static var previews: some View {
        let conf = FakeTimingWindow()
        
        TimingWindowGraphView(windowConfiguration: .constant(conf))
            .previewLayout(.sizeThatFits)
    }
}
