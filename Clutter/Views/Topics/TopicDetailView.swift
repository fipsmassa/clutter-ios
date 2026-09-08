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
        bulletList
        .navigationTitle(topic.title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            if !topic.bullets.isEmpty {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(Constants.Action.favorite, systemImage: Constants.heartIconString) {
                        topic.isFavorite.toggle()
                    }
                    .tint(topic.isFavorite ? .red : .primary)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(Constants.addBulletButtonString, systemImage: Constants.plusIconString) {
                        showAddBulletSheet = true
                    }
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
                emptyStateOverlay
            }
        }
    }
    
    private var bulletList: some View {
        List {
            ForEach(topic.bullets, id: \.id) { bullet in
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
    
    private var emptyStateOverlay: some View {
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
