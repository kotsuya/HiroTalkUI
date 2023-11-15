//
//  LoginViewModel.swift
//  HiroTalkUI
//
//  Created by kotsuya on 2023/11/12.
//

import SwiftUI

class LoginViewModel: ObservableObject {

    @Published var email: String = ""
    @Published var password: String = ""

    func login() async throws {
        try await AuthService.shared.login(withEmail: email, password: password)
    }
}
