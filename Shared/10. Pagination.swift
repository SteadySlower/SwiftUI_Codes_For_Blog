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
                ForEach(viewModel.data) { datum in
                    Text(datum.text)
                        .frame(height: 100)
                        .font(.system(size: 30))
                        .onAppear {
                            guard let index = viewModel.data.firstIndex(where: { $0.id == datum.id }) else { return }
                            if index == viewModel.data.count - 1 {
                                viewModel.fetchData()
                            }
                        }
                }
            }
        }
    }
}

struct Datum: Identifiable {
    let id = UUID()
    let text: String
    
    init(_ int: Int) {
        self.text = "\(int)"
    }
}


class PaginationViewModel: ObservableObject {
    private let database: [Datum] = {
        var database = [Datum]()
        (0..<100).forEach { i in
            database.append(Datum(i))
        }
        return database
    }()
    
    init() {
        fetchData()
    }
    
    
    @Published var data = [Datum]()
    
    private let dataPerPage = 10
    private var nextIndex = 0
    private var isLastPage: Bool {
        return data.count == database.count
    }
    
    func fetchData() {
        guard isLastPage == false else { return }
        let fetchedData = database[nextIndex..<(nextIndex + dataPerPage)]
        nextIndex += 10
        data.append(contentsOf: fetchedData)
    }
    
}



struct Pagination_Previews: PreviewProvider {
    static var previews: some View {
        Pagination()
    }
}
