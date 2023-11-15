//
//  Message.swift
//  HiroTalkUI
//
//  Created by kotsuya on 2023/11/12.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct Message: Identifiable, Codable, Hashable {
    @DocumentID var messageId: String?
    let fromId: String
    let toId: String
    let messageText: String
    let timestamp: Timestamp

    var user: User?

    var id: String {
        return messageId ?? NSUUID().uuidString
    }

    var chatPartnerId: String {
        return fromId == Auth.auth().currentUser?.uid ? toId : fromId
    }

    var isFromCurrentUser: Bool {
        return fromId == Auth.auth().currentUser?.uid
    }

    var timestampString: String {
        return timestamp.dateValue().timestampString()
    }
}
