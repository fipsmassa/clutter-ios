//
//  DailyLogsView.swift
//  Clutter
//
//  Created by Philipp Seibold on 13.07.26.
//

import SwiftUI
import SwiftData

struct DailiesView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var isAddButtonDisabled: Bool = false
    
    var dailies: [Daily]
    
    func addDaily() {
        let newDaily = Daily(title: Date().formatted(date: .complete, time: .omitted))
        modelContext.insert(newDaily)
        isAddButtonDisabled = true
    }
    
    func checkIfDailyAlreadyExists() -> Void {
        if dailies.last?.title ==  Date().formatted(date: .complete, time: .omitted) {
            isAddButtonDisabled = true
        } else {
            isAddButtonDisabled = false
        }
    }
    
    var body: some View {
        DailyList()
        .scrollContentBackground(.hidden)
        .background(Color.brown.secondary)
        .toolbar {
            if !dailies.isEmpty {
                Button(Constants.addDailiesButtonString, systemImage: Constants.plusIconString) {
                    addDaily()
                }.disabled(isAddButtonDisabled)
            }
        }
        .overlay {
            if dailies.isEmpty {
                ContentUnavailableView {
                    Label(Constants.emptyDailiesLabelString, systemImage: Constants.logsIconString)
                } description: {
                    Text(Constants.emptyDailiesDescriptionString)
                } actions: {
                    Button(Constants.addDailiesButtonString) {
                        addDaily()
                    }
                }
                .offset(y: -60)
            }
        }
        .onAppear {
            checkIfDailyAlreadyExists()
        }
    }
}

#Preview("with data") {
    NavigationStack {
        DailiesView(dailies: SampleData.dailies)
            .modelContainer(SampleData.previewContainer)
            .navigationTitle(Constants.dailiesString)
    }
}

#Preview("empty state") {
    NavigationStack {
        DailiesView(dailies: [])
            .navigationTitle(Constants.dailiesString)
    }
}
