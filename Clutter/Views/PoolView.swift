//
//  PoolView.swift
//  Clutter
//
//  Created by Philipp Seibold on 13.07.26.
//

import SwiftUI
import SwiftData

struct PoolView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var showAddBulletSheet: Bool = false
    @Bindable var pool: Pool
    
    var body: some View {
        List {
            ForEach(pool.bullets, id: \.id) { bullet in
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
        .toolbar {
            if !pool.bullets.isEmpty {
                Button(Constants.addBulletButtonString, systemImage: Constants.plusIconString) {
                    showAddBulletSheet = true
                }
            }
        }
        .sheet(isPresented: $showAddBulletSheet) {
            AddBulletSheet { title, isImportant in
                let newBullet = Bullet(title: title, isImportant: isImportant)
                modelContext.insert(newBullet)
                pool.bullets.append(newBullet)
            }
            .presentationDetents([.medium])
            .presentationDragIndicator(.visible)
        }
        .overlay {
            if pool.bullets.isEmpty {
                ContentUnavailableView {
                    Label(Constants.emptyBulletsLabelString, systemImage: Constants.poolIconString)
                } description: {
                    Text(Constants.emptyPoolDescriptionString)
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
        PoolView(pool: SampleData.pool)
            .navigationTitle(Constants.poolString)
    }
}

#Preview("empty state") {
    NavigationStack {
        PoolView(pool: SampleData.emptyPool)
            .navigationTitle(Constants.poolString)
    }
}
