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

struct NaverSearchBook: Codable {
	let lastBuildDate: String
	let total, start, display: Int
	let items: [Item]
}

struct Item: Codable {
	let title: String
	let link: String
	let image: String
	let author, discount, publisher, pubdate: String
	let isbn, description: String
}

struct ErrorNaverSearchBook: Codable {
	let errorMessage: String
	let errorCode: String
}

// MARK: - Model

struct NaverSearchBookAPIParams {
	let query: String
	let display: String = "3"
	let start: String = "1"
}

class NaverSearchBookModel {
	
	// MARK: - Properties
	
	var naverSearchBookListDelegate: NaverSearchBookListDelegate?

	var bookList: [Item] = [] {
		didSet {
			print("didSet - bookList")
			print("bookList - \(bookList)")
			naverSearchBookListDelegate?.tableReload()
			?? print("not delegate tableReload")
		}
	}
	
	
	
	// MARK: - Func
	
	func searchBookList(query: String) {
		print("func - searchBookList")
		requestData(params: NaverSearchBookAPIParams(query: query))
	}
	
	private func requestData(params: NaverSearchBookAPIParams) {
		
		Task {
			do {
				let naverSearchBook = try await naverSearchBookAPI(
					query: params.query,
					display: params.display,
					start: params.start)
				print("naverSearchBook : \(naverSearchBook)")
				bookList = naverSearchBook.items
			} catch {
				print("Error: \(error.localizedDescription)")

			}
		}
		
	}
	
	func NaverSearchBookCount() -> Int {
		print("count - \(bookList.count)")
		return bookList.count
	}

}
