//
//  Home.swift
//  Clutter
//
//  Created by Philipp Seibold on 13.07.26.
//

import SwiftUI

struct HomeView: View {
    @Environment(TabRouter.self) private var router

    let topics: [Topic]
    let dailyLogs: [Daily]
    
    func navigateToTopicsView() {
        router.selectedTab = .collection
    }
    
    func navigateToDailiesView() {
        router.selectedTab = .dailyLog
    }
    
    var body: some View {
        List {
            Section(Constants.topicsString) {
                if topics.isEmpty {
                    VStack(spacing: 0) {
                        Text(Constants.emptyTopicsLabelString)
                        Text(Constants.emptyTopicsDescriptionString)
                        Button(action: navigateToTopicsView, label: {
                            Text(Constants.addTopicsButtonString)
                        })
                    }
                } else {
                    ForEach(topics, id: \.id) { topic in
                        NavigationLink(value: topic) {
                            Text(topic.title)
                        }
                    }
                }
            }
            
            Section(Constants.dailiesString) {
                if dailyLogs.isEmpty {
                    VStack(spacing: 0) {
                        Text(Constants.emptyDailiesLabelString)
                        Text(Constants.emptyDailiesDescriptionString)
                        Button(action: navigateToDailiesView, label: {
                            Text(Constants.addDailiesButtonString)
                        })
                    }
                } else {
                    ForEach(dailyLogs, id: \.id) { dailyLogItem in
                        NavigationLink(value: dailyLogItem) {
                            Text(dailyLogItem.title)
                        }
                    }
                }
            }
        }

    }
}

#Preview("with data") {
    NavigationStack {
        HomeView(topics: SampleData.topics, dailyLogs: SampleData.dailies)
            .navigationTitle(Constants.homeString)
    }
    .environment(TabRouter())
}

#Preview("empty state") {
    NavigationStack {
        HomeView(topics: [], dailyLogs: [])
            .navigationTitle(Constants.homeString)
    }
    .environment(TabRouter())
}
