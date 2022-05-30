//
//  onReceive.swift
//  SwiftUI_Practice
//
//  Created by Jong Won Moon on 2022/05/30.
//

import SwiftUI

struct MainView1: View {
    
    @State var shouldShowModal = false

    var body: some View {
                // DetailView를 모달로 띄우는 버튼
        Button {
            shouldShowModal.toggle()
        } label: {
            Text("To Detail Page")
        }
        .sheet(isPresented: $shouldShowModal) {
            DetailView()
                }
    }
}

struct DetailView: View {
    
    @ObservedObject var viewModel = DetailViewModel()
    @State var buttonCount = 0
    @Environment(\.presentationMode) var mode
    
    var body: some View {
        VStack {
            Text("Detail View")
            Button {
                buttonCount += 1 //👉 버튼 누른 횟수 세기
                viewModel.submitData()
            } label: {
                Text("Press to Submit Data")
            }
        }
        .onReceive(viewModel.$didSubmit) { completed in
            print("버튼을 \(buttonCount)번 눌렀을 때 completed 값: \(completed)") //👉 didSubmit이 발행되면 출력
            if completed {
                mode.wrappedValue.dismiss()
            }
        }
    }
}

class DetailViewModel: ObservableObject {
    
    @Published var didSubmit: Bool = false
    
        // 서버에 데이터를 보내는 메소드
    func submitData() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { //👉 서버에 보내는 시간 0.1초 이후에
            print("Submitted Data to Server 🌎")
            self.didSubmit = true //👉 didSubmit을 true로 바꾸어줌.
        }
    }
}
