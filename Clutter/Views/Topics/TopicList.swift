//
//  TopicList.swift
//  Clutter
//
//  Created by Philipp Seibold on 30.07.26.
//

import SwiftUI
import SwiftData

struct TopicList: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Topic.metadata.createdAt) private var topics: [Topic]
    
    func delete(_ topic: Topic) {
        modelContext.delete(topic)
    }
    
    func toggleIsFavorite(_ topic: Topic) {
        topic.isFavorite.toggle()
    }
    
    var body: some View {
        List {
            ForEach(topics) { topic in
                @Bindable var topic = topic
                
                NavigationLink(value: topic) {
                    HStack {
                        topic.isFavorite ? Image(systemName: Constants.starIconString).foregroundColor(.yellow) : nil
                        Text(topic.title)
                    }
                }
                .swipeActions(edge: .leading) {
                    Button(topic.isFavorite ? Constants.Action.notFavorite : Constants.Action.favorite, systemImage: Constants.starIconString) {
                        toggleIsFavorite(topic)
                    }
                    .tint(.yellow)
                }
                .swipeActions {
                    Button(Constants.Action.delete, systemImage: Constants.trashIconString) {
                        delete(topic)
                    }
                    .tint(.red)
                }
            }
        }
    }
    
    
}

#Preview("with data") {
    NavigationStack {
        TopicList().modelContainer(SampleData.previewContainer)
    }
}

#Preview("empty state") {
    NavigationStack {
        TopicList()
    }
}
