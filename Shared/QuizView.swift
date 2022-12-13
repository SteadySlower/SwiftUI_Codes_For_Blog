//
//  QuizView.swift
//  SwiftUI_Practice
//
//  Created by Jong Won Moon on 2022/12/12.
//

import SwiftUI

struct QuizView: View {
    
    let username: String
    
    @StateObject var vm = ViewModel()
    @State var showCorrectAlert = false
    @State var showWrongAlert = false
    
    var body: some View {
        VStack {
            Text("Let's Quiz, \(username)!")
            Spacer()
            VStack {
                Text("\(vm.questions[vm.index])를(을) 영어로?")
                NavigationLink("그림 힌트") {
                    PictureView(pictureName: vm.questions[vm.index])
                }
                TextField("정답", text: $vm.input)
                    .frame(width: 100, height: 50)
                    .border(.black)
                    .disabled(vm.isCorrect)
                if vm.isCorrect {
                    nextButton
                } else {
                    inputButton
                }
            }
            .alert("정답입니다.", isPresented: $showCorrectAlert) { Button("확인") { } }
            .alert("틀렸습니다.", isPresented: $showWrongAlert) { Button("다시 풀기") { } } // vm.input = ""
            Spacer()
        }
    }
}

extension QuizView {
    var inputButton: some View {
        Button {
            vm.inputButtonTapped { isCorrect in
                if isCorrect {
                    showCorrectAlert = true
                } else {
                    showWrongAlert = true
                }
            }
        } label: {
            Text("입력")
                .frame(width: 100, height: 50)
                .foregroundColor(.white)
                .background(.mint)
                .cornerRadius(25)
        }
    }
    
    var nextButton: some View {
        Button {
            vm.next()
        } label: {
            Text("다음 문제")
                .frame(width: 100, height: 50)
                .foregroundColor(.white)
                .background(.mint)
                .cornerRadius(25)
        }
    }
}

extension QuizView {
    final class ViewModel: ObservableObject {
        
        let questions = ["사과", "바나나", "자동차"]
        let answers = ["apple", "banana", "car"]
        
        @Published var index: Int = 0
        @Published var input: String = ""
        @Published var isCorrect = false
        
        func inputButtonTapped(_ completion: (Bool) -> Void) {
            let answer = input.lowercased()
            if answer == answers[index] {
                isCorrect = true
                completion(true)
            } else {
                completion(false)
            }
        }
        
        func next() {
            index = (index + 1) % 3
            input = ""
            isCorrect = false
        }
    }
}
