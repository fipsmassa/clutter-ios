//
//  Home.swift
//  Clutter
//
//  Created by Philipp Seibold on 13.07.26.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    let activeStatus = ItemStatus.active
    
    @Environment(TabRouter.self) private var router
    @Query(filter: #Predicate<Topic> { topic in
        topic.isFavorite
    }, sort: \Topic.metadata.createdAt) private var favTopics: [Topic]
    @Query(filter: #Predicate<Topic> { topic in
        !topic.isFavorite
    }, sort: \Topic.metadata.createdAt) private var nonFavTopics: [Topic]
    
    let dailyLogs: [Daily]
    
    func navigateToTopicsView() {
        router.selectedTab = .collection
    }
    
    func navigateToDailiesView() {
        router.selectedTab = .dailyLog
    }
    
    var body: some View {
        VStack() {
            
            if favTopics.isEmpty {
                VStack(spacing: 0) {
                    Text(Constants.emptyTopicsLabelString)
                    Text(Constants.emptyTopicsDescriptionString)
                    Button(action: navigateToTopicsView, label: {
                        Text(Constants.addTopicsButtonString)
                    })
                }
            } else {
                LazyVGrid(columns: [GridItem(),
                                    GridItem()], spacing: 24) {
                    ForEach(favTopics) { topic in
                        let doneBullets = topic.bullets.filter(\.self.isDone)
                        
                        CardView(title: topic.title, content: "\(doneBullets.count) / \(topic.bullets.count)", icon: Constants.starIconString, fav: true)
                        
                    }
                    
                    ForEach(nonFavTopics) { topic in
                        let doneBullets = topic.bullets.filter(\.self.isDone)
                        
                        CardView(title: topic.title, content: "\(doneBullets.count) / \(topic.bullets.count)", icon: "star", fav: false)
                    }
                }
                                    .padding()
            
                
            }
            
            
            
            VStack(alignment: .leading) {
                if dailyLogs.isEmpty {
                    VStack(spacing: 0) {
                        Text(Constants.emptyDailiesLabelString)
                        Text(Constants.emptyDailiesDescriptionString)
                        Button(action: navigateToDailiesView, label: {
                            Text(Constants.addDailiesButtonString)
                        })
                    }
                } else {
                    DailyList()
                        .contentMargins(.top, 0)
                }
            }
            .padding(.top, 20)
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
