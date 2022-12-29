//
//  Font.swift
//  SwiftUI_Practice (iOS)
//
//  Created by JW Moon on 2022/12/29.
//

import SwiftUI

struct Font: View {
    var body: some View {
        VStack {
            Text("Rubik-Light_Regular")
                .font(.custom("Rubik-Light_Regular", size: 20))
            Text("Rubik-LightItalic_Italic")
                .font(.custom("Rubik-LightItalic_Italic", size: 20))
            Text("Rubik-Light_ExtraBold")
                .font(.custom("Rubik-Light_ExtraBold", size: 20))
            Text("Rubik-LightItalic_ExtraBold-Italic")
                .font(.custom("Rubik-LightItalic_ExtraBold-Italic", size: 20))
            Text("Rubik-LightItalic_Black-Italic")
                .font(.custom("Rubik-LightItalic_Black-Italic", size: 20))
        }
    }
}

struct Font_Previews: PreviewProvider {
    static var previews: some View {
        Font()
    }
}
