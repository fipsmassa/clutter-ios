//
//  SettingsView.swift
//  Clutter
//
//  Created by Philipp Seibold on 13.07.26.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        ZStack {
            Color.blue
                .ignoresSafeArea()
            
            VStack {
                Text("Settings")
                Text("By me a coffee")
                Text("Und sonstige Infos")
            }
        }
    }
}

#Preview {
    SettingsView()
}
