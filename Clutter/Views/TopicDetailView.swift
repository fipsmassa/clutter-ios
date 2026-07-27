//
//  CollectionDetail.swift
//  Clutter
//
//  Created by Philipp Seibold on 13.07.26.
//

import SwiftUI
import SwiftData

struct TopicDetailView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var showAddBulletSheet: Bool = false
    @Bindable var topic: Topic
    
    var body: some View {
        List {
            ForEach(topic.bullets, id: \.id) { bullet in
                @Bindable var bullet = bullet
                BulletRowView(bullet: bullet)
                
                    .swipeActions(edge: .leading) {
                        Button(bullet.isImportant ? Constants.Action.notImportant : Constants.Action.important) {
                            bullet.isImportant.toggle()
                        }
                        .tint(.yellow)
                    }
                    .swipeActions {
                        Button(Constants.Action.delete) {
                            modelContext.delete(bullet)
                        }
                        .tint(.red)
                    }
            }
        }
        .navigationTitle(topic.title)
        .toolbar {
            if !topic.bullets.isEmpty {
                Button(Constants.addBulletButtonString, systemImage: Constants.plusIconString) {
                    showAddBulletSheet = true
                }
            }
        }
        .sheet(isPresented: $showAddBulletSheet) {
            AddBulletSheet { title, isImportant in
                let newBullet = Bullet(title: title, isImportant: isImportant)
                modelContext.insert(newBullet)
                topic.bullets.append(newBullet)
            }
            .presentationDetents([.medium])
            .presentationDragIndicator(.visible)
        }
        .overlay {
            if topic.bullets.isEmpty {
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
}

#Preview("with data") {
    NavigationStack {
        TopicDetailView(topic: SampleData.topics[0])
    }
}

#Preview("empty state") {
    NavigationStack {
        TopicDetailView(topic: SampleData.topics[1])
    }
}
