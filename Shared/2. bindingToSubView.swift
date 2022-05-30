//
//  2. bindingToSubView.swift
//  SwiftUI_Practice
//
//  Created by Jong Won Moon on 2022/05/30.
//

import SwiftUI

struct Student: Identifiable {
    let id = UUID()
    var name: String
    var score: Int
}

struct MainView2: View {
    
    @ObservedObject var viewModel = MainView2Model()
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack (spacing: 20) {
                    ForEach($viewModel.students) { $student in
                        HStack {
                            Text("\(student.name)의 점수는 \(student.score)점입니다.")
                            Spacer()
                            NavigationLink {
                                EditView(student: $student)
                            } label: {
                                Text("점수 수정")
                            }
                        }
                        .padding(.horizontal, 10)
                    }
                }
            }
        }
    }
}

struct EditView: View {
    
    @Binding var student: Student
    
    var body: some View {
        VStack(alignment: .center) {
            Spacer()
            Text("점수 수정하기")
            TextField("", value: $student.score, formatter: NumberFormatter())
                .frame(width: 50, height: 20)
                .border(.gray, width: 1)
            Spacer()
        }
    }
    
}

class MainView2Model: ObservableObject {
    
    @Published var students = [
        Student(name: "Kim", score: 100),
        Student(name: "Lee", score: 80),
        Student(name: "Park", score: 60),
        Student(name: "Choi", score: 40),
        Student(name: "Jung", score: 20),
    ]
    
}
