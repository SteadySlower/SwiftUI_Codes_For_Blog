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
            Text("Name is being loaded πββοΈ")
                .unredacted()
        } else if redactionReasons == .privacy {
            Text("Name is privacy π€«")
        } else {
            Text("Name is Kim βΊοΈ")
        }
    }
}

struct PhoneNumberView: View {
    @Environment(\.redactionReasons) var redactionReasons
    
    var body: some View {
        if redactionReasons == .placeholder {
            Text("Phone number is being loaded πββοΈ")
                .unredacted()
        } else if redactionReasons == .privacy {
            Text("Phone number is privacy π€«")
        } else {
            Text("Phone number is 010-0000-0000 βΊοΈ")
        }
    }
}


struct PlaceHolderView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceholderView()
    }
}
