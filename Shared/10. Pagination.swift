//
//  Pagination.swift
//  SwiftUI_Practice
//
//  Created by JW Moon on 2022/06/03.
//

import SwiftUI

//struct Pagination: View {
//    @ObservedObject var viewModel = PaginationViewModel()
//
//    var body: some View {
//        ScrollView {
//            LazyVStack {
//                ForEach(viewModel.data) { datum in
//                    Text(datum.text)
//                        .frame(height: 100)
//                        .font(.system(size: 30))
//                        .onAppear {
//                            guard let index = viewModel.data.firstIndex(where: { $0.id == datum.id }) else { return }
//                            if index == viewModel.data.count - 1 {
//                                viewModel.fetchData()
//                            }
//                        }
//                }
//            }
//        }
//    }
//}

struct Pagination: View {
    @ObservedObject var viewModel = PaginationViewModel()
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(viewModel.data) { datum in
                    Text(datum.text)
                        .frame(height: 100)
                        .font(.system(size: 30))
                }
                if !viewModel.isLastPage {
                    ProgressView()
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                viewModel.fetchData()
                            }
                        }
                }
            }
        }
    }
}

//✅ 데이터 구조체 정의
struct Datum: Identifiable {
    let id = UUID()
    let text: String
    
    init(_ int: Int) {
        self.text = "\(int)"
    }
}

//✅ 서버에서 data를 가져오는 클래스
class DataService {
    
    static let shared = DataService()
    
    // 0 ~ 99까지 숫자가 들어있는 DB
    private let database: [Datum] = {
        var database = [Datum]()
        (0..<100).forEach { i in
            database.append(Datum(i))
        }
        return database
    }()
    
    //✅ 다음 페이지의 시작점과 페이지의 크기를 받아서 데이터와 마지막 페이지 여부를 리턴해주는 함수
    func fetchData(nextIndex: Int, dataPerPage: Int) -> (data: [Datum], isLastPage: Bool) {
        let data = Array(database[nextIndex..<(nextIndex + dataPerPage)])
        let isLastPage = nextIndex + dataPerPage > database.count - 1 ? true : false
        return (data: data, isLastPage: isLastPage)
    }
}



class PaginationViewModel: ObservableObject {
    // VStack에 보여줄 데이터
    @Published var data = [Datum]()
    
    private let dataPerPage = 10 //👉 page 별 데이터
    private var nextIndex = 0 //👉 다음 page의 첫 index
    var isLastPage: Bool = false //👉 현재 page가 마지막 페이지인지 여부
    
    
    // view model을 init하면 데이터를 fetch 해온다.
    init() {
        fetchData()
    }
    
    // 데이터베이스에서 데이터를 가져오는 함수
    func fetchData() {
        guard isLastPage == false else { return } //👉 현재 페이지가 마지막 페이지라면 API 호출 하지 않음.
        // DB에서 새로운 데이터와 isLastPage 값을 가져온다.
        let fetchedData = DataService.shared.fetchData(nextIndex: nextIndex, dataPerPage: dataPerPage)
        
        // 배열에 새로 들어온 데이터 추가
        data.append(contentsOf: fetchedData.data)
        
        // 다음 index와 마지막 페이지인지 여부 업데이트
        nextIndex += dataPerPage
        isLastPage = fetchedData.isLastPage
    }
}



struct Pagination_Previews: PreviewProvider {
    static var previews: some View {
        Pagination()
    }
}
