//
//  Constants.swift
//  HiroTalkUI
//
//  Created by kotsuya on 2023/11/12.
//

import Foundation
import Firebase

struct FirestoreConstants {
    static let UsersCollection = Firestore.firestore().collection("users")
    static let MessagesCollection = Firestore.firestore().collection("messages")
}
