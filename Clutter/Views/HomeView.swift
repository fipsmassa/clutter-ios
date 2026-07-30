//
//  Home.swift
//  Clutter
//
//  Created by Philipp Seibold on 13.07.26.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @Environment(TabRouter.self) private var router
    @Query(sort: \Topic.metadata.createdAt) private var topics: [Topic]
    
    let dailyLogs: [Daily]
    
    func navigateToTopicsView() {
        router.selectedTab = .collection
    }
    
    func navigateToDailiesView() {
        router.selectedTab = .dailyLog
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(Constants.topicsString)
                .font(.headline)
                .padding(.top)
                .padding(.leading, 20)
            
            if topics.isEmpty {
                VStack(spacing: 0) {
                    Text(Constants.emptyTopicsLabelString)
                    Text(Constants.emptyTopicsDescriptionString)
                    Button(action: navigateToTopicsView, label: {
                        Text(Constants.addTopicsButtonString)
                    })
                }
            } else {
                TopicList()
            }
            
            
            List {
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
        .scrollContentBackground(.hidden)
        .background(Color.brown.secondary)
    }
}

#Preview("with data") {
    NavigationStack {
        HomeView(dailyLogs: SampleData.dailies)
            .modelContainer(SampleData.previewContainer)
            .navigationTitle(Constants.homeString)
    }
    .environment(TabRouter())
}

#Preview("empty state") {
    NavigationStack {
        HomeView(dailyLogs: [])
            .navigationTitle(Constants.homeString)
    }
    .environment(TabRouter())
}
