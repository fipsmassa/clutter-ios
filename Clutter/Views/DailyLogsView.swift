//
//  DailyLogsView.swift
//  Clutter
//
//  Created by Philipp Seibold on 13.07.26.
//

import SwiftUI

struct DailyLogsView: View {
    var dailyLogs: [DailyLog]
    
    var body: some View {
        List {
            ForEach(dailyLogs, id: \.id) { dailyLog in
                NavigationLink(value: dailyLog) {
                    Text(dailyLog.title)
                }
            }
        }
        .overlay {
            if dailyLogs.isEmpty {
                ContentUnavailableView {
                    Label(Constants.emptyDailyLogsLabelString, systemImage: Constants.dailyLogsIconString)
                } description: {
                    Text(Constants.emptyDailyLogsDescriptionString)
                    } actions: {
                        Button(Constants.addDailyLogsButtonString) {
                            print("implement create")
                            }
                        }
            }
        }
    }
}

#Preview("with data") {
    NavigationStack {
        DailyLogsView(dailyLogs: SampleData.dailyLogs)
            .navigationTitle(Constants.dailyLogsString)
    }
}

#Preview("empty state") {
    NavigationStack {
        DailyLogsView(dailyLogs: [])
            .navigationTitle(Constants.dailyLogsString)
    }
}
