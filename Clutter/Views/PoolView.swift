//
//  PoolView.swift
//  Clutter
//
//  Created by Philipp Seibold on 13.07.26.
//

import SwiftUI

struct PoolView: View {
    var bullets: [Bullet]
    
    var body: some View {
        List {
            ForEach(bullets, id: \.id) { bullet in
                Text(bullet.title)
            }
        }
        .overlay {
            if bullets.isEmpty {
                ContentUnavailableView {
                    Label(Constants.emptyPoolLabelString, systemImage: Constants.poolIconString)
                } description: {
                    Text(Constants.emptyPoolDescriptionString)
                    } actions: {
                        Button(Constants.addPoolButtonString) {
                            print("implement create")
                            }
                        }
            }
        }
    }
}

#Preview("with data") {
    NavigationStack {
        PoolView(bullets: SampleData.pool.bullets)
            .navigationTitle(Constants.poolString)
    }
}

#Preview("empty state") {
    NavigationStack {
        PoolView(bullets: [])
            .navigationTitle(Constants.poolString)
    }
}
