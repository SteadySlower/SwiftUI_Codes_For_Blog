//
//  TextFieldWithoutString.swift
//  SwiftUI_Practice
//
//  Created by Jong Won Moon on 2022/06/03.
//

import SwiftUI

struct TextFieldWithoutString: View {
    
    @State var circleSize: CGFloat = 0
    
    var body: some View {
        VStack {
            TextField("circle size", value: $circleSize, formatter: NumberFormatter())
                .frame(width: 120, height: 20)
                .padding(5)
                .border(.black, width: 1)
                .multilineTextAlignment(.trailing)
            Text("circle size: \(Int(circleSize))")
                .frame(width: 120, height: 20, alignment: .trailing)
                .multilineTextAlignment(.trailing)
            Circle()
                .foregroundColor(.yellow)
                .frame(width: circleSize)
        }
    }
}

struct TextFieldWithoutString_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldWithoutString()
    }
}
