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
    private let service = NetworkService.shared

    init() {
//        let isUITesting: Bool = CommandLine.arguments.contains("-UITesting")
        let isUITesting: Bool = ProcessInfo.processInfo.arguments.contains("-UITesting")
        if isUITesting {
            let username = ProcessInfo.processInfo.environment["-username"]!
            self.username = username
            self.service.serviceType = "Mock"
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
//                    QuizView(username: username)
                    QuizView2(username: username, service: service)
                }
            }
        }
    }
}
