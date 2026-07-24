//
//  Router.swift
//  Clutter
//
//  Created by Philipp Seibold on 13.07.26.
//

import SwiftUI

@Observable
class TabRouter {
    var selectedTab: Tab = .home
    
    // seperate paths per route/tab
    var homePath = NavigationPath()
    var topicPath = NavigationPath()
    var dailyLogPath = NavigationPath()
    var poolPath = NavigationPath()
 
    enum Tab: Int, CaseIterable {
        case home = 0
        case collection = 1
        case dailyLog = 2
        case pool = 4
 
        var title: String {
            switch self {
            case .home: return Constants.homeString
            case .collection: return Constants.topicsString
            case .dailyLog: return Constants.dailiesString
            case .pool: return Constants.poolString
            }
        }
 
        var icon: String {
            switch self {
            case .home: return Constants.homeIconString
            case .collection: return Constants.topicsIconString
            case .dailyLog: return Constants.logsIconString
            case .pool: return Constants.poolIconString
            }
        }
    }
 
    func selectTab(_ tab: Tab) {
        if selectedTab == tab {
            // Already on this tab - pop to root
            popToRoot(for: tab)
        } else {
            selectedTab = tab
        }
    }
 
    func popToRoot(for tab: Tab) {
        switch tab {
        case .home: homePath.removeLast(homePath.count)
        case .collection: topicPath.removeLast(topicPath.count)
        case .dailyLog: dailyLogPath.removeLast(dailyLogPath.count)
        case .pool: poolPath.removeLast(poolPath.count)
        }
    }
 
    func navigateToCollection(_ collection: Bullet) {
        selectedTab = .collection
        homePath.append(collection)
    }
 
    func navigateToDailyLog(_ dailyLog: Bullet) {
        selectedTab = .dailyLog
        dailyLogPath.append(dailyLog)
    }
 
    func navigateToPool(_ pool: Bullet) {
        selectedTab = .pool
        poolPath.append(pool)
    }
}
