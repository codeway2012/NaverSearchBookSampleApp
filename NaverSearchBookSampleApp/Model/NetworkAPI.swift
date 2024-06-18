//
//  NetworkAPI.swift
//  NaverSearchBookSampleApp
//
//  Created by user on 6/18/24.
//

import Foundation

func naverSearchBookAPI(query: String, display: String, start: String)
async throws -> NaverSearchBook {
	
	let baseURL = "https://openapi.naver.com/v1/search/book.json"
	let clientID = "P30m8bv4KbaW9fC3jeCy"
	let clientSecret = "245CRfCnfa"
	
	let urlString = "\(baseURL)?query=\(query)&display=\(display)&start=\(start)"
	
	guard let url = URL(string: urlString) else {
		throw NSError(domain: "Invalid URL", code: 0, userInfo: nil)
	}
	
	var request = URLRequest(url: url)
	request.httpMethod = "GET"
	request.addValue(clientID, forHTTPHeaderField: "X-Naver-Client-Id")
	request.addValue(clientSecret, forHTTPHeaderField: "X-Naver-Client-Secret")
	
	let (data, response) = try await URLSession.shared.data(for: request)
	
	guard let httpResponse = response as? HTTPURLResponse,
		  (200...299).contains(httpResponse.statusCode)
	else {
		throw NSError(
			domain: "HTTP Error",
			code: (response as? HTTPURLResponse)?.statusCode ?? 0,
			userInfo: nil
		)
	}
	
	let bookResponse = try JSONDecoder().decode(NaverSearchBook.self, from: data)
	return bookResponse
}










//
//
//func searchBooks(query: String, completion: @escaping ([Book]?, Error?) -> Void) {
//	guard let url = URL(string: "\(baseURL)?query=\(query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")") else {
//		completion(nil, NSError(domain: "Invalid URL", code: 0, userInfo: nil))
//		return
//	}
//
//	let clientID = "P30m8bv4KbaW9fC3jeCy"
//	let clientSecret = "245CRfCnfa"
//
//	var request = URLRequest(url: url)
//	request.httpMethod = "GET"
//	request.addValue(clientID, forHTTPHeaderField: "X-Naver-Client-Id")
//	request.addValue(clientSecret, forHTTPHeaderField: "X-Naver-Client-Secret")
//
//	URLSession.shared.dataTask(with: request) { data, response, error in
//		if let error = error {
//			completion(nil, error)
//			return
//		}
//
//		guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
//			completion(nil, NSError(domain: "HTTP Error", code: (response as? HTTPURLResponse)?.statusCode ?? 0, userInfo: nil))
//			return
//		}
//
//		guard let data = data else {
//			completion(nil, NSError(domain: "No data received", code: 0, userInfo: nil))
//			return
//		}
//
//		do {
//			let naverSearchBook =
//			try? JSONDecoder().decode(NaverSearchBook.self, from: data)
//			completion(naverSearchBook.items, nil)
//		} catch {
//			completion(nil, error)
//		}
//	}.resume()
//}
