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

import Foundation

// MARK: - NaverSearchBook
struct NaverSearchBook: Codable {
	let lastBuildDate: String
	let total, start, display: Int
	let items: [Item]
}

// MARK: - Item
struct Item: Codable {
	let title: String
	let link: String
	let image: String
	let author, discount, publisher, pubdate: String
	let isbn, description: String
}

class NaverSearchBookModel {
	func requestData() {
		Task {
			do {
				let naverSearchBook = try await naverSearchBookAPI(
					query: "프로그래밍", display: "3", start: "1")
				print("Books: \(naverSearchBook)")
			} catch {
				print("Error: \(error.localizedDescription)")
			}
		}
	}
	
}
