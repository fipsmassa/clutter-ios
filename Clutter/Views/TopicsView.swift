//
//  CollectionsView.swift
//  Clutter
//
//  Created by Philipp Seibold on 13.07.26.
//

import SwiftUI

struct TopicsView: View {
    
    var topics: [Topic]
    
    var body: some View {
            List {
                ForEach(topics, id: \.id) { topic in
                    NavigationLink(value: topic) {
                        Text(topic.title)
                    }
                }
        }
            .overlay {
                if topics.isEmpty {
                    ContentUnavailableView {
                        Label(Constants.emptyTopicsLabelString, systemImage: Constants.topicsIconString)
                    } description: {
                        Text(Constants.emptyTopicsDescriptionString)
                        } actions: {
                            Button(Constants.addTopicsButtonString) {
                                print("implement create")
                                }
                            }
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
