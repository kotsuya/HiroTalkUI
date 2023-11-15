//
//  InboxViewModel.swift
//  HiroTalkUI
//
//  Created by kotsuya on 2023/11/12.
//

import Foundation
import Combine
import Firebase

class InboxViewModel: ObservableObject {

    @Published var currentUser: User?
    @Published var recentMessages = [Message]()

    private var cancellables = Set<AnyCancellable>()
    private let service = InboxService()

    init() {
        setupSubscribers()
        service.observeRecentMessages()
    }

    func setupSubscribers() {
        UserService.shared.$currentUser
            .sink { [weak self] user in
                self?.currentUser = user
            }
            .store(in: &cancellables)

        service.$documentChages
            .sink { [weak self] changes in
                self?.loadInitalMessages(fromChanges: changes)
            }
            .store(in: &cancellables)
    }

    private func loadInitalMessages(fromChanges changes: [DocumentChange]) {
        var messages = changes.compactMap({ try? $0.document.data(as: Message.self) })

        for i in 0..<messages.count {
            let message = messages[i]

            UserService.fetchUser(withUid: message.chatPartnerId) { user in
                messages[i].user = user
                self.recentMessages = self.recentMessages.filter({ $0.fromId != user.uid })
                self.recentMessages.append(messages[i])
            }
        }
    }
}
