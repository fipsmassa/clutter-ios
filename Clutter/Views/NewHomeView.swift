//
//  NewHomeView.swift
//  Clutter
//
//  Created by Philipp Seibold on 10.08.26.
//

import SwiftUI

struct NewHomeView: View {
    var body: some View {
        ScrollView {
            VStack {
                Rectangle()
                    .fill(Color.blue)
                    .frame(height: 300)
                
                Rectangle()
                    .fill(Color.blue)
                    .frame(height: 300)
                
                Rectangle()
                    .fill(Color.blue)
                    .frame(height: 300)
            }
        }
    }
}

#Preview {
    NewHomeView()
}
