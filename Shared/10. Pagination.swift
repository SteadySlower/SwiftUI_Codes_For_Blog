//
//  Pagination.swift
//  SwiftUI_Practice
//
//  Created by JW Moon on 2022/06/03.
//

import SwiftUI

struct Pagination: View {
    @ObservedObject var viewModel = PaginationViewModel()
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(viewModel.alphabets) { alphabet in
                    Text(alphabet.text)
                        .frame(height: 100)
                        .font(.system(size: 30))
                        .onAppear {
                            guard let index = viewModel.alphabets.firstIndex(where: { $0.id == alphabet.id }) else { return }
                            if index == viewModel.alphabets.count - 1 {
                                viewModel.fetchAlphabets()
                            }
                        }
                }
            }
        }
    }
}

struct Alphabet: Identifiable {
    let id = UUID()
    let text: String
    
    init(_ text: String) {
        self.text = text
    }
}

extension UInt8 {
    func asciiToString() -> String {
        return String(Character(UnicodeScalar(self)))
    }
}

class PaginationViewModel: ObservableObject {
    // 아스키 코드로 알파벳 만들기
    private let database: [Alphabet] = {
        var database = [Alphabet]()
        let start = Character("A").asciiValue!
        for i in start..<(start + 100) {
            database.append(Alphabet(i.asciiToString()))
        }
        return database
    }()
    
    init() {
        fetchAlphabets()
    }
    
    
    @Published var alphabets = [Alphabet]()
    
    private let dataPerPage = 10
    private var lastIndex = 0
    
    func fetchAlphabets() {
        let fetchedData = database[(lastIndex + 1)...(lastIndex + dataPerPage)]
        lastIndex += 10
        alphabets.append(contentsOf: fetchedData)
    }
    
}



struct Pagination_Previews: PreviewProvider {
    static var previews: some View {
        Pagination()
    }
}
