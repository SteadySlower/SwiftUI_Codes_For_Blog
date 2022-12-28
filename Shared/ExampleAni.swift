//
//  ExampleAni.swift
//  SwiftUI_Practice
//
//  Created by JW Moon on 2022/12/27.
//

import SwiftUI

//🚫 안되는 예시
struct ExampleAni: View {
    
    @State var transfrom: CGAffineTransform = .init(scaleX: 0, y: 0)
    
    var body: some View {
        VStack {
            Circle()
                .foregroundColor(.blue)
                .transformEffect(transfrom)
            Button("커져라") {
                withAnimation(.linear(duration: 0.5)) {
                    transfrom = .identity
                }
            }
        }
    }
}

struct ExampleAni_Previews: PreviewProvider {
    static var previews: some View {
        ExampleAni()
    }
}
