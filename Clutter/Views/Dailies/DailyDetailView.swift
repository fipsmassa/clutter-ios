//
//  DailyLogDetailView.swift
//  Clutter
//
//  Created by Philipp Seibold on 13.07.26.
//

import SwiftUI
import SwiftData

struct DailyDetailView: View {
    @Environment(\.modelContext) private var modelContext
    @Bindable var daily: Daily
    @State private var showAddBulletSheet: Bool = false
    
    var body: some View {
        bulletList
        .navigationTitle(daily.title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            if !daily.bullets.isEmpty {
                Button(Constants.addBulletButtonString, systemImage: Constants.plusIconString) {
                    showAddBulletSheet = true
                }
            }
        }
        .sheet(isPresented: $showAddBulletSheet) {
            AddBulletSheet { title, isImportant in
                let newBullet = Bullet(title: title, isImportant: isImportant)
                modelContext.insert(newBullet)
                daily.bullets.append(newBullet)
            }
            .presentationDetents([.medium])
            .presentationDragIndicator(.visible)
        }
        .overlay {
            if daily.bullets.isEmpty {
                ContentUnavailableView {
                    Label(Constants.emptyBulletsLabelString, systemImage: Constants.bulletIconString)
                } description: {
                    Text(Constants.emptyBulletsDescriptionString)
                } actions: {
                    Button(Constants.addBulletButtonString) {
                        showAddBulletSheet = true
                    }
                }
                .offset(y: -60)
            }
        }
    }
    
    private var bulletList: some View {
        List {
            ForEach(daily.bullets, id: \.id) { bullet in
                @Bindable var bullet = bullet
                BulletRowView(bullet: bullet)
                
                    .swipeActions(edge: .leading) {
                        Button(bullet.isImportant ? Constants.Action.notImportant : Constants.Action.important, systemImage: Constants.exclamationmarkIconString) {
                            bullet.isImportant.toggle()
                        }
                        .tint(.yellow)
                    }
                    .swipeActions {
                        Button(Constants.Action.delete, systemImage: Constants.trashIconString) {
                            modelContext.delete(bullet)
                        }
                        .tint(.red)
                    }
            }
        }
        .scrollContentBackground(.hidden)
        .background(Color.brown.secondary)
    }
}

#Preview("with data") {
    NavigationStack {
        DailyDetailView(daily: SampleData.dailies[0])
    }
}

#Preview("empty state") {
    NavigationStack {
        DailyDetailView(daily: SampleData.dailies[2])
    }
}
