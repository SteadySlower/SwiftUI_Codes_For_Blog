//
//  PictureView.swift
//  SwiftUI_Practice
//
//  Created by Jong Won Moon on 2022/12/12.
//

import SwiftUI

struct PictureView: View {
    
    let pictureName: String
    
    var body: some View {
        Image(pictureName)
            .resizable()
            .frame(width: 200, height: 200)
            .navigationTitle("\(pictureName)의 그림 힌트")
    }
}
