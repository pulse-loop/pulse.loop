//
//  SingleTimingView.swift
//  pulse.loop
//
//  Created by Riccardo Persello on 10/11/22.
//

import SwiftUI


struct SingleTimingView: View {
    var name: String
    @Binding var start: Float32
    @Binding var end: Float32
    
    var body: some View {
#if os(macOS)
        Group {
            TextField("\(name) start",
                      value: $start,
                      formatter: Float32.microsecondsFormatter)
            
            
            TextField("\(name) end",
                      value: $end,
                      formatter: Float32.microsecondsFormatter)
        }
#elseif os(iOS)
        HStack {
            Text("\(name) start")
            TextField(name, value: $start, formatter: TimeInterval.microsecondsFormatter)
                .multilineTextAlignment(.trailing)
                .foregroundColor(.gray)
        }
        
        HStack {
            Text("\(name) end")
            TextField(name, value: $end, formatter: TimeInterval.microsecondsFormatter)
                .multilineTextAlignment(.trailing)
                .foregroundColor(.gray)
        }
#endif
    }
}

struct SingleTimingView_Previews: PreviewProvider {
    static var previews: some View {
        SingleTimingView(name: "Window", start: .constant(10.3), end: .constant(24.5))
    }
}
