//
//  Pool.swift
//  Clutter
//
//  Created by Philipp Seibold on 16.07.26.
//

import SwiftData
import Foundation
 
@Model
class Pool {
    @Attribute(.unique) var id: UUID
    @Attribute(.unique) private var singletonKey: String
    var title: String
    var status: ItemStatus
    var isFavorite: Bool
    var metadata: Metadata
 
    @Relationship(deleteRule: .cascade) var bullets: [Bullet]
 
    init(
        id: UUID = UUID(),
        title: String,
        status: ItemStatus = .active,
        isFavorite: Bool = false,
        bullets: [Bullet] = [],
        metadata: Metadata = Metadata()
    ) {
        self.id = id
        self.singletonKey = "the-one-and-only-pool"
        self.title = title
        self.status = status
        self.isFavorite = isFavorite
        self.bullets = bullets
        self.metadata = metadata
    }
}
