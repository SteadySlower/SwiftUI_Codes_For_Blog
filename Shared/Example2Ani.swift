//
//  Example2Ani.swift
//  SwiftUI_Practice
//
//  Created by JW Moon on 2022/12/27.
//

import SwiftUI

struct Example2Ani: View {
    @State var scale = 0.1
    @State var offset = 50.0
    @State var degree = 90.0
    
    var body: some View {
        VStack {
            Rectangle()
                .foregroundColor(.blue)
                .scaleEffect(scale)
                .offset(x: offset, y: offset)
                .rotationEffect(.degrees(degree))
                .rotation3DEffect(
                    Angle(degrees: degree),
                    axis: (x: 1, y: 2, z: 3)
                )
            Button("커져라") {
                withAnimation(.linear(duration: 0.5)) {
                    scale = 1.0
                    offset = 0.0
                    degree = 0
                }
            }
        }
    }
}

struct Example2Ani_Previews: PreviewProvider {
    static var previews: some View {
        Example2Ani()
    }
}
