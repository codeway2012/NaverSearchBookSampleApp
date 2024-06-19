//
//  NaverSearchBookModel.swift
//  NaverSearchBookSampleApp
//
//  Created by user on 6/18/24.
//
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let naverSearchBook = try? JSONDecoder().decode(NaverSearchBook.self, from: jsonData)

import UIKit

// MARK: - Codable

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

// MARK: - Model
struct NaverSearchBookAPIParams {
	let query: String
	let display: String
	let start: String
	
	init(query: String,
		 display: String = "3", start: String = "1") {
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
	var image: UIImage? = UIImage(systemName: "photo")
	
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
	}

}

class NaverSearchBookModel {
	
	// MARK: - Properties
	
	var naverSearchBookListDelegate: NaverSearchBookListDelegate?
	
	var bookList: [Book] = []
	
	// MARK: - Func
	
	func searchBookList(query: String) {
		print("Model searchBookList")
		requestData(params: NaverSearchBookAPIParams(query: query))
	}
	
	private func requestData(params: NaverSearchBookAPIParams) {
		Task {
			do {
				let naverSearchBook = try await naverSearchBookAPI(
					query: params.query,
					display: params.display,
					start: params.start)
				
				var bookListTemp: [Book] = []
				for item in naverSearchBook.items {
					var book = Book(item)
					book.image = try await downloadImage(book.imageLink)
					bookListTemp.append(book)
				}
				
				self.bookList = bookListTemp
				naverSearchBookListDelegate?.tableReload()
			} catch let error as NaverSearchError {
				print("message: \(error.errorMessage), code: \(error.errorCode)")
			} catch {
				print("exption: \(error)")
			}
		}
		
	}
	
	func downloadImage(_ imageLink: String)
	async throws -> UIImage? {
		guard let url = URL(string: imageLink) else { return UIImage() }
		let (data, _) = try await URLSession.shared.data(from: url)
		return UIImage(data: data)
	}
	
	func naverSearchBookCount() -> Int {
		NSLog("Model naverSearchBookCount - \(bookList.count)")
		return bookList.count
	}
	
}
