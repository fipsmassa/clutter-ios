//
//  AddBulletSheet.swift
//  Clutter
//
//  Created by Philipp Seibold on 23.07.26.
//

import SwiftUI
import SwiftData

struct AddBulletSheet: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var title: String = ""
    @State private var isImportant: Bool = false
    
    var body: some View {
        NavigationStack() {
            Form {
                TextField(Constants.Form.title, text: $title)
                Toggle(Constants.Form.isImportant, isOn: $isImportant)
            }
            .navigationTitle(Constants.addBulletButtonString)
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItemGroup(placement: .topBarLeading) {
                    Button(Constants.Action.cancel) { dismiss() }
                }
                
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button(Constants.Action.add) {
                        let newBullet = Bullet(title: title, isImportant: isImportant)
                        modelContext.insert(newBullet)
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    AddBulletSheet()
}
