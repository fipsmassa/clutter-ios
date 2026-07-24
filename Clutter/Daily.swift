//
//  DailyLog.swift
//  Clutter
//
//  Created by Philipp Seibold on 16.07.26.
//

import SwiftData
import Foundation
 
@Model
class Daily {
    @Attribute(.unique) var id: UUID
    var title: String
    var date: Date
    var status: ContainerStatus
    var isFavorite: Bool
    var metadata: Metadata
 
    @Relationship(deleteRule: .cascade) var bullets: [Bullet]
 
    init(
        id: UUID = UUID(),
        title: String,
        date: Date = .now,
        status: ContainerStatus = .active,
        isFavorite: Bool = false,
        bullets: [Bullet] = [],
        metadata: Metadata = Metadata()
    ) {
        self.id = id
        self.title = title
        self.date = date
        self.status = status
        self.isFavorite = isFavorite
        self.bullets = bullets
        self.metadata = metadata
    }
}
