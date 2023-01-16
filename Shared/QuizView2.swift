//
//  Quiz2View.swift
//  SwiftUI_Practice
//
//  Created by Jong Won Moon on 2023/01/11.
//

import SwiftUI

struct QuizView2: View {
    
    let username: String
    
    @ObservedObject private var vm: ViewModel
    @State var showCorrectAlert = false
    @State var showWrongAlert = false
    
    init(username: String, service: NetworkService) {
        self.username = username
        self.vm = ViewModel(service: service)
    }
    
    var body: some View {
        ZStack {
            if vm.questions.isEmpty {
                VStack {
                    Text("로딩중")
                    ProgressView()
                        .font(.largeTitle)
                        .foregroundColor(.black)
                }
                .onAppear { vm.loadQuiz() }
            } else {
                contentView
            }
        }
    }
}

extension QuizView2 {
    var contentView: some View {
        VStack {
            Text("Let's \(vm.service.serviceType) Quiz, \(username)!")
                .accessibilityIdentifier("welcome message label of \(username)")
            Spacer()
            VStack {
                Text("\(vm.questions[vm.index])를(을) 영어로?")
                NavigationLink("그림 힌트") {
                    PictureView(pictureName: vm.questions[vm.index])
                }
                .accessibilityIdentifier("picture hint navigation link")
                .accessibilityLabel("그림 힌트 보기")
                TextField("정답", text: $vm.input)
                    .frame(width: 100, height: 50)
                    .border(.black)
                    .disabled(vm.isCorrect)
                    .accessibilityIdentifier("answer text field")
                    .accessibilityLabel("정답 입력 텍스트 필드")
                if vm.isCorrect {
                    nextButton
                        .accessibilityIdentifier("next question button")
                        .accessibilityLabel("다음 문제 버튼")
                } else {
                    inputButton
                        .accessibilityIdentifier("input answer button")
                        .accessibilityLabel("정답 입력 버튼")
                }
            }
            .alert("정답입니다.", isPresented: $showCorrectAlert) { Button("확인") { } }
            .alert("틀렸습니다.", isPresented: $showWrongAlert) { Button("다시 풀기") { vm.input = "" } }
            Spacer()
        }
    }
}

extension QuizView2 {
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

extension QuizView2 {
    final class ViewModel: ObservableObject {
        
        let service: NetworkService
        @Published var questions = [String]()
        @Published var answers = [String]()
        
        init(service: NetworkService) {
            self.service = service
        }
        
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
        
        func loadQuiz() {
            service.LoadQuiz { quiz in
                print(quiz)
                self.questions = quiz[0]
                self.answers = quiz[1]
            }
        }
    }
}
