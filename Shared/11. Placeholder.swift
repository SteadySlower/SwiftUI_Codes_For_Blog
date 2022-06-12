//
//  11. Placeholder.swift
//  SwiftUI_Practice
//
//  Created by Jong Won Moon on 2022/06/10.
//

import SwiftUI

//struct PlaceholderView: View {
//    var body: some View {
//        VStack {
//            Text("Hello world")
//                .redacted(reason: .privacy)
//            Image(systemName: "pencil")
//                .privacySensitive()
//        }
//    }
//}

struct PlaceholderView: View {
    var body: some View {
        VStack {
            NameView()
            PhoneNumberView()
        }
        .redacted(reason: .placeholder)
    }
}

struct NameView: View {
    @Environment(\.redactionReasons) var redactionReasons
    
    var body: some View {
        if redactionReasons == .placeholder {
            Text("Name is being loaded 🏃‍♂️")
                .unredacted()
        } else if redactionReasons == .privacy {
            Text("Name is privacy 🤫")
        } else {
            Text("Name is Kim ☺️")
        }
    }
}

struct PhoneNumberView: View {
    @Environment(\.redactionReasons) var redactionReasons
    
    var body: some View {
        if redactionReasons == .placeholder {
            Text("Phone number is being loaded 🏃‍♂️")
                .unredacted()
        } else if redactionReasons == .privacy {
            Text("Phone number is privacy 🤫")
        } else {
            Text("Phone number is 010-0000-0000 ☺️")
        }
    }
}


struct PlaceHolderView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceholderView()
    }
}
