//
//  ProfileViewModel.swift
//  HiroTalkUI
//
//  Created by kotsuya on 2023/11/12.
//

import SwiftUI
import PhotosUI

class ProfileViewModel: ObservableObject {
    @Published var isShowingAlert: Bool = false
    @Published var fullname: String = "" {
        didSet {
            Task {
                try await updateFullname()
            }
        }
    }
    @Published var selectedItem: PhotosPickerItem? {
        didSet {
            Task {
                try await loadImage()
                try await updateProfileImage()
            }
        }
    }
    @Published var profileImage: Image?
    private var uiImage: UIImage?

    @MainActor
    private func loadImage() async throws {
        guard let item = selectedItem else { return }
        guard let imageData = try? await item.loadTransferable(type: Data.self) else { return }
        guard let uiImage = UIImage(data: imageData) else { return }
        self.uiImage = uiImage
        self.profileImage = Image(uiImage: uiImage)
    }

    private func updateProfileImage() async throws {
        guard let image = self.uiImage else { return }
        guard let imageUrl = try? await ImageUploader.uploadImage(image) else { return }
        try await UserService.shared.updateUserProfileImage(withImageUrl: imageUrl)
    }

    private func updateFullname() async throws {
        guard !self.fullname.isEmpty else { return }
        try await UserService.shared.updateUserFullname(fullname: fullname)
    }
}
