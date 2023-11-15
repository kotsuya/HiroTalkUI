//
//  ChatView.swift
//  HiroTalkUI
//
//  Created by kotsuya on 2023/11/12.
//

import SwiftUI

struct ChatView: View {
    @StateObject var viewModel: ChatViewModel
    let user: User

    init(user: User) {
        self.user = user
        self._viewModel = StateObject(wrappedValue: ChatViewModel(user: user))
    }

    var body: some View {
        VStack {
            ScrollView {
                // header

                VStack {
                    CircularProfileImageView(user: user, size: .xLarge)

                    VStack(spacing: 4) {
                        Text(user.fullname)
                            .font(.title3)
                            .fontWeight(.semibold)

                        Text("Messenger")
                            .font(.footnote)
                            .foregroundColor(.gray)
                    }
                }

                // messages

                LazyVStack {                    
                    ForEach(viewModel.messages) { message in
                        ChatMessageCell(message: message)
                    }
                }
            }

            Spacer()

            HStack {
                Image(systemName: "photo.on.rectangle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 32, height: 32)
                    .foregroundColor(Color(.darkGray))

                ZStack(alignment: .trailing) {
                    TextField("Message...", text: $viewModel.messageText, axis: .vertical)
                        .padding(12)
                        .padding(.trailing, 48)
                        .background(Color(.systemGroupedBackground))
                        .clipShape(Capsule())
                        .font(.subheadline)

                    Button {
                        viewModel.sendMessage()
                        viewModel.messageText = ""
                    } label: {
                        Text("Send")
                            .fontWeight(.semibold)
                    }
                    .padding(.horizontal)
                }
            }
            .padding()
        }
        .navigationTitle(user.fullname)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView(user: User.MOCK_USER)
    }
}
