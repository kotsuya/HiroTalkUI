//
//  RegistrationViewModel.swift
//  HiroTalkUI
//
//  Created by kotsuya on 2023/11/12.
//

import SwiftUI

class RegistrationViewModel: ObservableObject {

    @Published var email = ""
    @Published var password = ""
    @Published var fullname = ""

    func createUser() async throws {
        try await AuthService.shared.createUser(withEmail: email, password: password, fullname: fullname)
    }
}
