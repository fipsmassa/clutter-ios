//
//  SampleData.swift
//  Clutter
//
//  Created by Philipp Seibold on 21.07.26.
//

import SwiftData
import Foundation
 
enum SampleData {
 
    // MARK: - Bullet Seeds
    //
    // Kleiner Hilfstyp, damit man beim Erstellen der Testdaten nicht jedes
    // Mal den vollen Bullet-Initializer ausschreiben muss. Die statischen
    // Factory-Methoden `.undone(...)` / `.done(...)` machen die Sample-Listen
    // unten gut lesbar (siehe Verwendung weiter unten).
 
    struct BulletSeed {
        let title: String
        let isDone: Bool
        let isImportant: Bool
 
        static func undone(_ title: String, important: Bool = false) -> BulletSeed {
            BulletSeed(title: title, isDone: false, isImportant: important)
        }
 
        static func done(_ title: String, important: Bool = false) -> BulletSeed {
            BulletSeed(title: title, isDone: true, isImportant: important)
        }
    }
 
    static func makeBullets(_ seeds: [BulletSeed]) -> [Bullet] {
        seeds.map { Bullet(title: $0.title, isImportant: $0.isImportant) }
    }
 
    // MARK: - Topics
 
    static let topics: [Topic] = [
        Topic(
            title: "Wohnungsrenovierung",
            status: .active,
            isFavorite: true,
            bullets: makeBullets([
                .done("Farbe für Wohnzimmer aussuchen"),
                .undone("Handwerker für Bad anfragen", important: true),
                .undone("Budget mit Partner besprechen"),
                .done("Alte Tapete entfernen")
            ])
        ),
        Topic(
            title: "Hochzeitsplanung",
            status: .active,
            isFavorite: true,
            bullets: []
        ),
        Topic(
            title: "Marathon-Training",
            status: .active,
            bullets: makeBullets([
                .done("Laufschuhe testen"),
                .undone("Trainingsplan für 12 Wochen erstellen"),
                .undone("10km Testlauf am Samstag", important: true),
                .undone("Ernährungsplan anpassen")
            ])
        ),
        Topic(
            title: "Bücherliste 2026",
            status: .active,
            bullets: makeBullets([
                .done("Der Report der Magd - fertig lesen"),
                .undone("Sachbuch über Produktivität kaufen"),
                .undone("Buchclub-Empfehlung nachschlagen", important: true)
            ])
        ),
        Topic(
            title: "Umzug 2025",
            status: .archived,
            isFavorite: true,
            bullets: makeBullets([
                .done("Umzugsunternehmen beauftragt"),
                .done("Adresse bei Behörden geändert"),
                .done("Alte Wohnung übergeben")
            ])
        ),
    ]
 
    // MARK: - Daily Logs
 
    static let dailies: [Daily] = [
        Daily(
            title: "Heute",
            date: Calendar.current.startOfDay(for: .now),
            bullets: makeBullets([
                .undone("Zahnarzttermin um 14 Uhr", important: true),
                .undone("Milch und Eier kaufen"),
                .undone("Präsentation für Montag vorbereiten", important: true),
                .done("30 Minuten spazieren gehen")
            ])
        ),
        Daily(
            title: "Gestern",
            date: Calendar.current.date(byAdding: .day, value: -1, to: .now) ?? .now,
            isFavorite: true,
            bullets: makeBullets([
                .done("Rechnung an Kunde XY versendet"),
                .done("Wäsche gewaschen"),
                .done("Mit Mama telefoniert", important: true)
            ])
        ),
        Daily(
            title: "Vorgestern",
            date: Calendar.current.date(byAdding: .day, value: -2, to: .now) ?? .now,
            bullets: []
        )
    ]
 
    // MARK: - Pool
 
    static let pool: Pool =
        Pool(
            title: "Pool",
            isFavorite: true,
            bullets: makeBullets([
                .undone("Idee: App-Feature für Erinnerungen", important: true),
                .undone("Film-Tipp von Jonas: 'Everything Everywhere...'"),
                .undone("Rezept: Kürbissuppe mit Ingwer"),
                .undone("Interessanter Podcast über Gewohnheiten"),
                .done("WLAN-Passwort Ferienwohnung: siehe Notizen")
            ])
        )
    
    static let emptyPool: Pool =
        Pool(
            title: "Pool",
            isFavorite: true,
            bullets: []
        )
 
    // MARK: - Preloaded in-memory ModelContainer für Previews
 
    /// Erstellt einen In-Memory-Container mit vorbefüllten Testdaten.
    /// Nutzung in Previews:
    ///
    ///     #Preview {
    ///         ContentView()
    ///             .modelContainer(SampleData.previewContainer)
    ///     }
    @MainActor
    static var previewContainer: ModelContainer = {
        let schema = Schema([Topic.self, Daily.self, Pool.self, Bullet.self])
        let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
 
        do {
            let container = try ModelContainer(for: schema, configurations: [configuration])
            let context = container.mainContext
 
            topics.forEach { context.insert($0) }
            dailies.forEach { context.insert($0) }
            context.insert(pool)
 
            return container
        } catch {
            fatalError("Konnte Preview-ModelContainer nicht erstellen: \(error)")
        }
    }()
}
