//
//  ResignFirstResponder.swift
//  SwiftUI_Practice
//
//  Created by Jong Won Moon on 2022/06/03.
//

import SwiftUI
import UIKit

extension UIApplication {
    func dismissKeyboard() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        // sendAction은 특정한 대상을 지정하지 않으면 firstResponder가 대상이 됨
    }
}

struct ResignFirstResponder: View {
    
    @State private var text: String = ""
    
    var body: some View {
        VStack {
            TextField("", text: $text)
                .frame(width: 120, height: 20)
                .padding(5)
                .border(.black, width: 1)
                .multilineTextAlignment(.trailing)
            Button(action: {
                UIApplication.shared.dismissKeyboard()
            }, label: {
                Text("Dismiss Keyboard")
            })
        }
    }
}

struct ResignFirstResponder_Previews: PreviewProvider {
    static var previews: some View {
        ResignFirstResponder()
    }
}
