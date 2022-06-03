//
//  NavigationBar.swift
//  SwiftUI_Practice
//
//  Created by Jong Won Moon on 2022/06/03.
//

import SwiftUI

struct NavigationBarOptions: View {
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink {
                    NavigationBarOptions_DetailView()
                        .navigationTitle("디테일뷰1")
                        .navigationBarHidden(false)
                        .navigationViewStyle(.columns)
                        .navigationBarBackButtonHidden(false)
                        .navigationBarTitleDisplayMode(.inline)
                } label: {
                    Text("디테일뷰1로")
                }
                NavigationLink {
                    NavigationBarOptions_DetailView()
                        .navigationTitle("디테일뷰2")
    //                    .navigationBarHidden(false)
                        .navigationViewStyle(.columns)
    //                    .navigationBarBackButtonHidden(true)
                        .navigationBarTitleDisplayMode(.large)
                } label: {
                    Text("디테일뷰2로")
                }
                NavigationLink {
                    NavigationBarOptions_DetailView()
                        .navigationTitle("디테일뷰3")
    //                    .navigationBarHidden(false)
                        .navigationViewStyle(.columns)
    //                    .navigationBarBackButtonHidden(true)
                        .navigationBarTitleDisplayMode(.inline)
                } label: {
                    Text("디테일뷰3로")
                }
            }
        }
        
    }
}

struct NavigationBarOptions_DetailView: View {
    var body: some View {
        NavigationView {
            NavigationLink {
                NavigationBarOptions_DetailView()
            } label: {
                Text("더 디테일")
            }
        }
        
    }
}

struct NavigationBarOptions_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBarOptions()
    }
}
