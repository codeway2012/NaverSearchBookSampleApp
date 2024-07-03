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
    
    var naverSearchBookAPI = NaverSearchBookAPI()
    weak var naverSearchBookListDelegate: BookListDelegate?
    var bookList: [Book] = []
    var params: (query: String, nextStart: Int, display: Int) = ("iOS 프로그래밍", 0, 0)
    var isFetching: Bool = false
    var isAllDataLoad: Bool = false
    var triggerIndex: Int { return bookList.count - 12 }
    var currentIndexPaths: [IndexPath] {
        let index : (start: Int, end: Int)
        index.start = params.nextStart - params.display - 1
        index.end = params.nextStart - 1
        return (index.start..<index.end)
            .map { IndexPath(row: $0, section: 0) }
    }
    
    // MARK: - Methods
    
    func naverSearchBookListCount() -> Int {
        print("Model naverSearchBookListCount - \(bookList.count)")
        return bookList.count
    }
    
    func searchBookList() {
        print("Model searchBookList")
        bookList.removeAll()
        params = (query: params.query, nextStart: 1, display: 15)
        Task {
            await naverSearchBookListDelegate?.reloadTable()
            isFetching = true
            await refreshTableWithRequestedBookList()
            await refreshCellsWithDownloadedImages()
            isFetching = false
        }
    }
    
    func searchBookListPrefetching() {
        print("searchBookListPrefetching")
        Task {
            isFetching = true
            await refreshTableWithRequestedBookList()
            await refreshCellsWithDownloadedImages()
            isFetching = false
        }
    }
    
    private func refreshTableWithRequestedBookList() async {
        let resultBookList: NaverSearchBookResult
        switch await naverSearchBookAPI.searchBook(params: params) {
            case .success(let data):
                resultBookList = data
            case .failure(let error):
                print("NaverSearchBookListModel requestData Error: \(error.localizedDescription)")
                return
        }
        
        params.nextStart = resultBookList.start + resultBookList.display
        params.display = resultBookList.display
        isAllDataLoad = resultBookList.display == 0 || params.nextStart > 1000
        bookList.append(contentsOf: resultBookList.items.map { Book($0) })
        await naverSearchBookListDelegate?.insertTableRows(indexPaths: currentIndexPaths)
    }
    
    private func refreshCellsWithDownloadedImages() async {
        let currentStart = params.nextStart - params.display - 1
        let lastBookList = bookList.suffix(params.display)
        for (index, value) in lastBookList.enumerated() {
            let currentIndex = index + currentStart
            if let downloadedImage = await naverSearchBookAPI.downloadImage(value.imageLink) {
                bookList[currentIndex].image = downloadedImage
            }
        }
        await naverSearchBookListDelegate?.reloadTableRows(indexPaths: currentIndexPaths)
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

