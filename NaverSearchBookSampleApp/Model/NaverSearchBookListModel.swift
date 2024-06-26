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
	
	// MARK: - Func
	
	func searchBookList(query: String) {
		print("Model searchBookList")
		Task { await requestData(query: query) }
	}
	
	private func requestData(query: String) async {
        self.bookList = []
        
        let naverSearchBookResult = await naverSearchBookAPI
            .searchBook(query: query)
        
        let resultBookList: NaverSearchBookResult
        switch naverSearchBookResult {
            case .success(let result):
                resultBookList = result
            case .failure(let error):
                print("NaverSearchBookListModel requestData Error: \(error.localizedDescription)")
                return
        }
        
        self.bookList = resultBookList.items.map { Book($0) }
        naverSearchBookListDelegate?.reloadTable()
        
        for (index, value) in bookList.enumerated() {
            bookList[index].image = await naverSearchBookAPI
                .downloadImage(value.imageLink) ?? bookList[index].image
            naverSearchBookListDelegate?
                .reloadTableCell(index: index)
        }
	}
	
	func naverSearchBookListCount() -> Int {
		print("Model naverSearchBookListCount - \(bookList.count)")
		return bookList.count
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

