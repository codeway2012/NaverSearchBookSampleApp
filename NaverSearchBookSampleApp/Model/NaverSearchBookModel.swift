//
//  NaverSearchBookModel.swift
//  NaverSearchBookSampleApp
//
//  Created by user on 6/18/24.
//

import UIKit

// MARK: - Codable Entity

struct NaverSearchBookResult: Codable {
	let lastBuildDate: String
	let total, start, display: Int
	let items: [Item]
	
	struct Item: Codable {
		let title: String
		let link: String
		let image: String
		let author, discount, publisher, pubdate: String
		let isbn, description: String
	}
}

struct NaverSearchError: Codable, Error  {
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
	var book: Book?
	
	var bookList: [Book] = [] {
		didSet {
			naverSearchBookListDelegate?.tableReload()
		}
	}
	
	// MARK: - Func
	
	func searchBookList(query: String) {
		print("Model searchBookList")
		requestData(params: NaverSearchBookAPIParams(query: query))
	}
	
	private func requestData(params: NaverSearchBookAPIParams) {
		Task {
			do {
				self.bookList = []
				
				let naverSearchBook = try await naverSearchBookAPI
					.searchBook(
						query: params.query,
						display: params.display,
						start: params.start
					)
				
				var bookListTemp: [Book] = []
				for item in naverSearchBook.items {
					var book = Book(item)
					book.image = try await naverSearchBookAPI
						.downloadImage(book.imageLink) ?? book.image
					bookListTemp.append(book)
				}
				
				self.bookList = bookListTemp
			} catch let error as NaverSearchError {
				print("message: \(error.errorMessage), code: \(error.errorCode)")
			} catch {
				print("exption: \(error)")
			}
		}
		
	}
	
	func naverSearchBookListCount() -> Int {
		NSLog("Model naverSearchBookCount - \(bookList.count)")
		return bookList.count
	}
	
}
