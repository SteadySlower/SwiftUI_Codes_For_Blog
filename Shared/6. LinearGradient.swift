//
//  6. LinearGradient.swift
//  SwiftUI_Practice
//
//  Created by Jong Won Moon on 2022/06/03.
//

import SwiftUI

struct GradientView: View {
    var body: some View {
        ZStack {
//            LinearGradient(gradient: Gradient(colors: [.red, .blue, .green]), startPoint: .topLeading, endPoint: .bottomTrailing)
//                .ignoresSafeArea()
//
//            RadialGradient(colors: [.red, .blue, .green], center: .center, startRadius: 50, endRadius: 200)
//                .ignoresSafeArea()
            
//            AngularGradient(colors: [.red, .blue, .green], center: .center)
//                .ignoresSafeArea()
//            AngularGradient(colors: [.red, .blue, .green], center: .center, angle: .degrees(90))
//                .ignoresSafeArea()
            AngularGradient(colors: [.red, .blue, .green], center: .center, startAngle: .degrees(90), endAngle: .degrees(180))
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                Text("안녕하세요")
                    .font(.system(size: 35, weight: .heavy, design: .serif))
                    .foregroundColor(.white)
                    .frame(width: 320, height: 100)
                Spacer()
            }
        }
    }
}

struct GradientView_Previews: PreviewProvider {
    static var previews: some View {
        GradientView()
    }
}
