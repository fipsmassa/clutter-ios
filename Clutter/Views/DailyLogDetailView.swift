//
//  DailyLogDetailView.swift
//  Clutter
//
//  Created by Philipp Seibold on 13.07.26.
//

import SwiftUI

struct DailyLogDetailView: View {
    var bullets: [Bullet]
    
    var body: some View {
        List {
            ForEach(bullets, id: \.id) { bullet in
                Text(bullet.title)
            }
        }
    }
}

#Preview {
    NavigationStack {
        DailyLogDetailView(bullets: SampleData.dailyLogs[0].bullets)
            .navigationTitle("TODO: date comes here")
    }
}
