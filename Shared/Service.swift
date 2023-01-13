//
//  Service.swift
//  SwiftUI_Practice
//
//  Created by Jong Won Moon on 2023/01/11.
//

import Foundation

class NetworkService {
    var serviceType: String = "Real"
    
    static let shared = NetworkService()
    
    // 모킹 전
    func LoadQuiz(_ completion: @escaping ([[String]]) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let questions = ["사과", "바나나", "자동차"]
            let answers = ["apple", "banana", "car"]
            completion([questions, answers])
        }
    }
    
//    // 모킹 후
//    func LoadQuiz(_ completion: @escaping ([[String]]) -> Void) {
//        if serviceType == "Real" {
//            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//                let questions = ["사과", "바나나", "자동차"]
//                let answers = ["apple", "banana", "car"]
//                completion([questions, answers])
//            }
//        } else {
//            let questions = ["사과", "바나나", "자동차"]
//            let answers = ["apple", "banana", "car"]
//            completion([questions, answers])
//        }
//    }
}
