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

    var body: some View {
        List {
            ForEach(topics, id: \.id) { topic in
                NavigationLink(value: topic) {
                    Text(topic.title)
                }
            }
            .onDelete { indexSet in
                    for index in indexSet {
                        modelContext.delete(topics[index])
                }
            }
        }
        .toolbar {
            if !topics.isEmpty {
                Button(Constants.addTopicsButtonString, systemImage: Constants.plusIconString) {
                    showAddTopicSheet = true
                }
            }
        }
        .sheet(isPresented: $showAddTopicSheet) {
            AddTopicSheet()
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
