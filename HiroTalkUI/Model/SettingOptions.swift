//
//  SettingOptions.swift
//  HiroTalkUI
//
//  Created by kotsuya on 2023/11/13.
//

import SwiftUI

enum SettingsOptions: Int, CaseIterable, Identifiable {
    case darkMode
    case activeStatus
    case Accessibility
    case privacy
    case notifications

    var title: String {
        switch self {
        case .darkMode: return "Dark mode"
        case .activeStatus: return "Active status"
        case .Accessibility: return "Accessibility"
        case .privacy: return "Privacy and Safety"
        case .notifications: return "Notifications"
        }
    }

    var imageName: String {
        switch self {
        case .darkMode: return "moon.circle.fill"
        case .activeStatus: return "message.badge.circle.fill"
        case .Accessibility: return "person.circle.fill"
        case .privacy: return "lock.circle.fill"
        case .notifications: return "bell.circle.fill"
        }
    }

    var imageBackgroundColor: Color {
        switch self {
        case .darkMode: return .black
        case .activeStatus: return Color(.systemGreen)
        case .Accessibility: return .black
        case .privacy: return Color(.systemBlue)
        case .notifications: return Color(.systemPurple)
        }
    }

    var id: Int { return self.rawValue }
}
