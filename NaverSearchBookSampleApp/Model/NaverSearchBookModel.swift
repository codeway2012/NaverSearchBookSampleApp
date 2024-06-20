//
//  NaverSearchBookModel.swift
//  NaverSearchBookSampleApp
//
//  Created by user on 6/18/24.
//

import UIKit

// MARK: - Decodable

struct NaverSearchBookResult: Decodable {
	let lastBuildDate: String
	let total, start, display: Int
	let items: [Item]
	
	struct Item: Decodable {
		let title: String
		let link: String
		let image: String
		let author, discount, publisher, pubdate: String
		let isbn, description: String
	}
}

struct NaverSearchError: Decodable, Error  {
	let errorMessage: String
	let errorCode: String
}

// MARK: - Entity

struct NaverSearchBookAPIParams {
	let query: String
	let display: String
	let start: String
	
	init(query: String,
		 display: String = "20", start: String = "1") {
		self.query = query
		self.display = display
		self.start = start
	}
}

struct Book {
	let title: String
	let link: String
	let imageLink: String
	let author: String
	let discount: String
	let publisher: String
	let pubdate: String
	let isbn: String
	let description: String
	var mainTitle: String
	var subTitle: String
	var image: UIImage
	
	init(_ item: NaverSearchBookResult.Item) {
		self.title = item.title
		self.link = item.link
		self.imageLink = item.image
		self.author = item.author
		self.discount = item.discount
		self.publisher = item.publisher
		self.pubdate = item.pubdate
		self.isbn = item.isbn
		self.description = item.description
		
		if let range = item.title.range(of: " (") {
			self.mainTitle = String(item.title[..<range.lowerBound])
			self.subTitle = String(item.title[range.lowerBound...])
			
			let text = self.subTitle
			let startIndex = text.index(text.startIndex, offsetBy: 2)
			let endIndex = text.index(text.endIndex, offsetBy: -1)
			self.subTitle = String(text[startIndex..<endIndex])
		} else {
			self.mainTitle = item.title
			self.subTitle = ""
		}
		
		self.image = UIImage(systemName: "photo") ?? UIImage()
	}
	
}

// MARK: - Model Class
class NaverSearchBookModel {
	
	// MARK: - Properties
	
	var naverSearchBookAPI = NaverSearchBookAPI()
	var naverSearchBookListDelegate: NaverSearchBookListDelegate?
	var naverSearchBookDetailDelegate: NaverSearchBookDetailDelegate?
	var bookList: [Book] = []
	var book: Book?
	
	// MARK: - Func
	
	func searchBookList(query: String) {
		print("Model searchBookList")
		Task { await requestData(params: NaverSearchBookAPIParams(query: query)) }
	}
	
	private func requestData(params: NaverSearchBookAPIParams) async {
		do {
			self.bookList = []
			
			let naverSearchBookResult = try await naverSearchBookAPI
				.searchBook(
					query: params.query,
					display: params.display,
					start: params.start
				)
			self.bookList = naverSearchBookResult.items.map { Book($0) }
			naverSearchBookListDelegate?.reloadTable()
			
			Task {
				for (index, value) in bookList.enumerated() {
					bookList[index].image = try await naverSearchBookAPI
						.downloadImage(value.imageLink) ?? bookList[index].image
					naverSearchBookListDelegate?
						.reloadTableCell(index: index)
				}
			}
		} catch let error as NaverSearchError {
			print("message: \(error.errorMessage), code: \(error.errorCode)")
		} catch {
			print("error: \(error)")
		}
	}
	
	func naverSearchBookListCount() -> Int {
		NSLog("Model naverSearchBookListCount - \(bookList.count)")
		return bookList.count
	}
	
}

// MARK: - SampleData
extension NaverSearchBookModel {
	func sampleBookList() -> Void {
		guard let fileUrl = Bundle.main
			.url(forResource: "SampleJSON", withExtension: "json") else {
			print("파일을 찾을 수 없습니다.")
			return
		}
		
		do {
			let naverSearchBookResultData = try Data(contentsOf: fileUrl)
			let naverSearchBookResult = try JSONDecoder()
				.decode(NaverSearchBookResult.self, from: naverSearchBookResultData)
	
			self.bookList = naverSearchBookResult.items.map { Book($0) }
			naverSearchBookListDelegate?.reloadTable()
			
			Task {
				for (index, value) in bookList.enumerated() {
					bookList[index].image = try await naverSearchBookAPI
						.downloadImage(value.imageLink) ?? bookList[index].image
					naverSearchBookListDelegate?
						.reloadTableCell(index: index)
					if index == 0 {
						naverSearchBookDetailDelegate?
							.reloadImage(image: bookList[index].image)
					}
				}
			}
		} catch let error as NaverSearchError {
			print("message: \(error.errorMessage), code: \(error.errorCode)")
		} catch {
			print("error: \(error)")
		}
		
	}
}

