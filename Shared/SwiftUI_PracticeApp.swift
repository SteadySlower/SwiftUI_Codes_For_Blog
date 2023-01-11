//
//  SwiftUI_PracticeApp.swift
//  Shared
//
//  Created by Jong Won Moon on 2022/05/04.
//

import SwiftUI

@main
struct SwiftUI_PracticeApp: App {
    
    @State var username: String
    
    init() {
        let isUITesting: Bool = ProcessInfo.processInfo.arguments.contains("UITesting")
        if isUITesting {
            let username = ProcessInfo.processInfo.environment["username"]!
            self.username = username
        } else {
            self.username = ""
        }
    }
    
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
