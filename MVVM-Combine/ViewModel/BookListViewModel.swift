//
//  NaverSearchBookModel.swift
//  NaverSearchBookSampleApp
//
//  Created by user on 6/18/24.
//

import UIKit

// MARK: - Model Class
class BookListViewModel {
    
    // MARK: - Properties
    
    weak var naverSearchBookListDelegate: BookListDelegate?
    var naverSearchBookAPI = NaverSearchBookAPI()
    var isFetchingNaverSearchBookAPI: Bool = false
    var isAllDataLoadSearchQuery: Bool = false
    var bookList: [Book] = []
    var prefetchingTriggerIndex: Int { return bookList.count - 10 }
    var params: (query: String, nextStart: Int, display: Int) = ("iOS 프로그래밍", 0, 0)
    var indexPaths: [IndexPath] {
        let index : (start: Int, end: Int)
        index.start = params.nextStart - params.display - 1
        index.end = params.nextStart - 1
        return (index.start..<index.end)
            .map { IndexPath(row: $0, section: 0) }
    }
    
    // MARK: - Methods
    
    func naverSearchBookListCount() -> Int {
        print("ViewModel naverSearchBookListCount - \(bookList.count)")
        return bookList.count
    }
    
    func searchBookList() {
        print("ViewModel searchBookList")
        bookList.removeAll()
        isAllDataLoadSearchQuery = false
        params = (query: params.query, nextStart: 1, display: 20)
        Task {
            await naverSearchBookListDelegate?.reloadTable()
            await refreshTableWithRequestBookList()
            await refreshCellsWithDownloadBookImages()
        }
    }
    
    func searchBookListPrefetching() {
        print("searchBookListPrefetching")
        Task {
            await refreshTableWithRequestBookList()
            await refreshCellsWithDownloadBookImages()
        }
    }
    
    private func refreshTableWithRequestBookList() async {
        isFetchingNaverSearchBookAPI = true
        let resultBookList: NaverSearchBookResult
        switch await naverSearchBookAPI.fetch(params: params) {
            case .success(let data):
                resultBookList = data
            case .failure(let error):
                print("NaverSearchBookListModel requestData Error: \(error.localizedDescription)")
                return
        }
        
        params.nextStart = resultBookList.start + resultBookList.display
        params.display = resultBookList.display
        isAllDataLoadSearchQuery = resultBookList.display == 0 || params.nextStart > 1000
        bookList.append(contentsOf: resultBookList.items.map { Book($0) })
        await naverSearchBookListDelegate?.insertTableRows(indexPaths: indexPaths)
    }
    
    private func refreshCellsWithDownloadBookImages() async {
        isFetchingNaverSearchBookAPI = false
        let currentStart = params.nextStart - params.display - 1
        let lastBookList = bookList.suffix(params.display)
        for (index, value) in lastBookList.enumerated() {
            let currentIndex = index + currentStart
            if let downloadedImage = await naverSearchBookAPI.downloadImage(value.imageLink) {
                bookList[currentIndex].image = downloadedImage
            }
        }
        await naverSearchBookListDelegate?.reloadTableRows(indexPaths: indexPaths)
    }
}

// MARK: - SampleData
extension BookListViewModel {
    static func sampleBookList() -> [Book] {
        guard let fileUrl = Bundle.main
            .url(forResource: "SampleJSON", withExtension: "json") else {
            print("SampleJSON.json 파일을 찾을 수 없습니다.")
            return [Book]()
        }
        
        do {
            let naverSearchBookResultData = try Data(contentsOf: fileUrl)
            let naverSearchBookResult = try JSONDecoder()
                .decode(NaverSearchBookResult.self, from: naverSearchBookResultData)
            return naverSearchBookResult.items.map( { Book($0) } )
        } catch {
            print(APIRequestError.successDataDecodingFailed(error))
            return [Book]()
        }
    }
}

