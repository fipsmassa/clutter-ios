//
//  CollectionsView.swift
//  Clutter
//
//  Created by Philipp Seibold on 13.07.26.
//

import SwiftUI
import SwiftData

struct TopicsView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var showAddTopicSheet: Bool = false
    var topics: [Topic]
    
    func delete(_ topic: Topic) {
        modelContext.delete(topic)
    }
    
    func toggleIsFavorite(_ topic: Topic) {
        topic.isFavorite.toggle()
    }
    
    var body: some View {
        VStack {
            topicList
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    if !topics.isEmpty {
                        Button(Constants.addTopicsButtonString, systemImage: Constants.plusIconString) {
                            showAddTopicSheet = true
                        }
                    }
                }

                
            }
            .sheet(isPresented: $showAddTopicSheet) {
                AddTopicSheet { title, isFavorite in
                    let newTopic = Topic(title: title, isFavorite: isFavorite)
                    modelContext.insert(newTopic)
                }
                .presentationDetents([.medium])
                .presentationDragIndicator(.visible)
            }
            .overlay {
                if topics.isEmpty {
                    ContentUnavailableView {
                        Label(Constants.emptyTopicsLabelString, systemImage: Constants.topicsIconString)
                    } description: {
                        Text(Constants.emptyTopicsDescriptionString)
                    } actions: {
                        Button(Constants.addTopicsButtonString) {
                            showAddTopicSheet = true
                        }
                    }
                    .offset(y: -60)
                }
            }
        }
    }
    
    private var topicList: some View {
        List {
            ForEach(topics, id: \.id) { topic in
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
        .scrollContentBackground(.hidden)
        .background(Color.brown.secondary)
    }
}

#Preview("with data") {
    NavigationStack {
        TopicsView(topics: SampleData.topics)
            .navigationTitle(Constants.topicsString)
    }
}

#Preview("empty state") {
    NavigationStack {
        TopicsView(topics: [])
            .navigationTitle(Constants.topicsString)
    }
}
