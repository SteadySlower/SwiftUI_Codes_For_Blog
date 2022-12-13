//
//  SwiftUI_PracticeApp.swift
//  Shared
//
//  Created by Jong Won Moon on 2022/05/04.
//

import SwiftUI

@main
struct SwiftUI_PracticeApp: App {
    
    @State var username = "Teddy"
    
    var body: some Scene {
        WindowGroup {
            if username.isEmpty {
                NameView(name: $username)
            } else {
                NavigationView {
                    QuizView(username: username)
                }
            }
        }
    }
}
