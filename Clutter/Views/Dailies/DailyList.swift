//
//  DailyList.swift
//  Clutter
//
//  Created by Philipp Seibold on 30.07.26.
//

import SwiftUI
import SwiftData

struct DailyList: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Daily.metadata.createdAt) private var dailies: [Daily]
    
    var body: some View {
        List {
            ForEach(dailies) { daily in
                NavigationLink(value: daily) {
                    Text(daily.title)
                }
            }
            .onDelete { indexSet in
                for index in indexSet {
                    modelContext.delete(dailies[index])
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        DailyList().modelContainer(SampleData.previewContainer)
    }
}
