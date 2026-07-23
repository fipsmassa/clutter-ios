//
//  Constants.swift
//  Clutter
//
//  Created by Philipp Seibold on 13.07.26.
//

import Foundation

struct Constants {
    // Home strings
    static let homeString = "Home"
    
    // Topic strings
    static let topicsString = "Topics"
    static let emptyTopicsLabelString = "No Topics created"
    static let emptyTopicsDescriptionString = "It seems like no topics have been created yet. Add a new topic to get started."
    static let addTopicsButtonString = "Add Topic"
    
    // DailyLog strings
    static let dailyLogsString = "Daily Logs"
    static let emptyDailyLogsLabelString = "No Logs created"
    static let emptyDailyLogsDescriptionString = "It seems like no logs have been created yet. Add a new log to get started."
    static let addDailyLogsButtonString = "Add Log"
    
    // Pool strings
    static let poolString = "Pool"
    static let emptyPoolLabelString = "No Pool created"
    static let emptyPoolDescriptionString = "It seems like no pool has been created yet. Add a new pool to get started."
    static let addPoolButtonString = "Add Pool"
    
    // Bullet strings
    static let emptyBulletsLabelString = "No Items"
    static let emptyBulletsDescriptionString = "It seems like no items have been added yet. Add a new item to get started."
    static let addBulletButtonString = "Add Item"
    
    // Icon strings
    static let homeIconString = "house"
    static let topicsIconString = "list.bullet"
    static let dailyLogsIconString = "1.calendar"
    static let poolIconString = "lightbulb"
    static let plusIconString = "plus"
    static let bulletIconString = "square"
    
    // Action strings
    enum Action {
        static let add = "Add"
        static let delete = "Delete"
        static let cancel = "Cancel"
        static let deleteConfirmation = "Are you sure you want to delete this?"
    }
    
    // Form strings
    enum Form {
        static let title = "Title"
        static let description = "Description"
        static let isFavorite = "Favorite"
        static let isImportant = "Important"
    }
}
