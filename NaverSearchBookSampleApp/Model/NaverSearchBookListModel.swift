//
//  NaverSearchBookModel.swift
//  NaverSearchBookSampleApp
//
//  Created by user on 6/18/24.
//

import UIKit

// MARK: - Model Class
class NaverSearchBookListModel {
    
    // MARK: - Properties
    
    var naverSearchBookAPI = NaverSearchBookAPI()
    var naverSearchBookListDelegate: NaverSearchBookListDelegate?
    var bookList: [Book] = []
    
    // MARK: - Methods
    func naverSearchBookListCount() -> Int {
        print("Model naverSearchBookListCount - \(bookList.count)")
        return bookList.count
    }
    
    func searchBookList(query: String) {
        print("Model searchBookList")
        Task {
            await refreshTableWithRequestedBookList(query: query)
            await refreshCellsWithDownloadedImages()
        }
    }
    
    private func refreshTableWithRequestedBookList(query: String) async {
        let resultBookList: NaverSearchBookResult
        switch await naverSearchBookAPI.searchBook(query: query) {
            case .success(let data):
                resultBookList = data
            case .failure(let error):
                print("NaverSearchBookListModel requestData Error: \(error.localizedDescription)")
                return
        }
        self.bookList = resultBookList.items.map { Book($0) }
        await naverSearchBookListDelegate?.reloadTable()
    }
    
    private func refreshCellsWithDownloadedImages() async {
        for (index, value) in bookList.enumerated() {
            if let downloadedImage = await naverSearchBookAPI.downloadImage(value.imageLink) {
                bookList[index].image = downloadedImage
                await naverSearchBookListDelegate?.reloadTableCell(index: index)
            }
        }
    }
}

// MARK: - SampleData
extension NaverSearchBookListModel {
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

