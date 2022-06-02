//
//  5. State var initializer.swift
//  SwiftUI_Practice
//
//  Created by Jong Won Moon on 2022/06/02.
//

import SwiftUI

struct User {
    let name: String
    var message: String
}

struct ProfileView: View {
    @State var user = User(name: "Kim", message: "Hello World")
    
    var body: some View {
        NavigationView {
            VStack {
                Text("name: \(user.name)")
                Text("bio: \(user.message)")
                NavigationLink {
                    EditView(user: $user)
                } label: {
                    Text("Edit Bio")
                }

            }
        }
    }
}

fileprivate struct EditView: View {
    @Environment(\.presentationMode) var mode
    @State private var messageText: String //👉 초기 값이 없는 @State 변수
    @Binding var user: User
    
    init(user: Binding<User>) {
        self._user = user
        self._messageText = State(initialValue: user.wrappedValue.message)
    }
    
    var body: some View {
        VStack {
            TextField("", text: $messageText)
                .frame(width: 200)
                .border(.black, width: 1)
            Button {
                user.message = messageText
                mode.wrappedValue.dismiss()
            } label: {
                Text("Change Bio")
            }
            Button {
                mode.wrappedValue.dismiss()
            } label: {
                Text("Cancel Change")
            }
        }
    }
}
