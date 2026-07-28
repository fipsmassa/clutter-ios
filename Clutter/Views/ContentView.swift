//
//  ContentView.swift
//  Clutter
//
//  Created by Philipp Seibold on 13.07.26.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Topic.metadata.createdAt) private var topics: [Topic]
    @Query(sort: \Daily.metadata.createdAt) private var dailies: [Daily]
    @Query private var pools: [Pool]
    @Query(sort: \Bullet.metadata.createdAt) private var bullets: [Bullet]
    @State private var router = TabRouter()
    
    private var pool: Pool? {
        pools.first
    }
    
    var body: some View {
        ZStack {
            VStack {
                TabView(selection: $router.selectedTab) {
                    homeTab
                    topicsTab
                    dailiesTab
                    poolTab
                }
                .environment(router)
                .task {
                    ensurePoolExists()
                }
            }
        }
    }
    
    private func ensurePoolExists() {
        guard pools.isEmpty else { return }
        modelContext.insert(Pool(title: Constants.poolString))
    }
    
    var homeTab: some View {
        NavigationStack(path: $router.homePath) {
            HomeView(topics: topics, dailyLogs: dailies)
                .navigationDestination(for: Topic.self) { topic in
                    TopicDetailView(topic: topic)
                }
                .navigationDestination(for: Daily.self) { daily in
                    DailyDetailView(daily: daily)
                }
                .navigationTitle(Constants.homeString)
                .scrollContentBackground(.hidden)
                .background(Color.yellow)
        }
        .tabItem { Label(Constants.homeString, systemImage: Constants.homeIconString) }
        .tag(TabRouter.Tab.home)
    }
    
    var topicsTab: some View {
        NavigationStack(path: $router.topicPath) {
            TopicsView(topics: topics)
                .navigationDestination(for: Topic.self) { topic in
                    TopicDetailView(topic: topic)
                }
                .navigationTitle(Constants.topicsString)
        }
        .tabItem { Label(Constants.topicsString, systemImage: Constants.topicsIconString) }
        .tag(TabRouter.Tab.collection)
    }
    
    var dailiesTab: some View {
        NavigationStack(path: $router.dailyLogPath) {
            DailiesView(dailies: dailies)
                .navigationDestination(for: Daily.self) { daily in
                    DailyDetailView(daily: daily)
                }
                .navigationTitle(Constants.dailiesString)
        }
        .tabItem { Label(Constants.dailiesString, systemImage: Constants.logsIconString) }
        .tag(TabRouter.Tab.dailyLog)
    }
    
    var poolTab: some View {
        NavigationStack(path: $router.poolPath) {
            if let pool {
                PoolView(pool: pool)
                    .navigationTitle(pool.title)
            } else {
                ProgressView()
            }
        }
        .tabItem { Label(Constants.poolString, systemImage: Constants.poolIconString) }
        .tag(TabRouter.Tab.pool)
    }
    
}

#Preview("With preview container") {
    ContentView()
        .modelContainer(SampleData.previewContainer)
}

#Preview("With own container") {
    ContentView()
}
