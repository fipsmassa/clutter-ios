//
//  BulletRowView.swift
//  Clutter
//
//  Created by Philipp Seibold on 24.07.26.
//

import SwiftUI

struct BulletRowView: View {
    
    @Bindable var bullet: Bullet
    
    var body: some View {
        HStack {
            Button {
                bullet.isDone.toggle()
            } label: {
                if bullet.isDone {
                    Circle()
                        .stroke(.green, lineWidth: 2)
                        .overlay(alignment: .center) {
                            GeometryReader { geo in
                                VStack {
                                    Circle()
                                        .fill(.green)
                                        .frame(width: geo.size.width*0.7, height: geo.size.height*0.7, alignment: .center)
                                }
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                            }
                        }
                } else {
                    Circle()
                        .stroke(.secondary)
                }
                
            }
            .frame(width: 20, height: 20)
            .buttonStyle(.plain)
            
            if bullet.isImportant {
                Image(systemName: "exclamationmark")
                    .foregroundColor(.red)
            }
            TextField(bullet.title, text: $bullet.title)
                .foregroundColor(bullet.isDone ? .secondary : .primary)
        }
    }
}

#Preview {
    BulletRowView(bullet: SampleData.pool.bullets.first!)
}
