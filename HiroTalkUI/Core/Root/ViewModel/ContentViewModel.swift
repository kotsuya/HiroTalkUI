//
//  ContentViewModel.swift
//  HiroTalkUI
//
//  Created by kotsuya on 2023/11/12.
//

import Firebase
import Combine

class ContentViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?

    private var cancellables = Set<AnyCancellable>()

    init() {
        setupSubscribers()
    }

    private func setupSubscribers() {
        AuthService.shared.$userSession
            .sink { [weak self] userSessionFromAuthService in
                self?.userSession = userSessionFromAuthService
            }
            .store(in: &cancellables)
    }
}
