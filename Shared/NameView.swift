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
        }
        .alert("이름은 5글자 이상으로 해주세요", isPresented: $showAlert) {
            Button("OK") { input = "" }
        }
    }
    
    func isNameValid() -> Bool {
        return input.count < 5 ? false : true
    }
}
