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
    var status: BulletStatus
    var isImportant: Bool
    var metadata: Metadata
 
    init(
        id: UUID = UUID(),
        title: String,
        status: BulletStatus = .undone,
        isImportant: Bool = false,
        metadata: Metadata = Metadata()
    ) {
        self.id = id
        self.title = title
        self.status = status
        self.isImportant = isImportant
        self.metadata = metadata
    }
}

enum BulletStatus: String, Codable, CaseIterable {
    case undone
    case done
}
