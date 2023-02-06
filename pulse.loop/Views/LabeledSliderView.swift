//
//  LabeledSliderView.swift
//  pulse.loop
//
//  Created by Riccardo Persello on 29/12/22.
//

import SwiftUI

struct LabeledSliderView<Value, Label>: View
where Value: BinaryFloatingPoint, Value.Stride: BinaryFloatingPoint, Label: View {

    @Binding var value: Value
    let range: ClosedRange<Value>
    let label: Label

    init(value: Binding<Value>, in range: ClosedRange<Value> = 0...1, label: () -> Label = { EmptyView() }) {
        self._value = value
        self.range = range
        self.label = label()
    }

    var body: some View {
        #if os(iOS)
        HStack {
            self.label
            Spacer()
            Slider(value: $value, in: range)
                .frame(maxWidth: 400)
        }
        #elseif os(macOS)
        Slider(value: $value, in: range) {
            self.label
        }
        #endif
    }
}

struct LabeledSliderViewpreviews: PreviewProvider {
    static var previews: some View {
        LabeledSliderView(value: .constant(0.5), in: 0...3) {
            Text("Label")
        }
    }
}
