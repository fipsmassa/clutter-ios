//
//  Home.swift
//  Clutter
//
//  Created by Philipp Seibold on 13.07.26.
//

import SwiftUI

struct HomeView: View {
    let topics: [Topic]
    let dailyLogs: [DailyLog]
    
    func addTopic() {
        print("implement me")
    }
    
    func adddailyLog() {
        print("implement me")
    }
    
    var body: some View {
        List {
            Section(Constants.topicsString) {
                if topics.isEmpty {
                    VStack(spacing: 0) {
                        Text(Constants.emptyTopicsLabelString)
                        Text(Constants.emptyTopicsDescriptionString)
                        Button(action: addTopic, label: {
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
            
            Section(Constants.dailyLogsString) {
                if dailyLogs.isEmpty {
                    VStack(spacing: 0) {
                        Text(Constants.emptyDailyLogsLabelString)
                        Text(Constants.emptyDailyLogsDescriptionString)
                        Button(action: adddailyLog, label: {
                            Text(Constants.addDailyLogsButtonString)
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
        HomeView(topics: SampleData.topics, dailyLogs: SampleData.dailyLogs)
            .navigationTitle(Constants.homeString)
        
    }
}

#Preview("empty state") {
    NavigationStack {
        HomeView(topics: [], dailyLogs: [])
            .navigationTitle(Constants.homeString)
    }
}
