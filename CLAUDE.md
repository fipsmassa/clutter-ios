# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What Clutter is

Clutter is an iPhone-only SwiftUI app implementing the bullet-journal method. Core entities:

- **Topic** — equivalent of a bullet-journal "collection" (e.g. a project or area of life).
- **Daily** — a day's log of tasks.
- **Pool** — a single, unfiled catch-all for loose ideas that don't belong to any Topic or Daily.
- **Bullet** — a single task/item; every Bullet belongs to exactly one Topic, Daily, or Pool.

Four top-level screens: Home (favorite Topics + Dailies at a glance), Topics, Dailies, Pool.
Visual style: a light-brown, journal-like color scheme (`Color.brown.secondary` backgrounds throughout).

## Commands

There is a single Xcode project with one target/scheme (`Clutter`), no SPM packages, and **no test target configured**.

Build for the simulator:
```bash
xcodebuild -scheme Clutter -destination 'platform=iOS Simulator,name=iPhone 17' build
```

Open in Xcode:
```bash
open Clutter.xcodeproj
```

There is no lint tooling (no SwiftLint config) and no test target — `xcodebuild test` will fail until a test target is added. Verify UI changes by running the app in the simulator (or Xcode previews — most views ship `#Preview` blocks, several with "with data" / "empty state" variants backed by `SampleData`).

## Architecture

### Data layer (SwiftData)

Four `@Model` classes registered in the shared schema in [ClutterApp.swift](Clutter/ClutterApp.swift): `Topic`, `Daily`, `Pool`, `Bullet`. All persisted on-disk (`isStoredInMemoryOnly: false`).

- [Bullet.swift](Clutter/Bullet.swift) — `title`, `isDone`, `isImportant`, `metadata`. No concept of bullet "type" (task/event/note) or migration between containers — every Bullet is a plain task.
- [Topic.swift](Clutter/Topic.swift), [Daily.swift](Clutter/Daily.swift), [Pool.swift](Clutter/Pool.swift) — each owns `bullets: [Bullet]` via a `.cascade` relationship (deleting the parent deletes its bullets), plus `status: ItemStatus` and `isFavorite`.
- [Pool.swift](Clutter/Pool.swift) is enforced as a singleton via a private unique `singletonKey`; [ContentView.swift](Clutter/Views/ContentView.swift) lazily creates the one Pool row on first launch (`ensurePoolExists()`).
- [Metadata.swift](Clutter/Metadata.swift) — shared `createdAt`/`updatedAt`/`deletedAt` struct with `touch()` and `markDeleted()` helpers for soft-delete. Currently unused by any view/query — all deletes go through `modelContext.delete(_:)` (hard delete), and nothing calls `touch()`.
- [ItemStatus.swift](Clutter/ItemStatus.swift) — `.active` / `.archived`, set on Topic/Daily/Pool but not yet read anywhere (no archived-item filtering or UI).
- [SampleData.swift](Clutter/SampleData.swift) — seed data (German-language sample content) and an in-memory `previewContainer` used by `#Preview`s.

### Navigation

[TabRouter.swift](Clutter/TabRouter.swift) is an `@Observable` injected via `.environment(router)` from [ContentView.swift](Clutter/Views/ContentView.swift). Each of the 4 tabs (`home`, `collection`, `dailyLog`, `pool`) gets its own `NavigationStack` and its own `NavigationPath` on the router, so switching tabs preserves each stack's drill-down state; selecting the already-active tab pops it to root (`selectTab`/`popToRoot`).

Note: `navigateToCollection`/`navigateToDailyLog`/`navigateToPool` on `TabRouter` are typed to take a `Bullet`, but the paths they push onto expect `Topic`/`Daily`/`Pool` values (the `navigationDestination(for:)` registrations in `ContentView` are keyed on `Topic`/`Daily`). These methods appear unused/stale — check before relying on them.

### View organization

- [Views/ContentView.swift](Clutter/Views/ContentView.swift) — root `TabView`, owns the SwiftData `@Query`s for the top-level lists and wires each tab's `NavigationStack` + `navigationDestination`.
- [Views/HomeView.swift](Clutter/Views/HomeView.swift) — favorite/non-favorite Topic cards in a horizontal scroller ([Views/CardView.swift](Clutter/Views/CardView.swift)) above a `DailyList`.
- [Views/NewHomeView.swift](Clutter/Views/NewHomeView.swift) — placeholder/experiment (three blue rectangles), not referenced from `ContentView`; appears to be in-progress work on a Home redesign.
- [Views/Topics/](Clutter/Views/Topics), [Views/Dailies/](Clutter/Views/Dailies) — each follows the same List-screen → Detail-screen → Add-sheet pattern: `TopicList`/`DailyList` (row list + swipe actions), `TopicDetailView`/`DailyDetailView` (bullet list for that container), `AddTopicSheet`/`AddBulletSheet` (title + toggle form sheets).
- [Views/Bullets/](Clutter/Views/Bullets) — `BulletRowView` (done-toggle circle + important flag + inline-editable `TextField`) and `AddBulletSheet` are shared across Topic/Daily/Pool detail views.
- [Views/PoolView.swift](Clutter/Views/PoolView.swift) — same bullet-list pattern as Topic/Daily detail views, applied directly to the singleton Pool.
- [Views/SettingsView.swift](Clutter/Views/SettingsView.swift) — placeholder text only, not wired into any tab or navigation path.
- [Constants.swift](Clutter/Constants.swift) — centralizes all user-facing strings and SF Symbol names (no `Localizable.strings`/String Catalog — everything is English-hardcoded here regardless of `SampleData`'s German content).

## Gaps relative to the product vision

- **No "current daily" overflow logic.** The vision calls for a daily to show today's tasks plus undone tasks rolled over from past days. `DailiesView.addDaily()` just creates a fresh, empty `Daily` for today — there is no rollover/migration of incomplete bullets from previous `Daily` entries, and `HomeView`'s daily section is a plain list of all Dailies rather than a curated "current daily" view.
- **No way to move a Bullet between containers.** The Pool is meant to hold ideas "that cannot be assigned to a topic or a daily" (implying they may later be assigned). There's currently no move/convert action from Pool → Topic/Daily, or between Topic and Daily.
- **`ItemStatus.archived` is inert.** Set on model init but no view filters by it, exposes an archive action, or shows archived items separately from active ones.
- **Soft-delete groundwork is unused.** `Metadata.markDeleted()`/`isDeleted` exist but every delete path uses `modelContext.delete(_:)` directly; `touch()` is never called on edits either.
- **Only one bullet "type."** Classic bullet journal notation (task/event/note, migrated/scheduled) isn't modeled — `Bullet` only has `isDone`/`isImportant`.
- **`Views/NewHomeView.swift`** is unused placeholder code, not reachable from the app — likely mid-redesign and worth resolving (finish or remove) before it causes confusion.
- **`SettingsView`** isn't reachable from anywhere in the tab structure.
- **`TabRouter.navigateToCollection/navigateToDailyLog/navigateToPool`** have a type mismatch against the `NavigationPath`s they push into (see Navigation above) and don't appear to be called from any view.
- **No test target** in the Xcode project.
- **`TARGETED_DEVICE_FAMILY` is `"1,2"`** (iPhone + iPad) despite the app being scoped as iPhone-only; layouts aren't adapted for iPad/regular size classes.
- **`AccentColor` asset** only defines a color for the `osx` platform/idiom (`systemBrownColor`); there's no iOS-idiom entry, so the accent color likely falls back to the system default on-device rather than the intended brown journal theme.
