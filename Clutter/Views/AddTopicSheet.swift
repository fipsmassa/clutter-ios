//
//  AddTopicSheet.swift
//  Clutter
//
//  Created by Philipp Seibold on 22.07.26.
//

import SwiftUI
import SwiftData

struct AddTopicSheet: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var title: String = ""
    @State private var isFavorite: Bool = false
    
    var body: some View {
        NavigationStack() {
            Form {
                TextField(Constants.Form.title, text: $title)
                Toggle(Constants.Form.isFavorite, isOn: $isFavorite)
            }
            .navigationTitle(Constants.addTopicsButtonString)
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItemGroup(placement: .topBarLeading) {
                    Button(Constants.Action.cancel) { dismiss() }
                }
                
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button(Constants.Action.add) {
                        print(title)
                        let newTopic = Topic(title: title, isFavorite: isFavorite)
                        modelContext.insert(newTopic)
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    AddTopicSheet()
}
