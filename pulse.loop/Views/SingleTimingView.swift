//
//  SingleTimingView.swift
//  pulse.loop
//
//  Created by Riccardo Persello on 10/11/22.
//

import SwiftUI


struct SingleTimingView: View {
    var name: String
    @Binding var start: TimeInterval
    @Binding var end: TimeInterval
    
    var body: some View {
#if os(macOS)
        Group {
            TextField("\(name) start",
                      value: $start,
                      formatter: TimeInterval.microsecondsFormatter)
            
            
            TextField("\(name) end",
                      value: $end,
                      formatter: TimeInterval.microsecondsFormatter)
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
