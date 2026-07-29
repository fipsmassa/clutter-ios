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
    static let appString = "Clutter"
    
    // Topic strings
    static let topicsString = "Topics"
    static let emptyTopicsLabelString = "No Topics created"
    static let emptyTopicsDescriptionString = "It seems like no topics have been created yet. Add a new topic to get started."
    static let addTopicsButtonString = "Add Topic"
    
    // Log strings
    static let dailiesString = "Dailies"
    static let emptyDailiesLabelString = "No Dailies created"
    static let emptyDailiesDescriptionString = "It seems like no dailies have been created yet. Add a new daily to get started."
    static let addDailiesButtonString = "Add Daily"
    
    // Pool strings
    static let poolString = "Pool"
    static let emptyPoolLabelString = "No Pool created"
    static let emptyPoolDescriptionString = "It seems like no item have been added to the pool yet. Add a new item to get started."
    static let addPoolButtonString = "Add Pool"
    
    // Bullet strings
    static let emptyBulletsLabelString = "No Items"
    static let emptyBulletsDescriptionString = "It seems like no items have been added yet. Add a new item to get started."
    static let addBulletButtonString = "Add Item"
    
    // Icon strings
    static let homeIconString = "house"
    static let topicsIconString = "list.bullet"
    static let logsIconString = "text.page"
    static let poolIconString = "lightbulb"
    static let plusIconString = "plus"
    static let bulletIconString = "square"
    static let trashIconString = "trash"
    static let starIconString = "star.fill"
    static let exclamationmarkIconString = "exclamationmark"
    static let heartIconString = "heart.fill"
    
    // Action strings
    enum Action {
        static let add = "Add"
        static let delete = "Delete"
        static let cancel = "Cancel"
        static let deleteConfirmation = "Are you sure you want to delete this?"
        static let favorite = "Favorite"
        static let notFavorite = "Not Favorite"
        static let important = "Important"
        static let notImportant = "Not Important"
    }
    
    // Form strings
    enum Form {
        static let title = "Title"
        static let description = "Description"
        static let isFavorite = "Favorite"
        static let isImportant = "Important"
    }
}
