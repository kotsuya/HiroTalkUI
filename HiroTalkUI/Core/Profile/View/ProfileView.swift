//
//  ProfileView.swift
//  HiroTalkUI
//
//  Created by kotsuya on 2023/11/12.
//

import SwiftUI
import PhotosUI

struct ProfileView: View {
    @StateObject var viewModel = ProfileViewModel()

    let user: User

    var body: some View {
        VStack {
            VStack {
                PhotosPicker(selection: $viewModel.selectedItem) {
                    if let profileImage = viewModel.profileImage {
                        profileImage
                            .resizable()
                            .scaledToFill()
                            .frame(width: 80, height: 80)
                            .clipShape(Circle())
                    } else {
                        CircularProfileImageView(user: user, size: .xLarge)
                    }
                }

                HStack {
                    Text(viewModel.fullname.isEmpty ? user.fullname : viewModel.fullname)
                        .font(.title2)
                        .fontWeight(.semibold)

                    Button {
                        viewModel.isShowingAlert = true
                    } label: {
                        Image(systemName: "square.and.pencil.circle.fill")
                            .resizable()
                            .frame(width: 32, height: 32)
                            .foregroundStyle(.black, Color(.systemGray5))
                    }
                    .alert("名前変更", isPresented: $viewModel.isShowingAlert) {
                        TextField(user.fullname, text: $viewModel.fullname)
                        Button("OK") {
                            
                        }
                    } message: {
                        Text("新しい名前を入力してください。")
                    }
                }
            }

            List {
                Section {
                    ForEach(SettingsOptions.allCases, id:\.self) { option in
                        HStack {
                            Image(systemName: option.imageName)
                                .resizable()
                                .frame(width: 24, height: 24)
                                .foregroundColor(option.imageBackgroundColor)

                            Text(option.title)
                                .font(.subheadline)
                        }
                    }
                }

                Section {
                    Button("Log Out") {
                        AuthService.shared.signOut()
                    }

                    Button("Delete Account") {

                    }
                }
                .foregroundColor(.red)
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(user: User.MOCK_USER)
    }
}
