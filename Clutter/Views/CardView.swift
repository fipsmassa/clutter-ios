//
//  SwiftUIView.swift
//  Clutter
//
//  Created by Philipp Seibold on 25.08.26.
//

import SwiftUI

struct CardView: View {
    let title: String
    let content: String
    let icon: String
    let fav: Bool
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .fill(LinearGradient(
                    colors: [fav ? Color.orange.opacity(0.5) : Color.cyan.opacity(0.5), fav ? Color.yellow.opacity(0.5) : Color.indigo.opacity(0.5)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ).shadow(.drop(radius: 10, x: 0, y: 0)))
            
            Image(systemName: icon)
                .font(.title2)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .padding()

            Text(content)
                .font(.title2)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                .padding()

            Text(title)
                .font(.headline)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
                .padding()
        }
        .frame(width: 180, height: 100, alignment: .center)
    }
}

#Preview {
    ScrollView {
        LazyVGrid(columns: [GridItem(),
                            GridItem()], spacing: 24) {
            ForEach(1...50, id: \.self) { item in
                CardView(title: "some title", content: "0 / 7", icon: "star", fav: false)
            }
        }
    }
    .background(Color.brown.secondary)
    
    
}
