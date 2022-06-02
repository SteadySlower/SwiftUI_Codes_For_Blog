//
//  4. EnvironmentObject.swift
//  SwiftUI_Practice
//
//  Created by Jong Won Moon on 2022/06/02.
//

import SwiftUI

//✅ 선언하는 부분은 일반적인 ObservableObject와 동일합니다.
class MyInfo: ObservableObject {
    @Published var name = "Moon"
    @Published var photo = "person"
    var token = ""
}

struct HomeView: View {
    @EnvironmentObject var myInfo: MyInfo
    
    var body: some View {
        NavigationView(content: {
            VStack {
                NavigationLink(destination: {
                    DetailView()
                }, label: {
                    Text("To Info Detail")
                })
                Text(myInfo.name)
                Image(systemName: myInfo.photo)
            }
        })
    }
}

fileprivate struct DetailView: View {
    @ObservedObject var myInfo = MyInfo()
    
    var body: some View {
        VStack {
            Text(myInfo.name)
            Image(systemName: myInfo.photo)
            Button {
                myInfo.name = "Lee"
            } label: {
                Text("Change Name")
            }

        }
    }
}

struct ContentView: View {
    //✅ 가장 상위 View에서 일단 주입만 하면!
    var body: some View {
        HomeView()
            .environmentObject(MyInfo())
    }
}
