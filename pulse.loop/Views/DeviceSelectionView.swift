//
//  DeviceSelectionView.swift
//  pulse.loop
//
//  Created by Riccardo Persello on 05/11/22.
//

import SwiftUI

struct DeviceSelectionView: View {
    var body: some View {
        List {
            
        }
        .navigationTitle("Devices")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct DeviceSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            DeviceSelectionView()
        }
        .previewLayout(.fixed(width: 360, height: 480))
    }
}
