//
//  Route.swift
//  HiroTalkUI
//
//  Created by kotsuya on 2023/11/12.
//

import Foundation

enum Route: Hashable {
    case profile(User)
    case chatView(User)
}
