//
//  Bullet.swift
//  Clutter
//
//  Created by Philipp Seibold on 16.07.26.
//

import SwiftData
import Foundation
 
@Model
class Bullet {
    @Attribute(.unique) var id: UUID
    var title: String
    var isDone: Bool
    var isImportant: Bool
    var metadata: Metadata
 
    init(
        title: String,
        isImportant: Bool = false,
    ) {
        self.id = UUID()
        self.title = title
        self.isDone = false
        self.isImportant = isImportant
        self.metadata = Metadata(createdAt: Date())
    }
}
