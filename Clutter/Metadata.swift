//
//  Metadata.swift
//  Clutter
//
//  Created by Philipp Seibold on 20.07.26.
//

import Foundation

struct Metadata: Codable, Hashable {
    var createdAt: Date
    var updatedAt: Date?
    var deletedAt: Date?
 
    init(createdAt: Date = .now, updatedAt: Date? = nil, deletedAt: Date? = nil) {
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.deletedAt = deletedAt
    }
 
    /// Aktualisiert den "zuletzt geändert"-Zeitstempel auf jetzt.
    mutating func touch() {
        updatedAt = .now
    }
 
    /// Markiert das Objekt als gelöscht (Soft Delete) statt es
    /// physisch aus der Datenbank zu entfernen.
    mutating func markDeleted() {
        deletedAt = .now
    }
 
    var isDeleted: Bool {
        deletedAt != nil
    }
}
