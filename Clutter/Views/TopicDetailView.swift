//
//  CollectionDetail.swift
//  Clutter
//
//  Created by Philipp Seibold on 13.07.26.
//

import SwiftUI

struct TopicDetailView: View {
    var bullets: [Bullet]
    
    var body: some View {
        ForEach(bullets, id: \.id) { bullet in
            Text(bullet.title)
        }
 
    }
}

#Preview {
    NavigationStack {
        TopicDetailView(bullets: SampleData.topics[0].bullets)
            .navigationTitle("TODO: topic title comes here")
    }
}
