//
//  NameView.swift
//  SwiftUI_Practice
//
//  Created by Jong Won Moon on 2022/12/12.
//

import SwiftUI

struct NameView: View {
    
    @State var input: String = ""
    @Binding var name: String
    @State var showAlert = false
    
    var body: some View {
        VStack {
            TextField("이름", text: $input)
                .frame(width: 100, height: 50)
                .border(.black)
                .accessibilityIdentifier("name field")
                .accessibilityLabel("이름 텍스트 필드")
            Button {
                if isNameValid() {
                    name = input
                } else {
                    showAlert = true
                }
            } label: {
                Text("입력")
                    .frame(width: 100, height: 50)
                    .foregroundColor(.white)
                    .background(.mint)
                    .cornerRadius(25)
            }
            .accessibilityIdentifier("input button")
            .accessibilityLabel("입력버튼")
        }
        .alert("이름은 5글자 이상으로 해주세요", isPresented: $showAlert) {
            Button("다시 입력") { input = "" }
                .accessibilityIdentifier("alert button")
                .accessibilityLabel("팝업 종료 버튼")
        }
    }
    
    func isNameValid() -> Bool {
        return input.count < 5 ? false : true
    }
}
