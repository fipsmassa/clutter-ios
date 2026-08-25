//
//  Collection.swift
//  Clutter
//
//  Created by Philipp Seibold on 13.07.26.
//

import SwiftData
import Foundation

@Model
class Topic {
    @Attribute(.unique) var id: UUID
    var title: String
    var status: ItemStatus
    var isFavorite: Bool
    var metadata: Metadata
    
    // .cascade: löscht man ein Topic, werden auch alle zugehörigen
    // Bullets automatisch mitgelöscht (statt als "Waisen" in der DB
    // zurückzubleiben).
    @Relationship(deleteRule: .cascade) var bullets: [Bullet]
    
    init(
        title: String,
        status: ItemStatus = .active,
        isFavorite: Bool = false,
        bullets: [Bullet] = [],
    ) {
        self.id = UUID()
        self.title = title
        self.status = status
        self.isFavorite = isFavorite
        self.bullets = bullets
        self.metadata = Metadata(createdAt: Date())
    }
    
    var isFavoriteSort: UInt8 {
        isFavorite ? 1 : 0
    }
}
